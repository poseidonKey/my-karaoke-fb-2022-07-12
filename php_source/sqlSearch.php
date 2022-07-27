<?php
  $name=$_GET['name'];
  $connect=mysql_connect("localhost","jsy","jsy1030") or die("실패");
  mysql_select_db("appDB",$connect);
//  $query="select * from studentName" ;
  $query="select * from studentName where sName like '%" . $name . "%'";
  $str="";

  $result=mysql_query($query,$connect);
  while($data=mysql_fetch_array($result)) {
      $str.="$data[sId],$data[sYear],$data[sBan],$data[sNum],$data[sName]";
  #    echo "$data[sId] -> $data[sName]<br>";
    }
  echo $str;
?>