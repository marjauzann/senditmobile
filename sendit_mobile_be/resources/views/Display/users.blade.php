<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Users Page</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/Css/styleUsers.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
  </head>
  <body>
    <div class="sidebar">
      <h2>Admin Panel Sendit</h2>
      <ul>
        <li>
          <a href="dashboard.html"><i class="fas fa-home"></i> Dashboard</a>
        </li>
        <li>
          <a href="users.html"><i class="fas fa-users"></i> Users</a>
        </li>
        <li>
          <a href="#"><i class="fas fa-shopping-cart"></i> Orders</a>
        </li>
        <li>
          <a href="#"><i class="fas fa-cog"></i> Settings</a>
        </li>
        <li>
          <a href="#"><i class="fas fa-question-circle"></i> Help</a>
        </li>
      </ul>
    </div>

    <div class="main-content">
      <h1>Users</h1>
      <div class="users-header">
        <div class="users-card">
          <h3>Total Users</h3>
          <p id="total-users"><i class="fas fa-users" style="font-size: 24px"></i> 150</p>
        </div>
        <div class="users-card">
          <h3>Kurir</h3>
          <p id="kurir"><i class="fas fa-biking" style="font-size: 24px"></i> 50</p>
        </div>
        <div class="users-card">
          <h3>Customer</h3>
          <p id="customer"><i class="fas fa-user" style="font-size: 24px"></i> 100</p>
        </div>
      </div>
      <div class="data-users">
        <h2>Data Users</h2>
        <form>
          <input type="text" id="search-input" name="search-input" placeholder="Cari berdasarkan nama, username, atau role..." />
        </form>
        <table id="users-table">
          <thead>
            <tr>
              <th>No</th>
              <th>ID Users</th>
              <th>Username</th>
              <th>Nama</th>
              <th>Alamat</th>
              <th>No Telp</th>
              <th>Role</th>
              <th>Password</th>
            </tr>
          </thead>
          <tbody id="usersTableBody"></tbody>
        </table>
      </div>
    </div>

    <script>
      $(document).ready(function () {
        $.getJSON("/JSON/usersData.json", function (usersData) {
          const $tableBody = $("#users-table tbody");

          usersData.users.forEach((user) => {
            const row = `
                <tr>
                    <td>${user.no}</td>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.nama}</td>
                    <td>${user.alamat}</td>
                    <td>${user.noTelp}</td>
                    <td>${user.role}</td>
                    <td>${user.password}</td>
                </tr>
            `;
            $tableBody.append(row);
          });
        }).fail(function () {
          console.error("Gagal mengambil data JSON.");
        });
      });
    </script>
  </body>
</html>
