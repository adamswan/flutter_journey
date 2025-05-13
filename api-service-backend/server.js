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

// ----------模拟数据库
// ! 用户
const users = [
  {
    id: "123456",
    username: "1",
    password: bcrypt.hashSync("2", 10), // 使用 bcrypt 加密初始密码
  },
];

const trips = [];

//! 首页
const homeData = [
  {
    code: 0,
    data: {
      config: {
        searchUrl: "https://www.example.com/search",
      },
      bannerList: [
        {
          icon: "https://images.unsplash.com/photo-1551782450-a2132b4ba21d",
          title: "Banner 1",
          url: "https://example.com/banner1",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://images.unsplash.com/photo-1522205408450-add114ad53fe",
          title: "Banner 2",
          url: "https://example.com/banner2",
          statusBarColor: "#000000",
          hideAppBar: true,
        },
        {
          icon: "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
          title: "Banner 3",
          url: "https://example.com/banner3",
          statusBarColor: "#FF5733",
          hideAppBar: false,
        },
      ],
      localNavList: [
        {
          icon: "https://picsum.photos/id/40/50/50", // 攻略·景点 图标 URL
          title: "攻略·景点",
          url: "/guide",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/43/50/50", // 周边游 图标 URL
          title: "周边游",
          url: "/surroundings",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/13/50/50", // 美食林 图标 URL
          title: "美食林",
          url: "/food",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/35/50/50", // 一日游 图标 URL
          title: "一日游",
          url: "/oneday",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/15/50/50", // 当地攻略 图标 URL
          title: "当地攻略",
          url: "/local_guide",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
      ],
      gridNav: {
        hotel: {
          startColor: "#FFEB3B",
          endColor: "#FFC107",
          mainItem: {
            icon: "https://picsum.photos/seed/hotel-main/200/300",
            title: "豪华酒店",
            url: "/hotel",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item1: {
            icon: "https://picsum.photos/seed/hotel1/200/300",
            title: "五星推荐",
            url: "/hotel/recommend",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item2: {
            icon: "https://picsum.photos/seed/hotel2/200/300",
            title: "特价优惠",
            url: "/hotel/special",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item3: {
            icon: "https://picsum.photos/seed/hotel3/200/300",
            title: "会员专享",
            url: "/hotel/vip",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item4: {
            icon: "https://picsum.photos/seed/hotel4/200/300",
            title: "附近酒店",
            url: "/hotel/nearby",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
        },
        flight: {
          startColor: "#2196F3",
          endColor: "#0D47A1",
          mainItem: {
            icon: "https://picsum.photos/seed/flight-main/200/300",
            title: "航班查询",
            url: "/flight",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item1: {
            icon: "https://picsum.photos/seed/flight1/200/300",
            title: "国内机票",
            url: "/flight/domestic",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item2: {
            icon: "https://picsum.photos/seed/flight2/200/300",
            title: "国际机票",
            url: "/flight/international",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item3: {
            icon: "https://picsum.photos/seed/flight3/200/300",
            title: "特价航班",
            url: "/flight/special",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item4: {
            icon: "https://picsum.photos/seed/flight4/200/300",
            title: "行程管理",
            url: "/flight/manage",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
        },
        travel: {
          startColor: "#4CAF50",
          endColor: "#388E3C",
          mainItem: {
            icon: "https://picsum.photos/seed/travel-main/200/300",
            title: "旅游攻略",
            url: "/travel",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item1: {
            icon: "https://picsum.photos/seed/travel1/200/300",
            title: "热门目的地",
            url: "/travel/popular",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item2: {
            icon: "https://picsum.photos/seed/travel2/200/300",
            title: "自由行",
            url: "/travel/independent",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item3: {
            icon: "https://picsum.photos/seed/travel3/200/300",
            title: "跟团游",
            url: "/travel/group",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
          item4: {
            icon: "https://picsum.photos/seed/travel4/200/300",
            title: "定制路线",
            url: "/travel/custom",
            statusBarColor: "#FFFFFF",
            hideAppBar: false,
          },
        },
      },
      subNavList: [
        {
          icon: "https://picsum.photos/id/23/50/50?grayscale",
          title: "wifi电话卡",
          url: "/booking/flight",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/24/50/50?grayscale",
          title: "保险签证",
          url: "/booking/hotel",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/25/50/50?grayscale",
          title: "外币兑换",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/26/50/50?grayscale",
          title: "购物",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/27/50/50?grayscale",
          title: "当地向导",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/28/50/50?grayscale",
          title: "自由行",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/29/50/50?grayscale",
          title: "境外玩乐",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/30/50/50?grayscale",
          title: "录屏卡",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/31/50/50?grayscale",
          title: "信用卡",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
        {
          icon: "https://picsum.photos/id/32/50/50?grayscale",
          title: "更多",
          url: "/booking/ticket",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
      ],

      salesBox: {
        icon: "https://picsum.photos/id/63/20/20",
        moreUrl: "https://example.com/more",
        bigCard1: {
          icon: "https://picsum.photos/id/42/200/300?grayscale",
          title: "携程超级会员",
          url: "/sale/limited",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },

        bigCard2: {
          icon: "https://picsum.photos/id/44/200/300?grayscale",
          title: "爆款酒店",
          url: "/sale/vip",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },

        smallCard1: {
          icon: "https://picsum.photos/id/57/200/100",
          title: "球迷卡限时秒",
          url: "/sale/flight",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },

        smallCard2: {
          icon: "https://picsum.photos/id/58/200/100",
          title: "领券中心",
          url: "/sale/hotel",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },

        smallCard3: {
          icon: "https://picsum.photos/id/59/200/100",
          title: "会员福利",
          url: "/sale/local",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },

        smallCard4: {
          icon: "https://picsum.photos/id/60/200/100",
          title: "携程优品商场",
          url: "/sale/driving",
          statusBarColor: "#FFFFFF",
          hideAppBar: false,
        },
      },
    },
    extra: {},
    msg: "string",
  },
];

// ----------模拟数据库

// 密钥
const SECRET_KEY = "your-secret-key-here";

// 生成 token
const generateToken = (user) => {
  return jwt.sign(
    { id: user.id, username: user.username },
    SECRET_KEY,
    { expiresIn: "1h" }
  );
};

// 验证 token
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

// 注册
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

// 获取用户信息
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

// 更新用户信息
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

// 获取首页信息
app.get("/api/home", verifyToken, (req, res) => {
  try {
    res.send(homeData);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching trips",
      error: error.message,
    });
  }
});

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
