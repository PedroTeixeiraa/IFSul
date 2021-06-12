<?php

if (isset($_GET['codigo'])) {
  include "../../db_conn.php";
  function validate($data){
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
  }

  $codigo = validate($_GET['codigo']);

  $sql = "DELETE FROM cliente WHERE codigo=$codigo";
  $result = mysqli_query($conn, $sql);

  if ($result) {
    header("Location: ../../pages/cliente/read.php?success=successfully deleted");
  } else {
    header("Location: ../../pages/cliente/read.php?error=unknown error occurred&$user_data");
  }
} else {
  header("Location: ../../pages/cliente/read.php");
}