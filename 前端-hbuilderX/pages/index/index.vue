<template>
	<view class="window">
		<view>
			<swiper class="syh-swiper" :autoplay="true">
				<swiper-item v-for="(item, index) in artList" :key="index">
					<navigator open-type="navigate" :url="'../info/info?artid='+item.art_id">
						<view class="syh-swiper-all">
							<view class="syh-swiper-img">
								<image :src="item.art_content[0]" mode="widthFix"></image>
							</view>
							<view class="syh-swiper-text">
								{{item.art_title}}
							</view>
						</view>
					</navigator>
				</swiper-item>
			</swiper>
		</view>
		<view class="syh-header-cate">
			<scroll-view class="syh-tab-title syh-center" scroll-x="true" id="syh-tab-title">
				<view v-for="(cate, index) in categories" :key="index" :data-cateid="cate.cateId" :data-index="index" :class="[cateCurrentIndex == index ? 'syh-tab-current' : '']"
				 @tap="tabChange">{{cate.name}}</view>
			</scroll-view>
		</view>
		<!-- 文章内容区 -->
		<view class="syh-news-list">
			<block v-for="(item, index) in artList" :key="index">
				<!-- 一张图 -->
				<navigator v-if="item.art_content.length == 1" open-type="navigate" :url="'../info/info?artid='+item.art_id">
					<view class="syh-news-list-img-news">
						<view class="syh-news-list-img-big">
							<image :src="item.art_content[0]" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-icon">
							<image :src="item.art_icon" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-title-main">{{item.art_title}}</view>
						<view class="clear"></view>
					</view>
				</navigator>
				<!-- 两张张图 -->
				<navigator v-if="item.art_content.length == 2" :url="'../info/info?artid='+item.art_id">
					<view class="syh-news-list-img-news">
						<view class="syh-news-list-img-2">
							<view class="img-1">
								<image :src="item.art_content[0]" mode="widthFix"></image>
							</view>
							<view class="img-2">
								<image :src="item.art_content[1]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-icon">
							<image :src="item.art_icon" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-title-main">{{item.art_title}}</view>
						<view class="clear"></view>
					</view>
				</navigator>
				<!-- 三张图 -->
				<navigator v-if="item.art_content.length >= 3 && item.art_content.length < 6" :url="'../info/info?artid='+item.art_id">
					<view class="syh-news-list-img-news">
						<view class="syh-news-list-img-3">
							<view class="img-1">
								<image :src="item.art_content[0]" mode="widthFix"></image>
							</view>
							<view class="img-2">
								<image :src="item.art_content[1]" mode="widthFix"></image>
							</view>
							<view class="img-3">
								<image :src="item.art_content[2]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-icon">
							<image :src="item.art_icon" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-title-main">{{item.art_title}}</view>
						<view class="clear"></view>
					</view>
				</navigator>
				<!-- 六张图 -->
				<navigator v-if="item.art_content.length >= 6 && item.art_content.length < 9" :url="'../info/info?artid='+item.art_id">
					<view class="syh-news-list-img-news">
						<view class="syh-news-list-img-6">
							<view class="img-1">
								<image :src="item.art_content[0]" mode="widthFix"></image>
							</view>
							<view class="img-2">
								<image :src="item.art_content[1]" mode="widthFix"></image>
							</view>
							<view class="img-3">
								<image :src="item.art_content[2]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-img-6" style="margin-top: -10px;">
							<view class="img-4">
								<image :src="item.art_content[3]" mode="widthFix"></image>
							</view>
							<view class="img-5">
								<image :src="item.art_content[4]" mode="widthFix"></image>
							</view>
							<view class="img-6">
								<image :src="item.art_content[5]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-icon">
							<image :src="item.art_icon" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-title-main">{{item.art_title}}</view>
						<view class="clear"></view>
					</view>
				</navigator>
				<!-- 九张图 -->
				<navigator v-if="item.art_content.length >= 9" :url="'../info/info?artid='+item.art_id">
					<view class="syh-news-list-img-news">
						<view class="syh-news-list-img-9">
							<view class="img-1">
								<image :src="item.art_content[0]" mode="widthFix"></image>
							</view>
							<view class="img-2">
								<image :src="item.art_content[1]" mode="widthFix"></image>
							</view>
							<view class="img-3">
								<image :src="item.art_content[2]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-img-9" style="margin-top: -10px;">
							<view class="img-4">
								<image :src="item.art_content[3]" mode="widthFix"></image>
							</view>
							<view class="img-5">
								<image :src="item.art_content[4]" mode="widthFix"></image>
							</view>
							<view class="img-6">
								<image :src="item.art_content[5]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-img-9" style="margin-top: -10px;">
							<view class="img-7">
								<image :src="item.art_content[6]" mode="widthFix"></image>
							</view>
							<view class="img-8">
								<image :src="item.art_content[7]" mode="widthFix"></image>
							</view>
							<view class="img-9">
								<image :src="item.art_content[8]" mode="widthFix"></image>
							</view>
						</view>
						<view class="syh-news-list-icon">
							<image :src="item.art_icon" mode="widthFix"></image>
						</view>
						<view class="syh-news-list-title-main">{{item.art_title}}</view>
						<view class="clear"></view>
					</view>
				</navigator>
			</block>
		</view>
	</view>
</template>

<script>
	var _self, cate = 0, page = 1;
	var sign = require('../../commons/sign.js');
	export default {
		data() {
			return {
				categories: [{
					cateId: 0,
					name: "全部"
				}],
				cateCurrentIndex: 0,
				artList: []
			}
		},
		onLoad() {
			_self = this;
			sign.sign(this.apiServer);
			// 加载文章分类
			uni.request({
				url: this.apiServer + 'category&m=index',
				method: 'GET',
				success: res => {
					res.data = res.data.substr(res.data.indexOf('{'));
					res.data = JSON.parse(res.data);
					if (res.data.status == 'ok') {
						// 把数据格式整理为 picker 支持的格式 ['分类名', ...]
						var categories = res.data.data;
						for (var k in categories) {
							_self.categories.push({
								cateId: k,
								name: categories[k]
							});
						}
						// 记录分类信息
						_self.catiesFromApi = categories;
					}
				}
			});
			// 加载全部文章
			this.getNewsList();
		},
		//下拉刷新
		onPullDownRefresh: function() {
			page = 1;
			this.artList = [];
			this.getNewsList();
		},
		// 加载更多
		onReachBottom: function() {
			this.getNewsList();
		},
		methods: {
			tabChange: function(e) {
				console.log(e);
				var cateid = e.currentTarget.dataset.cateid;
				var index = e.currentTarget.dataset.index;
				page = 1;
				this.cateCurrentIndex = index;
				cate = cateid;
				this.artList = [];
				this.getNewsList();
			},
			getNewsList: function() {
				uni.showLoading({
					'title': "加载中..."
				});
				uni.request({
					url: this.apiServer + 'art&m=getList&cate=' + cate + '&page=' + page,
					method: 'GET',
					success: res => {
						res.data = res.data.substr(res.data.indexOf('{'));
						res.data = JSON.parse(res.data);
						if (res.data.status == 'empty') {
							uni.showToast({
								title: "已经加载全部新闻",
								icon: "none"
							});
						} else if (res.data.status == 'ok') {
							//整理新闻信息
							var newsList = res.data.data;
							for (var i = 0; i < newsList.length; i++) {
								// 把图片分离出来
								var imgs = [];
								var content = newsList[i].art_content;
								content = JSON.parse(content);
								for (var ii = 0; ii < content.length; ii++) {
									if (content[ii].type == 'image') {
										imgs.push(content[ii].content);
									}
								}
								newsList[i].art_content = imgs;
							}
							//填充数据
							_self.artList = _self.artList.concat(newsList);
							uni.hideLoading();
							page++;
						}
					},
					complete: function() {
						uni.stopPullDownRefresh();
					}
				});
			}
		}
	}
</script>

<style>

</style>
