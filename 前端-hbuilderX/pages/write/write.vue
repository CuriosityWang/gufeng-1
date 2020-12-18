<template>
	<view>
		<view class="wrap">
			<!-- 标题 -->
			<view class="syh-icon">
				<image :src="iconImg" mode="widthFix" @tap="addicon"></image>
			</view>
			<view class="syh-write_title">
				<input type="text" v-model="title" placeholder="请输入标题" />
			</view>
			<view class="clear"></view>
			<!-- 输入区 -->
			<form @submit="submit">
				<view class="inputArea">
					<view class="addImg" @tap="addImg">+首页展示图片</view>
				</view>
			</form>
			<view class="syh-write_title-2">
				<view>下载地址：</view>
				<input type="text" v-model="download" placeholder="请输入下载地址" />
				<view class="clear"></view>
			</view>
			<!-- 选择分类 -->
			<view class="art-cate">
				<view>文章分类</view>
				<view class="">
					<picker mode="selector" :range="caties" @change="cateChange">
						<view>{{caties[currentCateIndex]}}</view>
					</picker>
				</view>
			</view>
		</view>
		<view class="editor">
			<jinEdit placeholder="请输入内容...." @editOk="editOk" uploadFileUrl="/#" html="  "></jinEdit>
		</view>
	</view>
</template>

<script>
	var loginRes, _self;
	var signModel = require('../../commons/sign.js');
	import jinEdit from '../../components/jin-edit/jin-edit.vue';
	export default {
	data() {
		return {
			iconImg : '',
			title : '',
			artList : [],
			inputContent : "",
			needUploadImg : [],
			uploadIndex : 0,
			//分类
			caties : ['点击选择'],
			currentCateIndex : 0,
			catiesFromApi : [],
			// 记录真实选择的api接口数据的分类id
			sedCateIndex  : 0,
			real_content : "",
		}
	},
	components: {
		jinEdit
	},
	onLoad:function(){
		_self = this;
		this.iconImg = "http://139.196.197.242/imgs/wh.png";
		loginRes = this.checkLogin("../write/write", 2);
		if(!loginRes){return false;};
		signModel.sign(_self.apiServer);
		// 加载文章分类
		uni.request({
			url: this.apiServer+'category&m=index',
			method: 'GET',
			success: res => {
				var data = res.data;
				res = JSON.parse(data.slice(data.indexOf('{')));
				if(res.status == 'ok'){
					// 把数据格式整理为 picker 支持的格式 ['分类名', ...]
					var categories = res.data;
					for(var k in categories){
						_self.caties.push(categories[k]);
					}
					// 记录分类信息
					_self.catiesFromApi = categories;
				}
			}
		});
	},
	methods: {
		addicon : function(){
			uni.chooseImage({
				count: 1,
				sizeType: ['compressed'],
				success: function(res) {
					_self.iconImg = res.tempFilePaths[0];
				}
			})
		},
		addImg : function(){
			uni.chooseImage({
				count: 9,
				sizeType: ['compressed'],
				success: function(res) {
					console.log(res);
					if(res.errMsg == "chooseImage:ok")
					{
						uni.showToast({
							title: "插入成功",
							duration: 1000
						})
					}
					for (var i = 0; i < res.tempFilePaths.length; i++) {
					  _self.artList.push({"type":"image", "content" : res.tempFilePaths[i]})
					}
				}
			})
		},
		cateChange : function(e){
			var sedIndex          = e.detail.value;
			this.currentCateIndex = sedIndex;
			// 获取选择的分类名称
			if(sedIndex < 1){return ;}
			var cateName = this.caties[sedIndex];
			for(var k in this.catiesFromApi){
				if(cateName == this.catiesFromApi[k]){
					this.sedCateIndex = k;
					break;
				}
			}
			this.currentCateIndex = sedIndex;	
		},	
		submitNow : function(){
			// 数据验证
			if(this.title.length < 2){uni.showToast({title:'请输入标题', icon:"none"}); return ;}
			if(this.sedCateIndex < 1){uni.showToast({title:'请选择分类', icon:"none"}); return ;}
			// 上传图片 一次一个多次上传 [ 递归函数 ]
			// 上传完成后整体提交数据
			// 首先整理一下需要上传的图片
			// this.needUploadImg = [{tmpurl : 临时地址, index : 数据索引}]
			this.needUploadImg = [];
			for(var i = 0; i < this.artList.length; i++){
				if(this.artList[i].type == 'image'){
					this.needUploadImg.push({"tmpurl" : this.artList[i].content , "indexID" : i});
				}
			}
			if(this.txImg != "http://139.196.197.242/imgs/wh.png")
			{
				uni.showLoading({title:"上传icon"});
				var uploader = uni.uploadFile({
					url      : _self.apiServer + 'uploadimg',
					filePath : this.iconImg,
					name     : 'file',
					success: (uploadFileRes) => {
						var data = uploadFileRes.data;
						uploadFileRes = JSON.parse(data.slice(data.indexOf('{')));
						if(uploadFileRes.status != 'ok'){
							uni.showToast({title:"上传icon失败,请重试!", icon:"none"});
							return false;
						}
						this.iconImg = _self.staticServer + uploadFileRes.data;
					}
				})
			}
			setTimeout(function(){_self.uploadImg();}, 2000);
		},
		uploadImg : function(){
			//如果没有图片 或者已经上传完成 则执行提交
			if(this.needUploadImg.length < 1 || this.uploadIndex >=  this.needUploadImg.length){
				//
				uni.showLoading({title:"正在提交"});
				var sign = uni.getStorageSync('sign');
				uni.request({
					url: this.apiServer + 'art&m=add',
					method: 'POST',
					header: {'content-type' : "application/x-www-form-urlencoded"},
					data:{
						title   : _self.title,
						uid     : loginRes[0],
						random  : loginRes[1],
						cate    : _self.sedCateIndex,
						sign    : sign,
						content : JSON.stringify(_self.artList),
						real_content: _self.real_content,
						icon    : this.iconImg,
						download : this.download
					},
					success:function(res){
						var data = res.data;
						res = JSON.parse(data.slice(data.indexOf('{')));
						console.log(res);
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
								uni.switchTab({
									url:'../my/my'
								})
							}, 2000);
						}else{
							uni.showToast({title:"失败啦"});
						}
					}
				});
				
			}else{
				// 上传图片
				uni.showLoading({title:"上传图片"});
				var uploader = uni.uploadFile({
					url      : _self.apiServer + 'uploadimg',
					filePath : _self.needUploadImg[_self.uploadIndex].tmpurl,
					name     : 'file',
					success: (uploadFileRes) => {
						console.log("hhh",uploadFileRes)
						var data = uploadFileRes.data;
						uploadFileRes = JSON.parse(data.slice(data.indexOf('{')));
						if(uploadFileRes.status != 'ok'){
							uni.showToast({title:"上传图片失败,请重试!", icon:"none"});
							return false;
						}
						// 将已经上传的文件地址赋值给文章数据
						var index = _self.needUploadImg[_self.uploadIndex].indexID;
						_self.artList[index].content = _self.staticServer + uploadFileRes.data;
						_self.uploadIndex ++;
						// 递归上传
						setTimeout(function(){_self.uploadImg();}, 2000);
					},
					fail: (e) => {
						console.log(e);
						uni.showToast({title:"上传图片失败,请重试!", icon:"none"});
					}
				})
			}
		
		},
	
	// 点击发布
		editOk(res) {
			// 提交标题 首页展示图片 以及分类信息
			_self.real_content = JSON.stringify(res.html)
			this.submitNow();
			// 提交文章数据
		}
		}
	}
</script>

<style>
	
</style>
