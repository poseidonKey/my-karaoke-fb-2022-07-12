<?php
  $dbName="appDB";
  $connect=mysql_connect("localhost","jsy","jsy1030") or die("실패!");
  mysql_select_db($dbName,$connect);

  $query="CREATE TABLE IF NOT EXISTS my_karaoke_db (" .
  "id int(10) UNSIGNED NOT NULL primary key auto_increment," .
  "songOwnerId VARCHAR(100)," .
  "songName  varchar(100) NULL," .
  "songGYNumber  varchar(20) NULL," .
  "songTJNumber  varchar(20) NULL," .
  "songJanre VARCHAR(20)," .
  "songUtubeAddress VARCHAR(200)," .
  "songETC VARCHAR(100)" .
  ") ENGINE=InnoDB DEFAULT CHARSET=utf8";
  
  mysql_query($query,$connect);
  
  echo "table을 생성했습니다..";
  
?>