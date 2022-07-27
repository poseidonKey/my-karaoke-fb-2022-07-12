<?php
  $conn=mysql_connect("localhost","jsy","jsy1030");
  mysql_select_db("appDB",$conn);  
  
  $id=$_GET['id'];    
  $songName=$_GET['songName'];
  $songGYNumber=$_GET['songGYNumber'];  
  $songJanre=$_GET['songJanre'];
  
  
  $songOwnerId=$_GET['songOwnerId'];
  $songTJNumber=$_GET['songTJNumber'];
  
  $songUtubeAddress=$_GET['songUtubeAddress'];
  $songETC=$_GET['songETC'];
  
 $query="update my_karaoke_db set " .  
  " songName=$songName, songJanre=$songJanre, songGYNumber=$songGYNumber, " .    
  " songTJNumber=$songTJNumber, " .    
  " songOwnerId=$songOwnerId, songUtubeAddress=$songUtubeAddress, songETC=$songETC " .  
  " where id='" . $id . "'";
 
  mysql_query($query,$conn);
  mysql_close($connect);
   echo "ok!!";
?>