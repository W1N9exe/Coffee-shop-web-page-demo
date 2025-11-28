<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "coffee_shop_db";

$response = [];

try {
    $order_number = isset($_GET['order_number']) ? trim($_GET['order_number']) : '';
    
    if (empty($order_number)) {
        throw new Exception('Order number is required');
    }
    
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $stmt = $conn->prepare("SELECT * FROM orders WHERE order_number = ?");
    $stmt->execute([$order_number]);
    $order = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($order) {
        $response = [
            'status' => 'success',
            'order' => $order
        ];
    } else {
        $response = [
            'status' => 'error',
            'message' => 'Order not found. Please check your order number.'
        ];
    }
    
} catch (Exception $e) {
    $response = [
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage()
    ];
}

echo json_encode($response);
?>