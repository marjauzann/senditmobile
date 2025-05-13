<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Panel Sendit - Dashboard</title>
    <link rel="stylesheet" href="{{ asset('css/styleAdmin.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  </head>
  <body>
    @include('Display.sidebar')

    <div class="main-content">
      <h1>Admin Dashboard</h1>
      <div class="dashboard-header">
        <div class="dashboard-card">
          <h3>Total Orders</h3>
          <p id="total-orders">56</p>
        </div>
      </div>
    </div>

    <script>
      fetch("/JSON/usersData.json")
        .then((response) => response.json())
        .then((usersData) => {
          // Set total orders card
          document.getElementById("total-orders").textContent = usersData.users.length * 2 || "N/A";
        })
        .catch((error) => console.error("Error fetching users data:", error));
    </script>
  </body>
</html>
