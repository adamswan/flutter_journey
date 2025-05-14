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

// 搜索页的搜索结果
const searchResults = {
  code: 0,
  extra: {},
  msg: "string",
  data: [
    {
      code: "district_152",
      word: "广州",
      type: "district",
      districtname: "广东",
      url: "http://m.ctrip.com/webapp/you/place/152.html",
      isBigIcon: false,
    },
    {
      code: "districtsight_152",
      word: "广州·热门景点",
      type: "sight",
      districtname: "",
      url: "https://m.ctrip.com/webapp/you/sight/152.html",
      isBigIcon: false,
    },
    {
      code: "traveler_317857830",
      word: "广州热雪奇迹",
      type: "plantshipflag",
      districtname: "官方旗舰店",
      url: "https://m.ctrip.com/webapp/you/travelshoot/starBall/indexPage?isHideNavBar=yes&pop=close&autoawaken=close&ct=card&clientAuth=4714D553914CBD9488DE9FD0C288CFB4&sourceFrom=homesearch",
      imageUrl:
        "https://dimg04.c-ctrip.com/images/1n70t12000b0m5afrC8FE_C_180_180.jpg",
      subImageUrl:
        "https://pages.c-ctrip.com/travesnap-j/starBall/blue.png",
      isBigIcon: false,
      sourceType: "starContract",
    },
    {
      code: "sight_6802",
      word: "长隆野生动物世界",
      type: "sight",
      districtname: "广州",
      url: "http://m.ctrip.com/webapp/you/sight/152/6802.html",
      isBigIcon: false,
    },
    {
      code: "sight_107540",
      word: "广州塔",
      type: "sight",
      districtname: "广州",
      url: "http://m.ctrip.com/webapp/you/sight/152/107540.html",
      isBigIcon: false,
    },
    {
      code: "sight_48593",
      word: "长隆欢乐世界",
      type: "sight",
      districtname: "广州",
      url: "http://m.ctrip.com/webapp/you/sight/152/48593.html",
      isBigIcon: false,
    },
    {
      code: "channeltravelsearch_0",
      word: "广州的全部旅游产品",
      type: "channeltravelsearch",
      url: "http://m.ctrip.com/webapp/tour/tours?saleCityId=1&kwd=广州",
      isBigIcon: false,
    },
    {
      code: "hotellist_152",
      word: "广州的酒店",
      type: "hotellist",
      districtname: "广东",
      url: "https://m.ctrip.com/webapp/hotels/list?city=32",
      isBigIcon: false,
    },
  ],
};

// 类别
const category = {
  code: 0,
  data: {
    tabs: [
      {
        labelName: "发现",
        groupChannelCode: "tourphoto_global1",
      },
      {
        labelName: "玩乐",
        groupChannelCode: "xinqitiyan",
      },
      {
        labelName: "酒店",
        groupChannelCode: "hotel",
      },
      {
        labelName: "美食",
        groupChannelCode: "msxwzl",
      },
      {
        labelName: "亲子",
        groupChannelCode: "children",
      },
      {
        labelName: "网红",
        groupChannelCode: "wanghongdakadi",
      },
      {
        labelName: "拍照技巧",
        groupChannelCode: "tab-photo",
      },
    ],
  },
  msg: "SUCCESS.",
};

// 旅拍列表
const travels = {
  code: 0,
  data: {
    total: 50,
    list: [
      {
        type: 1,
        article: {
          articleId: 1001,
          productType: 1,
          sourceType: 2,
          articleTitle: "广州塔夜景",
          content:
            "美丽的珠江边，广州塔在夜晚的灯光下显得格外迷人。",
          author: {
            authorId: 101,
            nickName: "旅行达人小李",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/100/200",
              originalUrl:
                "https://picsum.photos/id/55/100/200",
            },
          },
          images: [
            {
              imageId: 1,
              dynamicUrl:
                "https://picsum.photos/id/56/100/200",
              originalUrl:
                "https://picsum.photos/id/56/100/200",
              width: 800,
              height: 600,
            },
            {
              imageId: 2,
              dynamicUrl:
                "https://picsum.photos/id/57/100/200",
              originalUrl:
                "https://picsum.photos/id/57/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 1234,
          likeCount: 98,
          commentCount: 25,
          poiName: "广州塔",
        },
      },
      {
        type: 2,
        article: {
          articleId: 1002,
          productType: 2,
          sourceType: 1,
          articleTitle: "深圳湾的日出",
          content:
            "清晨在深圳湾看日出，是都市中难得的宁静时刻。",
          author: {
            authorId: 102,
            nickName: "摄影师老张",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/58/100/200",
              originalUrl:
                "https://picsum.photos/id/58/100/200",
            },
          },
          images: [
            {
              imageId: 3,
              dynamicUrl:
                "https://picsum.photos/id/59/100/200",
              originalUrl:
                "https://picsum.photos/id/59/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 987,
          likeCount: 67,
          commentCount: 12,
          poiName: "深圳湾公园",
        },
      },
      {
        type: 1,
        article: {
          articleId: 1003,
          productType: 1,
          sourceType: 2,
          articleTitle: "厦门鼓浪屿",
          content:
            "鼓浪屿是一个充满文艺气息的小岛，适合慢节奏的旅行。",
          author: {
            authorId: 103,
            nickName: "爱拍照的阿花",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/60/100/200",
              originalUrl:
                "https://picsum.photos/id/60/100/200",
            },
          },
          images: [
            {
              imageId: 4,
              dynamicUrl:
                "https://picsum.photos/id/61/100/200",
              originalUrl:
                "https://picsum.photos/id/61/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 2000,
          likeCount: 120,
          commentCount: 30,
          poiName: "鼓浪屿",
        },
      },
      {
        type: 2,
        article: {
          articleId: 1004,
          productType: 2,
          sourceType: 1,
          articleTitle: "成都美食之旅",
          content:
            "成都不仅有火锅，还有各种小吃和茶馆文化。",
          author: {
            authorId: 104,
            nickName: "吃货小王",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/62/100/200",
              originalUrl:
                "https://picsum.photos/id/62/100/200",
            },
          },
          images: [
            {
              imageId: 5,
              dynamicUrl:
                "https://picsum.photos/id/63/100/200",
              originalUrl:
                "https://picsum.photos/id/63/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 1800,
          likeCount: 110,
          commentCount: 28,
          poiName: "成都宽窄巷子",
        },
      },
      {
        type: 1,
        article: {
          articleId: 1005,
          productType: 1,
          sourceType: 2,
          articleTitle: "杭州西湖游记",
          content:
            "三潭印月、雷峰塔、断桥残雪，西湖四季皆美。",
          author: {
            authorId: 105,
            nickName: "江南小居",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/64/100/200",
              originalUrl:
                "https://picsum.photos/id/64/100/200",
            },
          },
          images: [
            {
              imageId: 6,
              dynamicUrl:
                "https://picsum.photos/id/65/100/200",
              originalUrl:
                "https://picsum.photos/id/65/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 1500,
          likeCount: 100,
          commentCount: 20,
          poiName: "西湖",
        },
      },
      {
        type: 2,
        article: {
          articleId: 1006,
          productType: 2,
          sourceType: 1,
          articleTitle: "北京胡同生活",
          content: "走进胡同深处，感受老北京的生活气息。",
          author: {
            authorId: 106,
            nickName: "胡同大爷",
            coverImage: {
              dynamicUrl:
                "https://picsum.photos/id/66/100/200",
              originalUrl:
                "https://picsum.photos/id/66/100/200",
            },
          },
          images: [
            {
              imageId: 7,
              dynamicUrl:
                "https://picsum.photos/id/67/100/200",
              originalUrl:
                "https://picsum.photos/id/67/100/200",
              width: 800,
              height: 600,
            },
          ],
          readCount: 1300,
          likeCount: 80,
          commentCount: 18,
          poiName: "南锣鼓巷",
        },
      },
    ],
  },
  extra: {},
  msg: "string",
};

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

// 搜索
app.get("/api/search", verifyToken, (req, res) => {
  try {
    res.send(searchResults);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching trips",
      error: error.message,
    });
  }
});

// 旅拍频道分类
app.get("/api/category", verifyToken, (req, res) => {
  try {
    res.send(category);
  } catch (error) {
    res.status(500).send({
      message: "Error fetching trips",
      error: error.message,
    });
  }
});

// 旅拍列表
app.get("/api/travels", verifyToken, (req, res) => {
  try {
    res.send(travels);
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
