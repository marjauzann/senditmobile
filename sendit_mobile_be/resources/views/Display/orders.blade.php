<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Panel Sendit</title>
        <!-- Link ke CSS -->
        <link rel="stylesheet" href="{{ asset('css/styleAdmin.css') }}">
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
        />
        <style>
            /* Styling tambahan untuk tabel */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table th, table td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            table th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            table tr:hover {
                background-color: #f1f1f1;
            }
            .btn {
                padding: 6px 12px;
                margin: 5px;
                border-radius: 5px;
                text-decoration: none;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-success:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        @include('Display.sidebar')

        <!-- Main Content -->
        <div class="main-content">
            <h1>Orders</h1>

            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <div class="dashboard-card">
                    <h3>Total Users</h3>
                    <p id="total-users">1,234</p>
                </div>
                <div class="dashboard-card">
                    <h3>Total Orders</h3>
                    <p id="total-orders">56</p>
                </div>
                <div class="dashboard-card">
                    <h3>Total Revenue</h3>
                    <p id="total-revenue">$12,345</p>
                </div>
                <div class="dashboard-card">
                    <h3>Active Users</h3>
                    <p id="active-users">789</p>
                </div>
            </div>

            <!-- CRUD Table for Orders -->
            <div class="crud-table">
                <h2>Manage Orders</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Nama Pengirim</th>
                            <th>Nama Penerima</th>
                            <th>Alamat Tujuan</th>
                            <th>Harga</th>
                            <th>Tanggal</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>Jane Smith</td>
                            <td>123 Main St</td>
                            <td>$100</td>
                            <td>2023-01-01</td>
                            <td>
                                <a href="#" class="btn btn-primary">Edit</a>
                                <form action="#" method="POST" style="display:inline;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td>Michael Johnson</td>
                            <td>Emily Davis</td>
                            <td>456 Elm St</td>
                            <td>$150</td>
                            <td>2023-02-01</td>
                            <td>
                                <a href="#" class="btn btn-primary">Edit</a>
                                <form action="#" method="POST" style="display:inline;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- Tombol untuk Menambah Order Baru -->
                <a href="#" class="btn btn-success">Add New Order</a>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
        <script>
            // Data untuk Chart
            const salesData = {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                datasets: [
                    {
                        label: "Sales",
                        data: [4000, 3000, 5000, 4500, 6000, 5500],
                        backgroundColor: "rgba(54, 162, 235, 0.5)",
                        borderColor: "rgba(54, 162, 235, 1)",
                        borderWidth: 1,
                    },
                ],
            };

            // Inisialisasi Chart
            const ctx = document.getElementById("sales-chart").getContext("2d");
            new Chart(ctx, {
                type: "bar",
                data: salesData,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                        },
                    },
                },
            });
        </script>
    </body>
</html>
