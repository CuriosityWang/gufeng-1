<template>
	<view class="window">
		<view class="syh-article-all">
			<!-- 标题 -->
			<view class="syh-article-icon">
				<image :src="article.art_icon" mode="widthFix"></image>
			</view>
			<view class="syh-article-download">
				<view :class="['syh-article-title', syhSkeleton == 'ing' ? 'syh-skeleton' : '']">{{article.art_title}}</view>
				<view class="content">
					<view @click="copyBtn" class="syh-copy-btn">下载
						<view style="font-size: 10px; color: #8F8F94;">（复制到剪贴板）</view>
					</view>
				</view>
			</view>
			<view class="clear"></view>
			<!-- 作者信息 -->
			<view class="syh-article-author-line">
				<view :class="['syh-article-author', syhSkeleton == 'ing' ? 'syh-skeleton' : '']">
					<view>
						<image :src="article.u_face" mode="widthFix"></image>
					</view>
					<view class="author-name">{{article.u_name}}</view>
				</view>
				<view class="syh-article-createtime">创作于 {{article.art_createtime}}</view>
			</view>
			<!-- 文章内容 -->
			<view class="content">
				<rich-text :nodes="artContents" @tap="test"></rich-text>
			</view>
			<view class="syh-article-browse">{{article.art_browse}} 浏览</view>
			<view class="syh-com-dz" @tap="art_dz(article.art_id, index)">
				<view class="syh-com-dz-img">
					<image src="../../static/dz.png"></image>
				</view>
				<view class="syh-com-agree">{{article.art_agree}}</view>
			</view>
			<!-- 评论部分 -->
			<form @submit="submit">
				<view class="syh-inputArea">
					<view class="addText">
						<textarea name="artText" maxlength="-1" v-model="inputContent" placeholder="请输入文本" />
					</view>
					<button type="primary" form-type="submit" class="syh-inputArea-button">发表评论</button>
				</view>
			</form>
			<view class="syh-com">
				<block v-for="(item, index) in comList" :key="index">
					<view class="syh-com-all">
						<view class="syh-com-img">
							<image :src="item.u_face"></image>
						</view>
						<view class="syh-com-text">
							<view class="syh-com-name">{{item.u_name}}</view>
							<view class="syh-com-createtime">{{item.com_createtime}}</view>
							<view class="syh-com-content">{{item.com_content}}</view>
							<view class="syh-com-dz" @tap="dz(item.com_id, index)">
								<view class="syh-com-dz-img">
									<image src="../../static/dz.png"></image>
								</view>
								<view class="syh-com-agree">{{comList[index].com_agree}}</view>
							</view>
						</view>
						<view class="clear"></view>
					</view>
				</block>
			</view>
		</view>
	</view>
</template>
<script>
	var _self, artid, loginRes;
	var signModel = require('../../commons/sign.js');
	export default {
		data() {
			return {
				imageArray: [],
				comList: [],
				article: [], //文章基础信息
				artContents: "", // 文章项目
				syhSkeleton: 'ing'
			};
		},
		methods:{
			test: function(e){
			    let arr=[];
			    let reg = new RegExp('(?<=(src="))[^ "]*?(?=")','ig');
			    let allSrc = _self.artContents.match(reg);
			    for (let i = 0; i<allSrc.length;i++){
					arr.push(allSrc[i]);
			    }
				_self.ImageArray = arr;
				console.log(_self.ImageArray)
			    uni.previewImage({
			    	urls    :arr,
			    });
			},
			copyBtn : function(e) {
				uni.setClipboardData({
					data: this.article.art_download,
					success: function (res) {
						uni.showToast({
							title: '复制成功',
						});
					}
				});
			},
			dz : function(e, f){
				loginRes = this.checkLogin("../info/info&artid="+artid, 2);
				if(!loginRes){return false;};
				// 签名
				signModel.sign(_self.apiServer);
				var sign = uni.getStorageSync('sign');
				uni.request({
					url: this.apiServer + 'comment&m=dz',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data: {
						comid	: e,
						uid     : loginRes[0],
						random  : loginRes[1],
						sign    : sign
					},
					success:function(res){
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						if(res.status == 'ok'){
							uni.showToast({title:"点赞成功", icon:"none"});
							_self.artList = [];
							// 清空数据
							signModel.sign(_self.apiServer);
							// 防止数据缓存
							_self.currentCateIndex = 0;
							_self.sedCateIndex     = 0;
							_self.needUploadImg    = [];
							_self.title            = '';
							_self.comList[f].com_agree ++;
						}else if(res.status == 'empty'){
							uni.showToast({title:"余额不足", icon:"none"});
						}else{
							uni.showToast({title:"失败啦", icon:"none"});
						}
					},
				});
			},
			art_dz : function(e, f){
				loginRes = this.checkLogin("../info/info&artid="+artid, 2);
				if(!loginRes){return false;};
				// 签名
				signModel.sign(_self.apiServer);
				var sign = uni.getStorageSync('sign');
				uni.request({
					url: this.apiServer + 'art&m=dz',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data: {
						artid	: e,
						uid     : loginRes[0],
						random  : loginRes[1],
						sign    : sign
					},
					success:function(res){
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						if(res.status == 'ok'){
							uni.showToast({title:"点赞成功", icon:"none"});
							_self.artList = [];
							// 清空数据
							signModel.sign(_self.apiServer);
							// 防止数据缓存
							_self.currentCateIndex = 0;
							_self.sedCateIndex     = 0;
							_self.needUploadImg    = [];
							_self.title            = '';
							_self.article.art_agree ++;
						}else if(res.status == 'empty'){
							uni.showToast({title:"余额不足", icon:"none"});
						}else{
							uni.showToast({title:"失败啦", icon:"none"});
						}
					},
				});
			},
			submit : function(res){
				loginRes = this.checkLogin("../info/info&artid="+artid, 2);
				if(!loginRes){return false;};
				// 签名
				signModel.sign(_self.apiServer);
				var content = res.detail.value.artText;
				// 数据验证
				if(content.length < 1){uni.showToast({title:"请输入内容",icon:'none'}); return ;}
				uni.showLoading({title:"正在提交"});
				var sign = uni.getStorageSync('sign');
				uni.request({
					url: this.apiServer + 'comment&m=add',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data:{
						artid	: artid,
						content : content,
						uid     : loginRes[0],
						random  : loginRes[1],
						sign    : sign
					},
					success:function(res){
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						if(res.status == 'ok'){
							uni.showToast({title:"提交成功", icon:"none"});
							_self.artList = [];
							// 清空数据
							signModel.sign(_self.apiServer);
							// 防止数据缓存
							_self.currentCateIndex = 0;
							_self.sedCateIndex     = 0;
							_self.needUploadImg    = [];
							_self.title            = '';
							setTimeout(function(){
								uni.redirectTo({url:"../info/info?artid="+artid});
							}, 1000);
						}else{
							uni.showToast({title:"失败啦"});
						}
					}
				});
			},
			showImgs : function(e){
				var currentUrl = e.currentTarget.dataset.url;
				// 找出图片
				console.log(currentUrl);
				var imgsNeedShow = [];
				for(var i = 0; i < this.artContents.length; i++){
					if(this.artContents[i].type == 'image'){
						imgsNeedShow.push(this.artContents[i].content);
					}
				}
				uni.previewImage({
					urls    :imgsNeedShow,
					current :currentUrl
				});
			}
		},
		onLoad: function(options) {
			_self = this;
			signModel.sign(_self.apiServer);
			artid = options.artid;
			// 加载文章详情
			uni.showLoading({
				title: ""
			});
			uni.request({
				url: this.apiServer + 'art&m=infoWithUser&artid=' + artid,
				method: 'GET',
				data: {},
				success: res => {
					var data = res.data;
					res = JSON.parse(data.slice(data.indexOf('{')));
					var art = res.data;
					art.art_real_content = art.art_real_content.substring(1, art.art_real_content.length-1);
					art.art_real_content = art.art_real_content.replace(/[\\]/g,'');
					console.log(art.art_real_content);
					art.art_real_content = art.art_real_content.replace(/\<img/gi, '<img style="width:100%;height:auto"');
					setTimeout(function(){
						_self.article        = art;
						_self.artContents   = art.art_real_content; 
						_self.syhSkeleton = 'end';
						uni.hideLoading();
					},500);
				}
			});
			uni.request({
				url: this.apiServer + 'comment&m=getList&artid=' + artid,
				method: 'GET',
				data: {},
				success: res => {
					res.data = res.data.substr(res.data.indexOf('{'));
					res.data = JSON.parse(res.data);
					if (res.data.status == 'ok'){
						_self.comList = _self.comList.concat(res.data.data);
					}
				},
			});
		}
	}
</script>
<style>
	
</style>
