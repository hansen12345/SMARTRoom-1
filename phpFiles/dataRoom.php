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

   /*while($row = mysql_fetch_assoc($retval)) {
   	echo "Room Number :{$row['roomNumber']} ".
         "Lamp : {$row['lamp']} ".
         "TV : {$row['tv']} ". 
         "Room Light :{$row['roomLight']} ".
         "AC Unit : {$row['acUnit']} \n"; 
   }
   echo "Fetched data successfully\n";*/

   $types = array();
   $count = 0;
   $roomNumber = "room";
   while($row = mysql_fetch_assoc($retval)) {
   	$count; 
   	$roomNumber = "room$count";
   	$row_array[$roomNumber]['roomNumber'] = $row['roomNumber'];
   	$row_array[$roomNumber]['lamp'] = $row['lamp'];
   	$row_array[$roomNumber]['tv'] = $row['tv']; 
   	$row_array[$roomNumber]['roomLight'] = $row['roomLight']; 
   	$row_array[$roomNumber]['acUnit'] = $row['acUnit']; 
   	
   	array_push($types, $row_array);
   	
   }

   echo json_encode($types);
   
   $fp = fopen('results.json', 'w');
   fwrite($fp, json_encode($types));


   mysql_close($conn);
?>