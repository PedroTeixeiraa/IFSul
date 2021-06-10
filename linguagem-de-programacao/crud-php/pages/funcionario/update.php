<?php include('../../php/funcionario/update.php')?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Atualizar Funcionário</title>
  <link 
    rel="stylesheet" 
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
    crossorigin="anonymous"
  >
  <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
  <div class="container">
    <form action="../../php/funcionario/update.php" method="post"> 
      <h4 class="display-4 text-center">Editar Funcionário</h4><hr><br>
      
      <?php if (isset($_GET['error'])) { ?>
        <div class="alert alert-danger" role="alert">
          <?php echo $_GET['error']; ?>
        </div>
      <?php } ?>

      <div class="form-group">
        <label for="name">Name</label>
        <input 
          type="name" 
          class="form-control" 
          id="name" 
          name="name"
          value="<?=$row['nome']?>"
        >
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <input 
          type="email" 
          class="form-control" 
          id="email" 
          name="email"
          value="<?=$row['email']?>"
        >
      </div>
	  <input type="text"
	  		 name="codigo"
			 value="<?=$row['codigo']?>"
			 hidden
			>

      <button 
        type="submit" 
        class="btn btn-primary"
        name="update"
      >
        Update
      </button>

      <a href="read.php" class"link-primary">View</a>
    </form>
  </div>
</body>
</html>

