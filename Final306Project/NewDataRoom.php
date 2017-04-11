<?php
    
    $dbhost = 'smartroom.czjl1dned5qh.us-west-2.rds.amazonaws.com';
    $dbuser = 'front6';
    $dbpass = 'newfrontier';
    $conn = mysql_connect($dbhost, $dbuser, $dbpass);
    
    if(! $conn )
    {
        die('Could not connect: ' . mysql_error());
    }
    $sql = 'SELECT SMARTRoom.Room.customer_id, Room.room_name, Room.room_id, Component.room_id, Component.component_name, Component.component_status From Room INNER JOIN Component ON Room.room_id = Component.room_id;';
    mysql_select_db('SMARTRoom');
    $retval = mysql_query($sql, $conn);
    
    if (!$retval) {
        die('Could not get data: ' . mysql_error());
    }
    
    $types['Component'] = array();
    $room = "room";
    $inside = array();
    $count = 0;
    while($row = mysql_fetch_assoc($retval)) {
        $count++;
        $room = "comp$count";
        $customerID = $row['customer_id'];
        $roomName = $row['room_name'];
        $roomID = $row['room_id'];
        $componentName = $row['component_name'];
        $componentStatus = $row['component_status'];
        
        $inside = array($row_array['customer_id'] = $row['customer_id'], $row_array['room_name'] = $row['room_name'], $row_array['room_id'] = $row['room_id'], $row_array['component_name'] = $row['component_name'], $row_array['component_status'] = $row['component_status']);
        
        array_push($types['Component'], $row_array);
    }
    
    //print_r(array_values($row_array));
    
    echo json_encode($types)."\n\n";
    
    $fp = fopen('newResults.json', 'w');
    fwrite($fp, json_encode($types));
    
    mysql_close($conn);
?>

