<?php
namespace hsC;

class rank{
	public function getList(){
        $_GET['page'] = empty($_GET['page']) ? 1 : intval($_GET['page']);
        $dbArticles = \hsTool\db::getInstance('articles');
        if($_GET['cate'] == 0){
        	$arts = $dbArticles
				->join('as a left join gufeng_members as b on a.art_uid = b.u_id')
				->order('art_browse desc')
				->limit(($_GET['page'] - 1) * 10, 10)
				->fetchAll();
        }else{
        	$arts = $dbArticles
				->join('as a left join gufeng_members as b on a.art_uid = b.u_id')
				->order('art_agree desc')
				->limit(($_GET['page'] - 1) * 10, 10)
				->fetchAll();
        }
        if(empty($arts)){exit(jsonCode('empty', ''));}
        exit(jsonCode('ok', $arts));
    }
}
