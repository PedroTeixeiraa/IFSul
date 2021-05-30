<?php include "php/read.php"; ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Read</title>
  <link 
    rel="stylesheet" 
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
    crossorigin="anonymous"
  >
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/style_read.css">
</head>
<body>
  <div class="container">
    <div class="box">
      <h4 class="display-4 text-center">Read</h4><hr>
      <?php if (isset($_GET['error'])) { ?>
        <div class="alert alert-success" role="alert">
          <?php echo $_GET['success']; ?>
        </div>
      <?php } ?>
      
      <?php if(mysqli_num_rows($result)) { ?>
        <table class="table table-striped">
          <thead>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">E-mail</th>
            <th scope="col">Action</th>    
          </thead>
          <tbody> 
            <?php 
            $i = 0;
            while($rows = mysqli_fetch_assoc($result)) { 
              $i++; ?>
              <tr>
                <th scope="row"><?=$i?></th>
                <td><?=$rows['name']?></td>  
                <td><?php echo $rows['email']; ?></td>
                <td>
                  <a 
                    href="update.php?id=<?=$rows['id']?>" 
                    class="btn btn-success"
                  >
                    Update
                  </a>
                  
                  <a 
                    href="php/delete.php?id=<?=$rows['id']?>" 
                    class="btn btn-danger"
                  >
                    Delete
                  </a>
                </td>
              </tr>
            <?php } ?>
          </tbody>
        </table>
      <?php } ?>
      <div class="link-right">
        <a href="index.php" class"link-primary">Create</a>
      </div>
    </div>
  </div>
</body>
</html>