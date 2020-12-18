<?php
namespace hsC;
class getAccessToken{
	public function index(){
		$db = \hsTool\db::getInstance('access_tokens');
		$token = array(
            'token' => uniqid(),// php函数 生成唯一不重复的字符串
            'time'  => time()
        );
        $db->add($token);
		exit(jsonCode('ok', $token));
	}	
}