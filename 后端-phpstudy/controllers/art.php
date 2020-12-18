<?php
namespace hsC;
class art{
	
	public function getList(){
        $_GET['cate'] = empty($_GET['cate']) ? 0 : intval($_GET['cate']);
        $_GET['page'] = empty($_GET['page']) ? 1 : intval($_GET['page']);
        $dbArticles = \hsTool\db::getInstance('articles');
        if(empty($_GET['cate'])){
            $arts = $dbArticles->order('art_id desc')->limit(($_GET['page'] - 1) * 10, 10)->fetchAll();
        }else{
            $arts = $dbArticles->where('art_cate = ?', array($_GET['cate']))->order('art_id desc')->limit(($_GET['page'] - 1) * 10, 10)->fetchAll();
        }
        if(empty($arts)){exit(jsonCode('empty', ''));}
        exit(jsonCode('ok', $arts));
    }
    
    public function infoWithUser(){
        if(empty($_GET['artid'])){exit(jsonCode('error', 'art data error'));}
        $_GET['artid'] = intval($_GET['artid']);
        $dbArticles = \hsTool\db::getInstance('articles');
        $art = $dbArticles
                ->join('as a left join gufeng_members as b on a.art_uid = b.u_id')
                ->where('a.art_id = ?', $_GET['artid'])
                ->fetch('a.*, b.u_id, b.u_name, b.u_face');
        if(empty($art)){exit(jsonCode('empty', ''));}
        $art['art_browse'] = $art['art_browse'] + 1;
        $art['art_createtime'] = date('Y-m-d H:i', $art['art_createtime']);
        $data = array(
			'art_browse'     => $art['art_browse']
		);
		$dbArticles->where('art_id = ?', $_GET['artid'])->update($data);
        exit(jsonCode('ok', $art));
    }
	
	public function edit(){
		// 验证签名
		checkSign();
		// 验证用户合法性
		$user = checkUser();
		// 检查文章
		if(empty($_GET['artid'])){exit(jsonCode('error', 'art data error'));}
		$dbArticles = \hsTool\db::getInstance('articles');
		$art = $dbArticles->where('art_id = ?', $_GET['artid'])->fetch();
		if(empty($art)){exit(jsonCode('error', 'art data error'));}
		if($art['art_uid'] != $user['u_id']){exit(jsonCode('error', 'art data error'));}
		$data = array(
			'art_title'      => $_POST['title'],
			'art_uid'        => $user['u_id'],
			'art_cate'       => intval($_POST['cate']),
			'art_content'    => $_POST['content'],
			'art_real_content' => $_POST['real_content']
		);
		$dbArticles->where('art_id = ?', $_GET['artid'])->update($data);
		exit(jsonCode('ok', $art));
	}
	
	public function info(){
		if(empty($_GET['artid'])){exit(jsonCode('error', 'art data error'));}
		$_GET['artid'] = intval($_GET['artid']);
		$dbArticles = \hsTool\db::getInstance('articles');
		$art = $dbArticles->where('art_id = ?', $_GET['artid'])->fetch();
		if(empty($art)){exit(jsonCode('empty', ''));}
		exit(jsonCode('ok', $art));
	}
	
	public function add(){

		/* $_POST 格式 
		(
		    [title] => title
		    [content] => [
		 * 		{"type":"image","content":"http://192.168.31.188/imgs/5c174b0fb3825.png"},
		 * 		{"type":"text","content":"hi123"},
		 * 		{"type":"image","content":"http://192.168.31.188/imgs/5c174b0fc3297.png"},
		 * 		{"type":"text","content":"hi222"}]
		    [uid] => 8
		    [random] => ****
			[cate] => 1
		    [sign] => sign
		)
		*/
		// 验证签名
		checkSign();
		// 验证用户合法性
		$user = checkUser();
		// 提交主要信息
		$dbArticles = \hsTool\db::getInstance('articles');
		$addData = array(
			'art_title'      => $_POST['title'],
			'art_uid'        => $user['u_id'],
			'art_cate'       => intval($_POST['cate']),
			'art_content'    => $_POST['content'],
			'art_createtime' => time(),
			'art_real_content' => $_POST['real_content'],
			'art_icon'       => $_POST['icon'],
			'art_download'   => $_POST['download']
		);
		$articleId = $dbArticles->add($addData);
		if(!$articleId){exit(jsonCode('error', '服务器忙请重试'));}
		// 更新会员积分
		$memberDb = \hsTool\db::getInstance('members');
		$memberDb->where('u_id = ?', array($user['u_id']))->filed('u_integral', 10);
		$memberDb->where('u_id = ?', array($user['u_id']))->filed('u_remainder', 10);
		exit(jsonCode('ok', 'ok'));
	}
	
	public function dz(){
		// 验证签名
		checkSign();
		// 验证用户合法性
		$user = checkUser();
		// 提交主要信息
		if(empty($_POST['artid'])){exit(jsonCode('error', 'art data error'));}
		$dbArt = \hsTool\db::getInstance('articles');
		$dbMem = \hsTool\db::getInstance('members');
		if($user['u_remainder'] == 0){exit(jsonCode('empty', 'interal is zero'));}
		$data1 = array(
			'u_integral'    => $user['u_integral'] + 1,
			'u_remainder'   => $user['u_remainder'] - 1
		);
		$dbMem->where('u_id = ?', $user['u_id'])->update($data1);
		$art = $dbArt
				->where('gufeng_articles.art_id = ?', $_POST['artid'])
				->fetch('gufeng_articles.*');
		if(empty($art)){exit(jsonCode('empty', ''));}
		$data2 = array(
			'art_agree'     => $art['art_agree'] + 1
		);
		$dbArt->where('art_id = ?', $_POST['artid'])->update($data2);
        exit(jsonCode('ok', $art));
	}
}
