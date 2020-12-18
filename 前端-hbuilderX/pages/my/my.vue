<template>
	<view class="window">
		<view class="syh-show">
			<image src="../../static/my.jpg" mode="widthFix"></image>
		</view>
		<view class="syh-padding">
			
			<view class="syh-inform">
				<view class="syh-myface">
					<image :src="myFace" mode="widthFix"></image>
				</view>
				<view class="syh-inform-name">{{user.u_name}}</view>
				<text class="logoff" @tap="logoff">注销</text>
				<view class="clear"></view>
				<view class="syh-level">
					<view class="syh-level-text" :style="{'-webkit-text-stroke-color': user.Lv_color}">Lv{{user.Lv}}</view>
					<view class="syh-level-num">{{user.Lv_num}}</view>
					<view class="clear"></view>
					<view class="syh-level-bar" :style="{'border-color': user.Lv_color}">
						<view class="syh-level-scoreBar" :style="{width: user.rake, background: user.Lv_color}">&nbsp;</view>
					</view>
				</view>
			</view>
			<view class="syh-box-banner">
				<view class="syh-items">
					<view class="line1"><text>{{user.artCount}}</text></view>
					<view class="line2">文章</view>
				</view>
				<view class="syh-items">
					<view class="line1"><text>{{user.u_remainder}}</text></view>
					<view class="line2">余额</view>
				</view>
				<view class="syh-items">
					<view class="line1"><text>0</text></view>
					<view class="line2">关注</view>
				</view>
			</view>
			<view class="clear"></view>
			<view class="syh-title">
				<view class="syh-blod">我的文章</view>
			</view>
			<view class="myart-list" v-for="(item, index) in arts" :key="index">
				<view class="title">{{item.art_title}}</view>
				<view class="btns">
					<view :data-artid="item.art_id" @tap="editArt">编辑</view>
					<view :data-artid="item.art_id" :data-index="index" @tap="removeArt">删除</view>
				</view>
			</view>
			<view class="loadMore" @tap="getArtList" style="color: #8F8F94;">{{loadMore}}</view>
		</view>
	</view>
</template>

<script>
	var IknowLevel = [0, 100, 500, 1000, 2500, 5000, 10000];
	var IknowColor = ['#BFBFBF', '#BFBFBF', '#95DDB3', '#92D1E5', '#FFB37C', '#FF6C00', '#FF0000'];
	var loginRes, _self, page = 1;
	export default {
		data() {
			return {
				myFace: '',
				user: {},
				arts: [],
				loadMore: '点击加载更多'
			}
		},
		onPullDownRefresh: function() {
			this.artList = [];
			page = 1;
			this.getArtList();
		},
		onLoad: function() {
			_self = this;
			loginRes = this.checkLogin("../my/my", 2);
			if (!loginRes) {
				return;
			};
			this.myFace = loginRes[3];
		},
		onShow: function() {
			loginRes = this.checkLogin('../my/my', '2');
			if (!loginRes) {
				return false;
			}
			// 加载会员信息
			uni.request({
				url: this.apiServer + 'my&m=info',
				method: 'POST',
				header: {
					'content-type': "application/x-www-form-urlencoded"
				},
				data: {
					uid: loginRes[0],
					random: loginRes[1]
				},
				success: res => {
					var data = res.data;
					res = JSON.parse(data.slice(data.indexOf('{')));
					if (res.status == 'ok') {
						this.user = res.data;
						this.scoreBar(this.user.u_integral);
					}
				},
			});
			this.getArtList();
		},
		methods: {
			scoreRake: function(score) {
				var len = IknowLevel.length;
				var i = this.getUserLevel(score);
				var min, max, rake;
				if (i == 0) return 0;
				if (i >= len) {
					return 100;
				}
				min = IknowLevel[i - 1];
				max = IknowLevel[i];
				if (score > min && score <= max)
					return (score - min) * 100 / (max - min);
				return 0;
			},
			getUserLevel: function(score) {
				for (var i = 0, l = IknowLevel.length; i < l; i++) {
					if (score <= IknowLevel[i]) break;
				}
				return i;
			},
			scoreBar: function(score) {
				var rake = this.scoreRake(score);
				var level = this.getUserLevel(score);
				var needscore;
				if (level >= 7) {
					level = 6;
					needscore = "/--";
				} else {
					needscore = "/" + IknowLevel[level];
				}
				if (score < 0) {
					needscore = "";
				}
				this.user.Lv = level;
				this.user.Lv_color = IknowColor[level];
				this.user.Lv_num = score + needscore;
				this.user.rake = rake + '%';
			},
			logoff: function() {
				uni.removeStorageSync('SUID');
				uni.removeStorageSync('SRAND');
				uni.showToast({
					title: "您已经退出",
					icon: "none"
				});
				setTimeout(function() {
					uni.switchTab({
						url: '../index/index'
					});
				}, 1000);
			},
			editArt: function(e) {
				var artId = e.currentTarget.dataset.artid;
				uni.navigateTo({
					url: "../editArt/editArt?artId=" + artId
				});
			},
			removeArt: function(e) {
				var artId = e.currentTarget.dataset.artid;
				var index = e.currentTarget.dataset.index;
				uni.showModal({
					title: "提示",
					content: "确定要删除吗?",
					success: function(e) {
						if (e.confirm == true) {
							uni.request({
								url: _self.apiServer + 'my&m=removeArt',
								method: 'POST',
								header: {
									'content-type': "application/x-www-form-urlencoded"
								},
								data: {
									uid: loginRes[0],
									random: loginRes[1],
									artId: artId
								},
								success: function(res) {
									var data = res.data;
									res = JSON.parse(data.slice(data.indexOf('{')));
									if (res.status == 'ok') {
										uni.showToast({
											title: "已删除",
											icon: "none"
										});
										_self.arts.splice(index, 1);
									} else {
										uni.showToast({
											title: "删除失败",
											icon: "none"
										});
									}
								}
							});
						}
					},
				});
			},
			getArtList: function() {
				uni.request({
					url: this.apiServer + 'my&m=arts&page=' + page,
					method: 'POST',
					header: {
						'content-type': "application/x-www-form-urlencoded"
					},
					data: {
						uid: loginRes[0],
						random: loginRes[1]
					},
					success: res => {
						console.log(res)
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						console.log(res)
						if (res.status == 'ok') {
							this.arts = res.data;
							page++;
						}
					},
					complete:function(){
						uni.stopPullDownRefresh();
					}
				});
			}
		}
	}
</script>

<style>
	
</style>
