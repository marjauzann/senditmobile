<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    @vite('resources/css/app.css')
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 text-gray-900">
    <div class="flex h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-white shadow-md">
            <div class="p-4 text-lg font-bold">
                <span class="text-indigo-600">argon</span>
            </div>
            <nav class="mt-6">
                <a href="#" class="flex items-center p-2 text-gray-600 hover:bg-gray-200 rounded-md">
                    <span>Dashboard</span>
                </a>
                <a href="#" class="flex items-center p-2 text-gray-600 hover:bg-gray-200 rounded-md">
                    <span>Laravel Examples</span>
                </a>
                <a href="#" class="flex items-center p-2 text-gray-600 hover:bg-gray-200 rounded-md">
                    <span>Profile</span>
                </a>
            </nav>
        </aside>

        <!-- Main content -->
        <div class="flex-1 flex flex-col">
            <!-- Topbar -->
            <header class="bg-white shadow p-4 flex justify-between items-center">
                <div class="text-lg font-semibold">Dashboard</div>
                <div class="flex items-center space-x-4">
                    <input type="text" placeholder="Search..." class="p-2 border rounded-md">
                    <button class="bg-blue-600 text-white px-4 py-2 rounded">Admin</button>
                </div>
            </header>

            <!-- Content -->
            <main class="flex-1 p-6 space-y-6">
                <!-- Cards Section -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Card 1 -->
                    <div class="bg-purple-500 text-white p-4 rounded-lg shadow-md">
                        <h3 class="text-lg">Tasks Completed</h3>
                        <p>8/24</p>
                        <button class="mt-2 bg-white text-purple-500 px-3 py-1 rounded">See details</button>
                    </div>
                    <!-- Card 2 -->
                    <div class="bg-blue-500 text-white p-4 rounded-lg shadow-md">
                        <h3 class="text-lg">Contacts</h3>
                        <p>123/267</p>
                        <button class="mt-2 bg-white text-blue-500 px-3 py-1 rounded">See details</button>
                    </div>
                    <!-- Card 3 -->
                    <div class="bg-red-500 text-white p-4 rounded-lg shadow-md">
                        <h3 class="text-lg">Items Sold</h3>
                        <p>200/300</p>
                        <button class="mt-2 bg-white text-red-500 px-3 py-1 rounded">See details</button>
                    </div>
                    <!-- Card 4 -->
                    <div class="bg-indigo-500 text-white p-4 rounded-lg shadow-md">
                        <h3 class="text-lg">Notifications</h3>
                        <p>50/62</p>
                        <button class="mt-2 bg-white text-indigo-500 px-3 py-1 rounded">See details</button>
                    </div>
                </div>

                <!-- Graph Section -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="bg-white p-4 rounded-lg shadow-md">
                        <h3 class="text-xl font-bold">Sales Value</h3>
                        <canvas id="salesChart"></canvas>
                    </div>
                    <div class="bg-white p-4 rounded-lg shadow-md">
                        <h3 class="text-xl font-bold">Total Orders</h3>
                        <canvas id="ordersChart"></canvas>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            <footer class="bg-white shadow p-4">
                <div class="text-center">
                    © 2024 Admin Dashboard. All Rights Reserved.
                </div>
            </footer>
        </div>
    </div>

    <script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        // Sales Chart
        const ctxSales = document.getElementById('salesChart').getContext('2d');
        new Chart(ctxSales, {
            type: 'line',
            data: {
                labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'],
                datasets: [{
                    label: 'Sales',
                    data: [30, 50, 40, 60, 70, 90, 100],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                }]
            }
        });

        // Orders Chart
        const ctxOrders = document.getElementById('ordersChart').getContext('2d');
        new Chart(ctxOrders, {
            type: 'bar',
            data: {
                labels: ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Orders',
                    data: [10, 20, 15, 25, 30, 35],
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            }
        });
    </script>
</body>
</html>
