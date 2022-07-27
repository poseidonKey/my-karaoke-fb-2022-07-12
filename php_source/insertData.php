<?php    
  $connect=mysql_connect("localhost","jsy","jsy1030") or die("실패");
  mysql_select_db("appDB",$connect);
    
  $songOwnerId=$_GET['songOwnerId'];
  $songName=$_GET['songName'];
  $songGYNumber=$_GET['songGYNumber'];
  $songTJNumber=$_GET['songTJNumber'];
  $songJanre=$_GET['songJanre'];
  $songUtubeAddress=$_GET['songUtubeAddress'];
  $songETC=$_GET['songETC'];
  
   // $query="insert into my_karaoke_db values(" .
     //   " '','owner 55','name5','1111','2222','클래식','http://youtube.com','기타5')";
    $query="insert into my_karaoke_db values(" .
          " '',$songOwnerId,$songName,$songGYNumber,$songTJNumber,$songJanre,$songUtubeAddress,$songETC )";
    mysql_query($query,$connect);
    mysql_close($connect);
    echo "ok!!";
?>
