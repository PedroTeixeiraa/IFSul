<?php

if (isset($_POST['create'])) {
  include "../../db_conn.php";

  function validate($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
  }

  $name = validate($_POST['name']);
  $email = validate($_POST['email']);

  $user_data = 'name='.$name. '&email='.$email;

  if (empty($name)) {
    header("Location: ../../pages/cliente/index.php?error=Name is required&$user_data");
  } else if (empty($email)) {
    header("Location: ../../pages/cliente/index.php?error=Email is required&$user_data");
  } else {
    
    $sql = "INSERT INTO cliente(nome, email) VALUES('$name', '$email')";
    $result = mysqli_query($conn, $sql);
    if ($result) {
      header("Location: ../../pages/cliente/read.php?success=successfully created");
    } else {
      header("Location: ../../pages/cliente/index.php?error=Unknown error occurred&$user_data");
    }
  }
};