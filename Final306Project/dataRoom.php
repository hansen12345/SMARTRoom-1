<?php 
   
   $dbhost = '127.0.0.1:3306';
   $dbuser = 'root';
   $dbpass = 'Pngflip94!';
   $conn = mysql_connect($dbhost, $dbuser, $dbpass);
   
   if(! $conn )
   {
     die('Could not connect: ' . mysql_error());
   }
   $sql = 'SELECT * FROM Rooms';
   mysql_select_db('testRoomData');
   $retval = mysql_query($sql, $conn); 
   
   if (!$retval ) {
   	die('Could not get data: ' . mysql_error());
   }

   $types = array();
   $room = "room";
   $inside = array();
    
   while($row = mysql_fetch_assoc($retval)) {
    $count++;
   	$room = "room$count";
   	/*$row_array[$room]['roomNumber'] = $row['roomNumber'];
   	$row_array[$room]['lamp'] = $row['lamp'];
   	$row_array[$room]['tv'] = $row['tv'];
   	$row_array[$room]['roomLight'] = $row['roomLight'];
   	$row_array[$room]['acUnit'] = $row['acUnit'];*/
    
    $inside = array($row_array[$room]['roomNumber'] = $row['roomNumber'], $row_array[$room]['lamp'] = $row['lamp'], $row_array[$room]['tv'] = $row['tv'], $row_array[$room]['roomLight'] = $row['roomLight'], $row_array[$room]['acUnit'] = $row['acUnit']);
   }
    
   	array_push($types, $row_array);

   echo json_encode($types);
   
   $fp = fopen('results.json', 'w');
   fwrite($fp, json_encode($types));


   mysql_close($conn);
?>
