<template>
	<view class="window">
		<view class="syh-header-cate">
			<scroll-view class="syh-tab-title syh-center" scroll-x="true" id="syh-tab-title">
				<view v-for="(cate, index) in categories" :key="index" :data-cateid="cate.cateId" :data-index="index" :class="[cateCurrentIndex == index ? 'syh-tab-current' : '']"
				 @tap="tabChange">{{cate.name}}</view>
			</scroll-view>
		</view>
		<view class="syh-list">
			<block v-for="(item, index) in artList" :key="index">
				<navigator open-type="navigate" :url="'../info/info?artid='+item.art_id">
					<view class="syh-list-all">
						<view class="syh-list-rank">{{index+1}}</view>
						<view class="syh-list-img">
							<image :src="item.art_content[0]" mode="widthFix"></image>
						</view>
						<view class="syh-list-information">
							<view class="syh-list-title">{{item.art_title}}</view>
							<view class="syh-list-browse" v-if="cateCurrentIndex == '0'">浏览数：{{item.art_browse}}</view>
							<view class="syh-list-browse" v-if="cateCurrentIndex == '1'">点赞数：{{item.art_agree}}</view>
							<view class="syh-list-uface">
								<image :src="item.u_face" mode="widthFix"></image>
							</view>
							<view class="syh-list-uid">{{item.u_name}}</view>
						</view>
					</view>
				</navigator>
			</block>
		</view>
	</view>
	
</template>

<script>
	var _self, page = 1, cate = 0;
	export default {
		data() {
			return {
				categories: [{
					cateId: 0,
					name: "按浏览数排名"
				},
				{
					cateId: 1,
					name: "按点赞数排名"
				}],
				artList: [],
				cateCurrentIndex: 0
			}
		},
		onLoad() {
			_self = this;
			this.getNewsList();
		},
		onPullDownRefresh: function(){
			page = 1;
			this.artList = [];
			this.getNewsList();
		},
		// 加载更多
		onReachBottom:function(){
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
					url: this.apiServer + 'rank&m=getList&page=' + page + '&cate=' + cate,
					method: 'GET',
					success: res => {
						res.data = res.data.substr(res.data.indexOf('{'));
						res.data = JSON.parse(res.data);
						console.log(res);
						if (res.data.status == 'empty') {
							uni.showToast({
								title: "已经加载全部",
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
