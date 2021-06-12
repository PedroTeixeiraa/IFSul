<?php

include "../../db_conn.php";

$sql = "SELECT * FROM funcionario ORDER BY codigo DESC";
$result = mysqli_query($conn, $sql);

