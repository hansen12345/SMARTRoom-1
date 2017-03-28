<?php
    
    $dbhost = 'smartroom.czjl1dned5qh.us-west-2.rds.amazonaws.com';
    $dbuser = 'front6';
    $dbpass = 'newfrontier';
    $conn = mysql_connect($dbhost, $dbuser, $dbpass);
    
    if(! $conn )
    {
        die('Could not connect: ' . mysql_error());
    }
    $sql = 'SELECT * FROM Component';
    mysql_select_db('SMARTRoom');
    $retvalComp = mysql_query($sql, $conn);
    
    $sqlRoom = 'SELECT * FROM Room';
    mysql_select_db('SMARTRoom');
    $retvalRoom = mysql_query($sqlRoom, $conn);
    
    
    if (!$retvalComp ) {
        die('Could not get data: ' . mysql_error());
    }
    if (!$retvalRoom ) {
        die('Could not get data: ' . mysql_error());
    }
    
    $types = array();
    $room = "room";
    $inside = array();
    $count = 0;
    while($row = mysql_fetch_assoc($retvalRoom)) {
        $count++;
        $room = "Count$count";
        $inside = array($row_array[$room]['customer_id'] = $row['customer_id'], $row_array[$room]['room_id'] = $row['room_id'], $row_array[$room]['room_name'] = $row['room_name']);
        
    }
    $room2 = "room";
    $inside2 = array();
    $count2 = 0;
    while ($row2 = mysql_fetch_assoc($retvalComp)) {
        $count2++;
        $room2 = "Count$count";
        $inside2 = array($row_array[$room]['room_id'] = $row2['room_id'], $row_array[$room]['component_name'] = $row2['component_name'], $row_array[$room]['component_status'] = $row2['component_status']);
        
    }
    
   	array_push($types, $row_array);
    
    echo json_encode($types);
    
    $fp = fopen('newResults.json', 'w');
    fwrite($fp, json_encode($types));
    
    
    mysql_close($conn);
    ?>
