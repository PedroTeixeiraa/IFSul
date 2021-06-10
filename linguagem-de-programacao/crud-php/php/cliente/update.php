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

	$sql = "SELECT * FROM cliente WHERE codigo=$codigo";
	$result = mysqli_query($conn, $sql);

	if (mysqli_num_rows($result) > 0) {
		$row = mysqli_fetch_assoc($result);
	}	else {
		header("Location: read.php");
	}

} else if(isset($_POST['update'])) {
	include "../../db_conn.php";

	function validate($data){
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}

	$name = validate($_POST['name']);
	$email = validate($_POST['email']);
	$codigo = validate($_POST['codigo']);

	if (empty($name)) {
		header("Location: ../../pages/cliente/update.php?id=$id&error=Name is required");
	} else if (empty($email)) {
		header("Location: ../../pages/cliente/update.php?id=$id&error=Email is required");
	} else {
		$sql = "UPDATE cliente SET nome='$name', email='$email' WHERE codigo=$codigo ";
		$result = mysqli_query($conn, $sql);
		if ($result) {
			header("Location: ../../pages/cliente/read.php?success=successfully updated");
		}else {
			header("Location: ../../pages/cliente/update.php?id=$id&error=unknown error occurred&$user_data");
		}
	}
} else {
	header("Location: read.php");
}