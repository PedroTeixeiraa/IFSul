<?php

include "../../db_conn.php";

$sql = "SELECT * FROM cliente ORDER BY codigo DESC";
$result = mysqli_query($conn, $sql);

