<?php

$servidor = "localhost";
$usuario = "root";
$senha = '';

$banco = 'crud';

$conn = mysqli_connect($servidor, $usuario, $senha, $banco);

if (!$conn) {
  echo "Connection Failed!";
}
