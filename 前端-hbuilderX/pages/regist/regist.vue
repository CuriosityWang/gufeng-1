<template>
	<view class="window"  style="padding-top: 20px;">
		<view class="syh-register-title">新用户注册</view>
		<view class="syh-tx-show">
			<image :src="txImg" mode="widthFix"></image>
		</view>
		<view @tap="addtx" class="syh-sc">上传</view>
		<view class="syh-login" style="margin-top: 20px;">
			<input type="text" v-model="account" placeholder="请输入用户名" />
		</view>
		<view class="syh-login">
			<input type="text" v-model="name" placeholder="请输入昵称" />
		</view>
		<view class="syh-login">
			<input type="password" v-model="password" placeholder="请输入密码" />
		</view>
		<view class="syh-login">
			<input type="password" v-model="password_r" placeholder="请确认密码" />
		</view>
		<view class="submitNow" @tap="submitNow">注册</view>
	</view>
</template>

<script>
	var _self;
	var md5 = require('../../commons/md5.js');
	export default {
		data() {
			return {
				txImg:''
			}
		},
		onLoad:function(){
			_self = this;
			this.txImg = "http://139.196.197.242/imgs/mrtx.png";
		},
		methods: {
			uploadImg :function(){
				if(this.txImg != "http://139.196.197.242/imgs/mrtx.png")
				{
					uni.showLoading({title:"上传头像"});
					var uploader = uni.uploadFile({
						url      : _self.apiServer + 'uploadimg',
						filePath : this.txImg,
						name     : 'file',
						success: (uploadFileRes) => {
							var data = uploadFileRes.data;
							uploadFileRes = JSON.parse(data.slice(data.indexOf('{')));
							if(uploadFileRes.status != 'ok'){
								uni.showToast({title:"上传头像失败,请重试!", icon:"none"});
								return false;
							}
							this.txImg = _self.staticServer + uploadFileRes.data;
						}
					})
				}
				setTimeout(function(){_self.btnReg();}, 1000);
			},
			addtx : function(){
				uni.chooseImage({
					count: 1,
					sizeType: ['compressed'],
					success: function(res) {
						_self.txImg = res.tempFilePaths[0];
					}
				})
			},
			submitNow: function(){
				if(this.account.length < 1){uni.showToast({title:'请输入用户名', icon:"none"}); return ;}
				if(this.name.length < 1){uni.showToast({title:'请输入昵称', icon:"none"}); return ;}
				if(this.password < 1){uni.showToast({title:'请输入密码', icon:"none"}); return ;}
				if(this.password != this.password_r){uni.showToast({title:'两次填写的密码不一致', icon:"none"}); return ;}
				this.uploadImg();
				console.log('完成上传');
			},
			btnReg: function() {
				uni.request({
					url: _self.apiServer+'member&m=regist',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data: {
						openid: this.account,
						username: this.name,
						password: md5.hex_md5(this.password),
						face: this.txImg
					},
					success: res => {
						res.data = res.data.substr(res.data.indexOf('{'));
						res.data = JSON.parse(res.data);
						if(res.data.status == 'ok')
						{
							uni.showToast({
								title: "注册成功",
								duration: 2000,
								success() {
									setTimeout(function() {
										uni.navigateTo({
											url: '../login/login',
										});
									}, 1000);
								}
							});
						}else{
							uni.showToast({title: "用户名已存在", icon:"none"});
						}
					},
					fail: () => {},
					complete: () => {}
				});
			}
		}
	}
</script>

<style>

</style>
