<?php
namespace hsC;
class comment{
	public function add(){
		// 验证签名
		checkSign();
		// 验证用户合法性
		$user = checkUser();
		// 提交主要信息
		$dbCom = \hsTool\db::getInstance('comments');
		$addData = array(
			'art_id'         => $_POST['artid'],
			'u_id'        	 => $user['u_id'],
			'com_content'    => $_POST['content'],
			'com_createtime' => time(),
		);
		$articleId = $dbCom->add($addData);
		if(!$articleId){exit(jsonCode('error', '服务器忙请重试'));}
		exit(jsonCode('ok', 'ok'));
	}
	
	public function getList(){
		if(empty($_GET['artid'])){exit(jsonCode('error', 'art data error'));}
        $_GET['artid'] = intval($_GET['artid']);
        $dbCom = \hsTool\db::getInstance('comments');
        $com = $dbCom
                ->join('left join gufeng_members on gufeng_comments.u_id = gufeng_members.u_id')
                ->where('gufeng_comments.art_id = ?', $_GET['artid'])
                ->order('com_agree desc')
				->fetchAll('gufeng_comments.com_id,gufeng_comments.com_content,gufeng_comments.com_createtime,gufeng_comments.com_agree,gufeng_members.u_name,gufeng_members.u_face, gufeng_members.u_id');
		if(empty($com)){exit(jsonCode('empty', ''));}
		//$com['com_createtime'] = date('Y-m-d H:i', $com['com_createtime']);
		$num = count($com); 
		for ($i=0; $i<$num; $i++)
		{
   		 	$com[$i]['com_createtime'] = date('Y-m-d H:i', $com[$i]['com_createtime']);
		}
		exit(jsonCode('ok', $com));
	}
	
	public function dz(){
		// 验证签名
		checkSign();
		// 验证用户合法性
		$user = checkUser();
		// 提交主要信息
		if(empty($_POST['comid'])){exit(jsonCode('error', 'art data error'));}
		$dbCom = \hsTool\db::getInstance('comments');
		$dbMem = \hsTool\db::getInstance('members');
		if($user['u_remainder'] == 0){exit(jsonCode('empty', 'interal is zero'));}
		$data1 = array(
			'u_integral'    => $user['u_integral'] + 1,
			'u_remainder'   => $user['u_remainder'] - 1
		);
		$dbMem->where('u_id = ?', $user['u_id'])->update($data1);
		$com = $dbCom
				->where('gufeng_comments.com_id = ?', $_POST['comid'])
				->fetch('gufeng_comments.*');
		if(empty($com)){exit(jsonCode('empty', ''));}
		$data2 = array(
			'com_agree'     => $com['com_agree'] + 1
		);
		$dbCom->where('com_id = ?', $_POST['comid'])->update($data2);
        exit(jsonCode('ok', $com));
	}
}