<template>
	<view class="window">
		<view class="login-tx">
			<image src="../../static/tx.png" mode="widthFix"></image>
		</view>
		<view class="login-text">登录...，享受更多功能
			<view>三个平台的账号不会同步</view>
		</view>
		<view class="syh-login" style="margin-top: 20px;">
			<input type="text" v-model="account" placeholder="请输入用户名" />
		</view>
		<view class="syh-login">
			<input type="password" v-model="password" placeholder="请输入密码" />
		</view>
		<button class="login-button-w" open-type="getUserInfo" @tap="getUserInfoc">
			<view class="login-button-w-father">
				<image src="../../static/wapp.png" mode="widthFix"></image>
				<view>登录</view>
				<view class="clear"></view>
			</view>
		</button>
		
		<view class="syh-register" @tap="register">新用户注册</view>
		<view class="login-text">
			<view style="margin-top: 100px;">其他平台</view>
		</view>
		
		<!-- #ifdef MP-WEIXIN -->
		<button class="login-button-wx" open-type="getUserInfo" @getuserinfo="getUserInfo">
			<view class="login-button-wx-father">
				<image src="../../static/wx.png" mode="widthFix"></image>
				<view>使用微信登录</view>
				<view class="clear"></view>
			</view>
		</button>
		<button class="login-button-qq" open-type="getUserInfo" @getuserinfo="getUserInfo">
			<view class="login-button-qq-father">
				<image src="../../static/qq.png" mode="widthFix"></image>
				<view>使用QQ登录</view>
				<view class="clear"></view>
			</view>
		</button>
		<!-- #endif -->
	</view>
</template>

<script>
var _self, session_key, openid, pageOptions;
var sign = require('../../commons/sign.js');
var md5 = require('../../commons/md5.js');
export default {
	data() {
		return {

		};
	},
	methods:{
		getUserInfoc : function(){
			if(_self.account.length < 1){uni.showToast({title:'请输入用户名', icon:"none"}); return ;}
			if(_self.password.length < 1){uni.showToast({title:'请输入密码', icon:"none"}); return ;}
			uni.request({
				url: _self.apiServer+'member&m=loginc',
				method: 'POST',
				header: {'content-type' : "application/x-www-form-urlencoded"},
				data: {
					openid : _self.account,
					password : md5.hex_md5(_self.password)
				},
				success: res => {
					var data = res.data;
					res = JSON.parse(data.slice(data.indexOf('{')));
					if(res.status == 'ok'){
						uni.showToast({title:"登录成功"});
						uni.setStorageSync('SUID' , res.data.u_id + '');
						uni.setStorageSync('SRAND', res.data.u_random + '');
						uni.setStorageSync('SNAME', res.data.u_name + '');
						uni.setStorageSync('SFACE', res.data.u_face + '');
						// 跳转
						if(pageOptions.backpage == undefined)
							pageOptions.backpage = '../my/my';
						if(pageOptions.backtype == 1){
							uni.redirectTo({url:pageOptions.backpage});
						}else{
							if(pageOptions.backpage == "../info/info"){
								uni.redirectTo({url:pageOptions.backpage+"?artid="+pageOptions.artid});
							}else{
								uni.switchTab({url:pageOptions.backpage});
							}
						}
					} else{
						uni.showToast({title:res.data, icon: 'none'});
					}
				}
			});
		},
		register : function(){
			uni.redirectTo({url:'../regist/regist'});
		},
		getUserInfo : function(info){
				info = info.mp.detail.userInfo;
				var sign = uni.getStorageSync('sign');
				uni.request({
					url: _self.apiServer+'member&m=login',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data: {
						openid : openid,
						name   : info.nickName,
		                face   : info.avatarUrl,
						sign   : sign
					},
					success: res => {
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						console.log("yonghuxinxi",res);
						uni.showToast({title:"登录成功"});
						uni.setStorageSync('SUID' , res.data.u_id + '');
						uni.setStorageSync('SRAND', res.data.u_random + '');
						uni.setStorageSync('SNAME', res.data.u_name + '');
						uni.setStorageSync('SFACE', res.data.u_face + '');
						// 跳转
						if(pageOptions.backtype == 1){
							uni.redirectTo({url:pageOptions.backpage});
						}else{
							if(pageOptions.backpage == "../info/info"){
								uni.redirectTo({url:pageOptions.backpage+"?artid="+pageOptions.artid});
							}else{
								uni.switchTab({url:pageOptions.backpage});
							}
						}
					},
					fail: (e) => {
						console.log(e);
					}
				});
			}
		},
	
	onLoad:function(options){
		sign.sign(this.apiServer)
		pageOptions = options;
		_self = this;
		
		//微信
		// #ifdef MP-WEIXIN
		uni.login({
			success:function(res){
				uni.request({
					url: _self.apiServer+'member&m=codeToSession&code='+res.code,
					method: 'GET',
					success: res => {
						console.log("login onload",res)
						var address= res.data
						let addr = address.split('{');
						addr = '{' + addr[1];
						addr = JSON.parse(addr);
						console.log("addr",addr);
						session_key = addr.session_key;
						openid      = addr.openid;
					}
				});
			}
		})
		// #endif
		
		// app
		// #ifdef APP-PLUS
		uni.login({
			provider: 'weixin',
			success: (res) => {
				uni.getUserInfo({
					success:function(info){
						console.log("getUserinfo",JSON.stringify(info));
						var sign = uni.getStorageSync('sign');
						uni.request({
							url: _self.apiServer+'member&m=login',
							method: 'POST',
							header: {'content-type' : "application/x-www-form-urlencoded"},
							data: {
								openid : info.userInfo.openId,
	                            name   : info.userInfo.nickName,
	                            face   : info.userInfo.avatarUrl,
								sign   : sign
							},
							success: res => {
								var data = res.data;
								res = JSON.parse(data.slice(data.indexOf('{')));
								if(res.status == 'ok'){
									uni.showToast({title:"登录成功"});
									uni.setStorageSync('SUID' , res.data.u_id + '');
	                                uni.setStorageSync('SRAND', res.data.u_random + '');
						            uni.setStorageSync('SNAME', res.data.u_name + '');
	                                uni.setStorageSync('SFACE', res.data.u_face + ''); 
									console.log("成功");
									// 跳转
	                                if(options.backtype == 1){
	                                    uni.redirectTo({url:options.backpage});
	                                }else{
	                                    uni.switchTab({url:options.backpage});
	                                }
								}else{
									console.log(JSON.stringify(res));
									uni.showToast({title:res.data});
								}
							},
							fail: (res) => {
								console.log(res);
							},
							complete: () => {}
						});
					},
					fail:function(){
						uni.showToast({title:"微信登录授权失败", icon:"none"});
					}
				})
			},
			fail: () => {
				uni.showToast({title:"微信登录授权失败",  icon:"none"});
			}
		})
		// #endif
	}
	
}
</script>

<style>

</style>
