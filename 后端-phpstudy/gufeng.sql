/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : gufeng

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 11/12/2020 19:19:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gufeng_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `gufeng_access_tokens`;
CREATE TABLE `gufeng_access_tokens`  (
  `token` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gufeng_access_tokens
-- ----------------------------
INSERT INTO `gufeng_access_tokens` VALUES ('5fd3513faf851', 1607684415);
INSERT INTO `gufeng_access_tokens` VALUES ('5fd3517ce10a1', 1607684476);
INSERT INTO `gufeng_access_tokens` VALUES ('5fd3516acf388', 1607684458);
INSERT INTO `gufeng_access_tokens` VALUES ('5fd351599190f', 1607684441);
INSERT INTO `gufeng_access_tokens` VALUES ('5fd35148ca99e', 1607684424);

-- ----------------------------
-- Table structure for gufeng_articles
-- ----------------------------
DROP TABLE IF EXISTS `gufeng_articles`;
CREATE TABLE `gufeng_articles`  (
  `art_id` int(11) NOT NULL AUTO_INCREMENT,
  `art_cate` int(10) NULL DEFAULT NULL,
  `art_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `art_uid` int(11) NULL DEFAULT NULL,
  `art_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `art_createtime` int(11) NULL DEFAULT NULL,
  `art_browse` int(11) NULL DEFAULT 0,
  `art_agree` int(11) NOT NULL,
  `art_icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `art_download` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `art_real_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`art_id`) USING BTREE,
  INDEX `art_uid`(`art_uid`) USING BTREE,
  INDEX `art_cate`(`art_cate`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gufeng_articles
-- ----------------------------
INSERT INTO `gufeng_articles` VALUES (123, 3, '壁纸喵', 41, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d693ac96c.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d694e37ba.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d6963cf77.png\"}]', 1607653015, 21, 4, 'http://139.196.197.242/imgs/5fd2d692bfb3e.png', '210.44.14.39', '\"<p>壁纸喵是一个简洁唯美的高质量壁纸软件。</p><p>它的壁纸质量非常高，数量非常丰富，并且它对壁纸进行了精心的分类，包括：动物、视觉、卡通等等，而且它不仅支持竖屏壁纸，也支持横屏壁纸，甚至支持4K专区。</p><p>最重要的是该软件完全免费，软件的所有壁纸全部支持免费下载，支持免费设置为壁纸，而且没有任何广告，支持多种配色主题任意切换，并且实时更新，跟新频率还非常快。</p><p>使用方法技巧：</p><p>1、不仅可以找到网络上的壁纸，也可以制作属于自己的纯色壁纸或者渐变壁纸；</p><p>2、具有抖音类浏览模式，也就是可以像刷抖音一样来刷壁纸，刷到喜欢的壁纸就可以点点小红心，收藏起来；</p><p>3、有许多颜色的主题，每天换一个都可以。</p><p>使用体验：</p><p>使用这款软件，解决了许多人因为找不到称心如意的壁纸的难题，同时它完全免费，不用担心需要花钱购买。它的壁纸数量极其庞大，使用起来不用担心找不到想要的风格，而且它的设计简约，不会给人一种审美疲劳的感觉。</p>\"');
INSERT INTO `gufeng_articles` VALUES (122, 1, '鹅说', 41, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d59eb08e7.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d59feb160.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d5a13ae8e.jpg\"}]', 1607652770, 8, 1, 'http://139.196.197.242/imgs/5fd2d59dab934.png', '210.44.14.36', '\"<p>一款用图看世界的APP，一图一文，有趣的冷知识，看图就能秒懂。人们看惯了文字多的飞起的新闻资讯，公众号文，那就来鹅说，体验不一样的感觉。特别推荐鹅说中的一个功能：里程碑，可以知道过去的今天发生了什么奇闻异事。</p><p>使用方法技巧：</p><p>1、用户进入应用界面后，能看到一张张构图精致的封面卡片，而知识就存在于这些卡片中；</p><p>2、没有哪里不会点哪里的功能，而是每天为你推送一则平时不会留意的小知识；</p><p>3、具有知识树功能，在卡片之间建立起相应的连接点，把每天的内容整合为一个巨大的知识网络。</p><p>使用体验：</p><p>板块简洁，将知识归纳整理做成卡片形式，让人感觉知识脉络很清晰，而且看一张卡片消耗的时间不多，在碎片时间里可以看看，知识涉及面还是很广的；令人比较满意的是应用里暂时没有植入广告；里程碑功能让人眼前一亮。</p><p>但是该软件的更新速度不是很快，更新时间和更新量不定，有时一天一张，有时没有，有时三四张；最新板块不可以选择日期，想看前面的内容还要自己动手翻，也没有搜索功能。</p>\"');
INSERT INTO `gufeng_articles` VALUES (130, 1, '0305', 41, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d431bc3be.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d432f36b3.png\"}]', 1607652335, 14, 1, 'http://139.196.197.242/imgs/5fd2d3ef11c95.png', 'http://www.hi0305.com/', '\"<p>一款非常有创意的APP，在这款APP中，无性别、无头像、无昵称，每个用户的昵称都是宇宙中真实存在且独一无二的星星编号。APP界面简约，没有花里胡哨，给人很舒服的感觉。</p><p>APP最受欢迎的是有一个共同的时空留言板，你可以看到别人的留言，也可以自己留言，所有来过这个时空的人，都可以直接发起聊天。就像0305中的三句宣传语：在每一个“此刻”背后，每个人都在经历着自己的故事；和刚好遇见的人，一起安心说会儿话吧；无性别、无头像、无昵称，每个人的名字是一颗星星的编号。</p><p>使用方法技巧：</p><p>1、遇到自己喜欢的时空可以右上角点开然后收藏加喜欢，就能在主页中找到；</p><p>2、进入时空后，点击右上角可以查看留言板，可以写下自己的心情或者故事；</p><p>3、在时空里遇到聊得投机的小伙伴们可以和他们组队形成固定的群组，点开列表就能看到添加；</p><p>4、退出时空后，所有的聊天记录会消失，但是私聊的不会；</p><p>5、安卓没有消息弹窗提示，苹果有。</p><p>使用体验：相比其他的社交软件，0305产品本身和用户都显得更佛系，产品虽然具备聊天连麦的功能，但是藏得很深，主打的时空功能像是一个巨大的画廊，每一个时空都像一幅作品，你可以在任何一幅你感兴趣的画作前驻足，在留言板留下感想，也可以在时空中交流评论作品，更可以在不感兴趣的时候转身离开。音乐时空是0305另一个让人眼前一亮的点，这种体验就像是当你在唱片店没有目的的闲晃，不知道自己想听些什么的时候看到另一个人沉浸在一首你没听过的歌中，你会不会对这首歌有点好奇？现实生活中你当然不会走过去要求对方分你一只耳机一起听，但是在0305，你只要点进一个活跃的音乐时空就可以了，这种同步听歌细节处理真的太暖了。</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d3bc87bcb.jpg\\\" alt=\\\"图片\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d3bc90851.jpg\\\" alt=\\\"图片\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d3bc8fd94.jpg\\\" alt=\\\"图片\\\"></p>\"');
INSERT INTO `gufeng_articles` VALUES (113, 2, '轻阅', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf068dfe4.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf07c86a1.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf0905926.jpg\"}]', 1607650597, 15, 1, 'http://139.196.197.242/imgs/5fd2cd24142aa.png', 'http://config.juapp7.com:20007/down_file?id=ea189dc6efa6d26b019dd812c7d15b19_7&sign=20E707433C210F2279C00226B15A4AD3', '\"<p>看小说全部免费，界面比较简单，找书很方便，不会出现任何广告;小说类型是真的很多，而且还有各大排行，不知道看什么就在排行榜里找;书籍搜索比较方便，因为资源比较多，所以很容易找到自己想看的小说。</p>\"');
INSERT INTO `gufeng_articles` VALUES (111, 3, '歌词适配', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cb6ef33e3.jpg\"}]', 1607650077, 9, 1, 'http://139.196.197.242/imgs/5fd2cb1c63be2.png', 'http://config.juapp7.com:20007/down_file?id=403454ebc9c0ac2c6ad9a444cf2745c2_5&sign=7DE8E365D9CC96C365AFBED284109978', '\"<p>歌词适配是款音乐下载工具，可以免费让你下载全网的各种收费音乐，操作方便；界面是没有任何的广告的，且下载速度快，简单实用；支持无损、标准以及高品和MV等，下载速度快；可以进行歌词或者关键字以及歌手等进行一键搜索</p>\"');
INSERT INTO `gufeng_articles` VALUES (133, 3, '蜗牛睡眠', 41, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d1cda226c.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d1ced5140.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d1d029e95.png\"}]', 1607651793, 29, 193, 'http://139.196.197.242/imgs/5fd2d1cc9d675.png', 'http://www.seblong.com/', '\"<p>蜗牛睡眠一款基于用户睡眠行为分析的免费APP，可用于记录睡眠情况，了解睡眠效率及质量。蜗牛睡眠-作为睡眠健康伴侣应用，将陪伴你度过夜晚美好的睡眠时间，培养你的良好睡眠习惯，感知并记录下你的睡眠过程，为你呈现可视化的睡眠报告，帮你更了解你的睡眠。同时，该应用还具有智能闹钟提醒、催眠曲播放及下载等功能。</p><p>使用方法技巧：</p><p>1、记录用户睡眠数据功能，包括睡眠时长、环境噪音、萌梦话监测、鼾声记录以及个性化记录；</p><p>2、对用户睡眠情况进行推演，包括入睡时间、入睡时长、深睡时间、浅睡时间、翻身次数等；</p><p>使用后体验：</p><p>蜗牛睡眠围绕着睡觉这一核心功能做了很多文章，通过很多指标在多个维度对用户的睡眠情况进行了总结，优点非常多，一方面是为用户提供的睡眠提供数据参考，让有需要的用户可以借此调整自己的睡眠，改善自己的睡眠情况；另一方面是满足用户对于自己睡觉时的好奇心。当然，在我体验过程中也发现了很多不可忽视的缺点，比如说一级界面的按钮太多太过于冗杂，核心功能不突出；社区和商城有些喧宾夺主导致产品整体功能点模糊；在使用过程中还发现了一些bug，比如时不时会出现闪退的情况，起床之后点击起床的完成着陆页面的按钮没有标签，另外在一些具有黑胶唱片动效的音乐播放界面的动画出现了问题。</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d1c8260f0.jpg\\\" alt=\\\"图片\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d1c832933.jpg\\\" alt=\\\"图片\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d1c83e002.jpg\\\" alt=\\\"图片\\\"></p>\"');
INSERT INTO `gufeng_articles` VALUES (132, 3, '实用工具箱', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2ca3e717bc.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2ca3fba22d.png\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2ca4108a7e.png\"}]', 1607649858, 25, 12, 'http://139.196.197.242/imgs/5fd2ca3d6d16d.png', 'http://config.juapp7.com:20007/down_file?id=6d61027f5d08f0522ce85d3685275ed8_11&sign=0CA31BE9C1D12FCE77DFD6EB005F5007', '\"<p>实用工具箱app 是一款功能非常齐全的手机工具箱软件，用户在实用工具箱app 里可以看到各种快捷功能，日常需要实用工具箱app 里都可以完成、同时还有制作、解析、转换等强大功能。</p><p>亮点：</p><p>1、一款超级黑科技的小工具，支持的功能超级的多，而且很实用；</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d0bd5786f.jpg\\\" alt=\\\"图片\\\" width=\\\"351\\\" style=\\\"\\\"></p><p>2、都是免费的，近百种工具都免费，而且操作很简单，安装包小；</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d127c0c6e.jpg\\\" alt=\\\"图片\\\" width=\\\"349\\\" style=\\\"\\\"></p><p>3、界面无任何的广告，工具涵盖的范围广，图片、娱乐、黑科技等，可以对功能进行收藏。</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d17e3c89b.jpg\\\" alt=\\\"图片\\\" width=\\\"345\\\" style=\\\"\\\"></p>\"');
INSERT INTO `gufeng_articles` VALUES (106, 1, '毒汤日历', 41, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd23d5a3fa6f.png\"}]', 1607613787, 13, 1, 'http://139.196.197.242/imgs/5fd23ce04e9c7.png', '210.44.14.36', '\"<p>每天一杯“毒”鸡汤，你的扎心小日常——史上最沙雕的日历应用，每天一杯“毒”鸡汤，你的扎心小日常——史上最沙雕的日历应用，界面非常干净清爽，除了每日3句精选毒汤，然后你自己也可以发布毒汤以外，没有其他乱七八糟的功能。</p>\"');
INSERT INTO `gufeng_articles` VALUES (112, 3, '小男孩证件照制作', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cece0e4bf.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cecf3a0db.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2ced06d506.jpg\"}]', 1607650367, 17, 1, 'http://139.196.197.242/imgs/5fd2cc3e44d2d.png', 'http://config.juapp7.com:20007/down_file?id=f2f03f36bfd187174a27c0203af3093f_8&sign=A7ED1C2EFB703A0E1C4BA8CAE32A6D77http://config.juapp7.com', '\"<p>一款非常棒的图像处理软件，软件内置多种证件照模板，用户需要拍摄什么类型的照片，直接调取相对应的模板即可，500多种证件照规格，、自带美颜的专业证件照拍摄软件，精美正装智能替换，完全免费无广告。</p>\"');
INSERT INTO `gufeng_articles` VALUES (121, 2, '每日故宫', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2d46da66fd.png\"}]', 1607652445, 6, 1, 'http://139.196.197.242/imgs/5fd2d45cae81f.png', 'http://config.juapp7.com:20007/down_file?id=8ab267281b3a600b54e8784a679cf99a&sign=44F81EE6A475FB5642C9E3918D08D91E', '\"<p>这是由故宫博物院官方推出的一款独具纪念意义和历史意义以及文化意义的App。每日故宫App甄选一款馆藏珍品，邀您同游宋元山水，共访禁城别苑，探寻皇家日常那些令人惊叹的细节，感受传世珍品不竭的历史生命。</p>\"');
INSERT INTO `gufeng_articles` VALUES (131, 3, '懒饭', 42, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf195c24a.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf1a8b542.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd2cf1bbe982.jpg\"}]', 1607650960, 45, 30, 'http://139.196.197.242/imgs/5fd2ce8f24c4a.png', 'http://config.juapp7.com:20007/down_file?id=221a10eb4846176aa38b31bc1345460c_4&sign=C2FDD85A0F1F45C0508DA3C43C013065', '\"<p>一款好用的美食制作软件，这款软件上有很多的菜品制作教程，还在为每天吃什么发愁吗，这款软件每天都有新菜出炉，每一个菜都有详细的教学。</p><p>丰富食谱：精彩的视频菜谱、详尽的步骤解读，新手也能做出好吃好看的菜</p><p>时令流行：根据不同节令告诉你应该吃什么，每一餐都不重样</p><p>记录灵感：跟做菜谱可以随时添加文字笔记，或上传图片记录下厨记忆</p><p>详尽贴士：在小贴士中学习各种食材处理和烹饪技巧</p><p><img src=\\\"http://139.196.197.242/imgs/5fd2d2f7f3e2b.jpg\\\" alt=\\\"图片\\\" width=\\\"353\\\" style=\\\"\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d2f805ffe.jpg\\\" alt=\\\"图片\\\" width=\\\"351\\\" style=\\\"\\\"><img src=\\\"http://139.196.197.242/imgs/5fd2d2f80a004.jpg\\\" alt=\\\"图片\\\" width=\\\"349\\\" style=\\\"\\\"></p>\"');
INSERT INTO `gufeng_articles` VALUES (203, 2, '全历史', 48, '[{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310aa11828.jpeg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310ac8aac6.jpeg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310af41827.jpeg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310b1d8c1b.jpeg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310b4c57f2.jpeg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310b71edba.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310b978544.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310bbc3ac9.jpg\"},{\"type\":\"image\",\"content\":\"http://139.196.197.242/imgs/5fd310be0e3c5.jpg\"}]', 1607667904, 27, 0, 'http://139.196.197.242/imgs/5fd310a7bfda2.png', 'https://www.allhistory.com/', '\"<p><img src=\\\"http://139.196.197.242/imgs/5fd319529056e.png\\\" alt=\\\"图片\\\"></p><p>全历史app是一款为大家学习历史知识准备的神器。这里的学习资料非常的丰富也很实用，面向不同用户群体为大家带来不一样的课程。还用一个时间轴将历史汇总起来让你看起来特别的方便。只要你输入关键词就可以找到需要的文件搜索功能极强。</p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\"><strong>全历史app介绍</strong></h2><p style=\\\"text-align: center;\\\"><br></p><p>「全历史」以宇宙形成作为时间的伊始，将大爆炸前的宇宙用简单的语句和对应的图片描绘出来，随后，节点继续按照地质年代、人类形成、信史时代、全球交流、现代革命的段落延展，</p><p><br></p><p>全历史APP是一款以时空关系为表达特性来向用户呈现历史知识的产品，全历史APP拥有全历史时间轴，时间地图，关系图谱，AB路径，国别史，全画作等等诸多功能特色。</p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\"><strong>全历史app特色</strong></h2><p style=\\\"text-align: center;\\\"><br></p><p>1、一款很实用的学习工具，界面清爽简洁，而且实用性很强，如果你还是学生，那么就更棒了;</p><p><br></p><p>2、拥有一条时间轴，从宇宙大爆炸到地球起源，从生命起源到现代文明，一条线给你全讲解;</p><p><br></p><p>3、还有关系图谱以及朝代史，你可以了解世间万物的关系，还能了解朝代的更迭变迁，学习神器。</p><p style=\\\"text-align: center;\\\"><img src=\\\"http://139.196.197.242/imgs/5fd319fbb2d42.jpeg\\\" alt=\\\"图片\\\"></p><p><br></p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\"><strong>全历史app亮点</strong></h2><p style=\\\"text-align: center;\\\"><br></p><p>1、历史的检索功能，帮助大家可以根据时间线快速搜索历史。</p><p><br></p><p>2、输入关键字就能查询自己感兴趣的历史内容，非常适合找资料使用。</p><p><br></p><p>3、自己喜欢的历史话题可以关注，后期会为大家第一时间推送相关的文章。</p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\"><strong>全历史app优势</strong></h2><p><br></p><p>1、自由言论的平台，可以和这里的网友讨论与历史相关的话题。</p><p><br></p><p>2、增长自己历史知识，对自己的文化修养以及知识培养也是非常有用的。</p><p><br></p><p>3、当前最新的新闻资讯实时更新，会结合相关历史资讯进行报道。</p><p style=\\\"text-align: center;\\\"><img src=\\\"http://139.196.197.242/imgs/5fd31a0aa7ff0.jpeg\\\" alt=\\\"图片\\\"></p><p><br></p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\">全历史app特征</h2><p style=\\\"text-align: center;\\\"><br></p><p>1、全历史时间轴：从宇宙大爆炸到地球形成，从生命起源到现代文明，只需一条时间轴让您轻松了解全历史发展。</p><p><br></p><p>2、时间地图：将时间、地图和历史全面结合，多维度的展示长达130亿年的世界史;</p><p><br></p><p>3、关系图谱：世间万物皆关系，关系图说清晰直观地展示事物之间的关系，让我们自由探索不为人知的历史规律。</p><p><br></p><p>4、AB路径：带你探寻任意两点之间的关系。</p><p><br></p><p>5、国别史：朝代更迭、疆域变迁、文明演进，重现帝国余晖，触摸文明脉络。</p><p><br></p><p>6、全画作：你身边最全的美术馆。</p><p><br></p><hr><p><br></p><h2 style=\\\"text-align: center;\\\"><strong>点评</strong></h2><p style=\\\"text-align: center;\\\"><br></p><p>想要学好历史这款软件一定要下载，准没错的。</p><p><br></p>\"');

-- ----------------------------
-- Table structure for gufeng_categories
-- ----------------------------
DROP TABLE IF EXISTS `gufeng_categories`;
CREATE TABLE `gufeng_categories`  (
  `cate_id` int(10) NOT NULL AUTO_INCREMENT,
  `cate_pid` int(10) NULL DEFAULT 0,
  `cate_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cate_order` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`cate_id`) USING BTREE,
  INDEX `cate_pid`(`cate_pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gufeng_categories
-- ----------------------------
INSERT INTO `gufeng_categories` VALUES (1, 0, '休闲', 1);
INSERT INTO `gufeng_categories` VALUES (2, 0, '学习', 2);
INSERT INTO `gufeng_categories` VALUES (3, 0, '工具', 3);

-- ----------------------------
-- Table structure for gufeng_comments
-- ----------------------------
DROP TABLE IF EXISTS `gufeng_comments`;
CREATE TABLE `gufeng_comments`  (
  `com_id` int(11) NOT NULL AUTO_INCREMENT,
  `art_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `com_content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `com_createtime` int(11) NULL DEFAULT NULL COMMENT '评论时间',
  `com_agree` int(11) NULL DEFAULT 0 COMMENT '点赞数',
  PRIMARY KEY (`com_id`) USING BTREE,
  UNIQUE INDEX `com_id`(`com_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gufeng_comments
-- ----------------------------
INSERT INTO `gufeng_comments` VALUES (34, 118, 42, '很有精神', 1607653280, 0);
INSERT INTO `gufeng_comments` VALUES (35, 121, 44, '学到了好多历史知识呢', 1607653289, 0);
INSERT INTO `gufeng_comments` VALUES (36, 106, 42, '好', 1607653291, 0);
INSERT INTO `gufeng_comments` VALUES (37, 111, 44, '很好用', 1607657026, 0);
INSERT INTO `gufeng_comments` VALUES (33, 120, 42, '真不戳', 1607653258, 0);
INSERT INTO `gufeng_comments` VALUES (32, 122, 42, 'nice', 1607653243, 0);
INSERT INTO `gufeng_comments` VALUES (31, 123, 42, '666', 1607653225, 0);
INSERT INTO `gufeng_comments` VALUES (30, 123, 44, '很好用哦', 1607653218, 0);
INSERT INTO `gufeng_comments` VALUES (27, 110, 42, '666', 1607649884, 1);
INSERT INTO `gufeng_comments` VALUES (28, 114, 41, '针不戳', 1607650900, 0);
INSERT INTO `gufeng_comments` VALUES (29, 118, 41, '针不戳', 1607653194, 0);
INSERT INTO `gufeng_comments` VALUES (26, 108, 41, '针不戳，我也用了嘻嘻', 1607614356, 0);
INSERT INTO `gufeng_comments` VALUES (38, 131, 48, '哇，真的很好用啊！', 1607674027, 1);
INSERT INTO `gufeng_comments` VALUES (39, 131, 48, '哇，真的诶', 1607674059, 2);

-- ----------------------------
-- Table structure for gufeng_members
-- ----------------------------
DROP TABLE IF EXISTS `gufeng_members`;
CREATE TABLE `gufeng_members`  (
  `u_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `u_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'openid',
  `u_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `u_face` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户头像',
  `u_random` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户随机码',
  `u_integral` int(10) NULL DEFAULT 0 COMMENT '积分',
  `u_remainder` int(10) NULL DEFAULT 0 COMMENT '余额',
  `u_regtime` int(11) NOT NULL COMMENT '用户注册时间',
  `u_password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`u_id`) USING BTREE,
  UNIQUE INDEX `u_openid`(`u_openid`) USING BTREE,
  UNIQUE INDEX `u_id`(`u_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gufeng_members
-- ----------------------------
INSERT INTO `gufeng_members` VALUES (41, '李小', '李小', 'http://139.196.197.242/imgs/5fd23b9a112a9.jpg', '5fd23b9ad4849', 0, 0, 1607613338, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `gufeng_members` VALUES (42, 'yuyang', '于洋', 'http://139.196.197.242/imgs/5fd23c9a6bb30.jpg', '5fd23c9b51493', 0, 0, 1607613595, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `gufeng_members` VALUES (43, 'oPwD94nvDVxi2qCd-yATl0bZJrW4', '豪无人性', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKf0riaiaiaWcQIcGK7WzP3KwAA4J4C8DYGdVpaypqhyOGeLXEwtETMlT04ZjYkT9uKx8EkUy6pdFQ4Q/132', '5fd23df1cfe44', 0, 0, 1607613937, '');
INSERT INTO `gufeng_members` VALUES (44, '王行知', '王行知', 'https://avatars0.githubusercontent.com/u/50990182?s=400&u=2e8415d678966d5833780413c6672033271c5332&v=4', '5fd2cfaa8f0c5', 0, 0, 1607651242, '731096d1ffb5d877d8beb504117c3621');
INSERT INTO `gufeng_members` VALUES (45, 'undefined', 'Curisoity', 'https://thirdwx.qlogo.cn/mmopen/vi_32/jziaEs9zToQE1Lg3dOZLF2U9hpurQrwArYv961QTRqrF7aUrkC7fESenT5FmKiacEX0hAoAdnbRhoAvCL1ETb3BA/132', '5fd2f1a370fa1', 0, 0, 1607659939, '');
INSERT INTO `gufeng_members` VALUES (46, '闫明富', '闫明富', 'http://139.196.197.242/imgs/mrtx.png', '5fd30e01699a3', 0, 0, 1607667201, 'c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO `gufeng_members` VALUES (48, '15000', '宋奕豪', 'http://139.196.197.242/imgs/5fd3106881d1c.jpg', '5fd3105e809d6', 0, 0, 1607667806, '9f6e6800cfae7749eb6c486619254b9c');

SET FOREIGN_KEY_CHECKS = 1;
