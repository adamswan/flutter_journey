const express = require("express");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const uuid = require("uuid");
const cors = require("cors");

const app = express();
const PORT = process.env.PORT || 3000;

// 中间件
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 模拟数据库
// ! 用户
const users = [
  {
    id: "123456",
    username: "1",
    password: bcrypt.hashSync("2", 10), // 使用 bcrypt 加密初始密码
  },
];
const trips = [];

// 密钥
const SECRET_KEY = "your-secret-key-here";

// 工具函数
const generateToken = (user) => {
  return jwt.sign(
    { id: user.id, username: user.username },
    SECRET_KEY,
    { expiresIn: "1h" }
  );
};

const verifyToken = (req, res, next) => {
  const token = req.headers["authorization"];

  if (!token) {
    return res
      .status(403)
      .send({ message: "No token provided" });
  }

  jwt.verify(
    token.replace("Bearer ", ""),
    SECRET_KEY,
    (err, decoded) => {
      if (err) {
        return res
          .status(401)
          .send({ message: "Unauthorized" });
      }
      req.user = decoded;
      next();
    }
  );
};

// 账户管理API
app.post("/api/account/register", async (req, res) => {
  try {
    const { username, password, email, phone, avatar } =
      req.body;

    // 检查用户名是否已存在
    const existingUser = users.find(
      (u) => u.username === username
    );
    if (existingUser) {
      return res
        .status(400)
        .send({ message: "Username already exists" });
    }

    // 加密密码
    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = {
      id: uuid.v4(),
      username,
      password: hashedPassword,
      email,
      phone,
      avatar,
      createdAt: new Date(),
      updatedAt: new Date(),
      isActive: true,
    };

    users.push(newUser);
    res
      .status(201)
      .send({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).send({
      message: "Registration failed",
      error: error.message,
    });
  }
});

// 登录
app.post("/api/account/login", async (req, res) => {
  try {
    const { username, password } = req.query;

    const user = users.find((u) => u.username === username);

    if (!user) {
      return res
        .status(404)
        .send({ message: "User not found" });
    }

    const isPasswordValid = await bcrypt.compare(
      password,
      user.password
    );

    if (!isPasswordValid) {
      return res
        .status(401)
        .send({ message: "Invalid credentials" });
    }

    const token = generateToken(user);

    res.send({
      statusCode: 200,
      code: 0,
      data: token,
    });
  } catch (error) {
    res.status(500).send({
      message: "Login failed",
      error: error.message,
    });
  }
});

app.get("/api/account/profile", verifyToken, (req, res) => {
  try {
    const user = users.find((u) => u.id === req.user.id);
    if (!user) {
      return res
        .status(404)
        .send({ message: "User not found" });
    }

    // 不返回敏感信息
    const { password, ...userData } = user;
    res.send(userData);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching profile",
      error: error.message,
    });
  }
});

app.put(
  "/api/account/profile",
  verifyToken,
  async (req, res) => {
    try {
      const { username, email, phone, avatar } = req.body;
      const userIndex = users.findIndex(
        (u) => u.id === req.user.id
      );

      if (userIndex === -1) {
        return res
          .status(404)
          .send({ message: "User not found" });
      }

      // 更新用户信息
      users[userIndex] = {
        ...users[userIndex],
        username: username || users[userIndex].username,
        email: email || users[userIndex].email,
        phone: phone || users[userIndex].phone,
        avatar: avatar || users[userIndex].avatar,
        updatedAt: new Date(),
      };

      res.send({ message: "Profile updated successfully" });
    } catch (error) {
      res.status(500).send({
        message: "Update failed",
        error: error.message,
      });
    }
  }
);

// 旅行行程API
app.post("/api/trip", verifyToken, (req, res) => {
  try {
    const {
      title,
      description,
      startDate,
      endDate,
      destination,
      budget,
    } = req.body;

    const newTrip = {
      id: uuid.v4(),
      title,
      description,
      startDate,
      endDate,
      destination,
      budget,
      userId: req.user.id,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    trips.push(newTrip);
    res.status(201).send(newTrip);
  } catch (error) {
    res.status(500).send({
      message: "Trip creation failed",
      error: error.message,
    });
  }
});

app.get("/api/trip", verifyToken, (req, res) => {
  try {
    const userTrips = trips.filter(
      (trip) => trip.userId === req.user.id
    );
    res.send(userTrips);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching trips",
      error: error.message,
    });
  }
});

app.get("/api/trip/:id", verifyToken, (req, res) => {
  try {
    const trip = trips.find(
      (trip) =>
        trip.id === req.params.id &&
        trip.userId === req.user.id
    );

    if (!trip) {
      return res
        .status(404)
        .send({ message: "Trip not found" });
    }

    res.send(trip);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching trip",
      error: error.message,
    });
  }
});

app.put("/api/trip/:id", verifyToken, (req, res) => {
  try {
    const tripIndex = trips.findIndex(
      (trip) =>
        trip.id === req.params.id &&
        trip.userId === req.user.id
    );

    if (tripIndex === -1) {
      return res
        .status(404)
        .send({ message: "Trip not found" });
    }

    trips[tripIndex] = {
      ...trips[tripIndex],
      ...req.body,
      updatedAt: new Date(),
    };

    res.send({ message: "Trip updated successfully" });
  } catch (error) {
    res.status(500).send({
      message: "Update failed",
      error: error.message,
    });
  }
});

app.delete("/api/trip/:id", verifyToken, (req, res) => {
  try {
    const tripIndex = trips.findIndex(
      (trip) =>
        trip.id === req.params.id &&
        trip.userId === req.user.id
    );

    if (tripIndex === -1) {
      return res
        .status(404)
        .send({ message: "Trip not found" });
    }

    trips.splice(tripIndex, 1);
    res.send({ message: "Trip deleted successfully" });
  } catch (error) {
    res.status(500).send({
      message: "Delete failed",
      error: error.message,
    });
  }
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
