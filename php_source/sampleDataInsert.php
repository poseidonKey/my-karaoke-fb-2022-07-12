<?php
  $fp=fopen("./dbData.txt","r");
  $connect=mysql_connect("localhost","jsy","jsy1030") or die("접속 실패.");
  mysql_select_db("php",$connect);
  
  while(!feof($fp)) {
    $contents=fgets($fp,200);
	echo $contents;
    $t=split(",",$contents);
    for($i=0;$i<$t.length;$i++) {
        $t[$i]=trim($t[$i]);
      }
    $query="insert into my_karaoke_db (id,songOwnerId,songName,songGYNumber,songTJNumber,songJanre,songUtubeAddress,songETC) values (Null,'$t[0]','$t[1]','$t[2]','$t[3]','$t[4]','$t[5]',,'$t[6]',,'$t[7]',)";
	// echo $query;
    mysql_query($query,$connect);
  }
  
  fclose($fp);
  mysql_close($connect);
  echo "작업 완료..";
?>
