<?php
namespace hsC;
class member{
	
	public function wxaes(){
		if(empty($_POST['session_key']) || empty($_POST['encryptedData']) || empty($_POST['iv'])){exit(jsonCode('error', 'data error'));}
		include HS_TOOLS.'WXBizDataCrypt.php';
		$pc = new \WXBizDataCrypt(HS_APPID, $_POST['session_key']);
		$data = '';
        $errCode = $pc->decryptData($_POST['encryptedData'], $_POST['iv'], $data);
        if ($errCode == 0) {
            exit($data);
        } else {
            exit(jsonCode('error', $errCode));
        }
	}
	
	public function codeToSession(){
		$url =  "https://api.weixin.qq.com/sns/jscode2session?appid=".HS_APPID.
        "&secret=".HS_SECRET."&js_code=".$_GET['code']."&grant_type=authorization_code";
		
		$curl = new \hsTool\curl();
		$res = $curl->get($url);
		echo $res;
	}
	
	public function regist(){
		$db = \hsTool\db::getInstance('members');
		$member = $db->where('u_openid = ?', array($_POST['openid']))->fetch();

		if(empty($member)){
			$member = array();
			$member['u_openid'] = $_POST['openid'];
			$member['u_name']   = $_POST['username'];
			$member['u_face']   = $_POST['face'];
			$member['u_password'] = $_POST['password'];
			$member['u_random'] = uniqid();
			$member['u_regtime']= time();
			$member['u_id']     = $db->add($member);
		}else{
			exit(jsonCode('exist', $member));
		}
		exit(jsonCode('ok', $member));
	}
	
	public function loginc(){
		$db = \hsTool\db::getInstance('members');
		$member = $db->where('u_openid = ?', array($_POST['openid']))->fetch();
		if(empty($member)){
			exit(jsonCode('empty', '未注册'));
		}
		if($_POST['password'] != $member['u_password']){
			exit(jsonCode('wrong', '密码错误'));
		}
		exit(jsonCode('ok', $member));
	}
	
	public function login(){
		// 签名验证
		checkSign();
		//调用模型完成用户登录及注册
        $memberModel = new \hsModel\member();
        $memberModel->login();
	}
}