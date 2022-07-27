<?php
  $conn=mysql_connect("localhost","jsy","jsy1030");
  mysql_select_db("appDB",$conn);

  $id=$_GET['id'];
  $query="delete from my_karaoke_db where id='" . $id . "'";
  mysql_query($query,$conn);
  mysql_close($connect);
    echo "ok!!";
?>