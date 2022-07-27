<?php
	$dbName="appDB";
	//$year=$_GET["year"];
	$connect=mysql_connect("localhost","jsy","jsy1030") or die("실패!");
	mysql_select_db($dbName,$connect);

	//$query="select * from my_karaoke_db order by id desc";
	$query="select * from my_karaoke_db order by id ";
	$result=mysql_query($query,$connect);
	$str="[";
	while($data=mysql_fetch_array($result)) {
		$tmp= '{"id":"'.$data[id] . '","songOwnerId":"' . $data[songOwnerId] . '","songName":"' . $data[songName] . '","songGYNumber":"' . $data[songGYNumber]. '","songTJNumber":"' . $data[songTJNumber].'","songJanre":"'.$data[songJanre].'","songUtubeAddress":"'.$data[songUtubeAddress].'","songETC":"'.$data[songETC].'"},';
		$str .= $tmp;
    }
    $str = substr($str, 0, -1);
    $str.="]";
	echo $str;
?>