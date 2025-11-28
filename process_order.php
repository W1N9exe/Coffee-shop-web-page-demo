<?php
session_start();
header('Content-Type: application/json');

error_reporting(E_ALL);
ini_set('display_errors', 1);
//gen訂單編號
function generateOrderNumber() {
    $prefix = 'BN'; 
    $date = date('Ymd'); 
    $random = strtoupper(bin2hex(random_bytes(4))); 
    return $prefix . $date . $random; 
}

$order_number = generateOrderNumber();

$customer_phone = $_POST['customer_phone'] ?? '';

if (empty($customer_phone)) {
    echo json_encode(['status' => 'error', 'message' => 'Please enter phone number']);
    exit;
}

$customer_phone = preg_replace('/[^0-9]/', '', $customer_phone);

if (empty($_SESSION['cart'])) {
    echo json_encode(['status' => 'error', 'message' => 'Shopping cart is empty']);
    exit;
}

$product_details = json_encode($_SESSION['cart']);

$host = 'localhost';
$dbname = 'coffee_shop_db';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $stmt = $pdo->prepare("INSERT INTO orders (order_number, customer_phone, product_details) VALUES (?, ?, ?)");
    $stmt->execute([$order_number, $customer_phone, $product_details]);
    
    $_SESSION['cart'] = array();
    
    echo json_encode([
        'status' => 'success', 
        'message' => 'Order placed successfully',
        'order_number' => $order_number,
        'confirmation_phone' => $customer_phone,
        'order_date' => date('Y-m-d H:i:s')
    ]);
    
} catch (PDOException $e) {
    if (strpos($e->getMessage(), 'Duplicate entry') !== false) {
        $order_number = generateOrderNumber();
        echo json_encode(['status' => 'error', 'message' => 'Please try again. System busy.']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Order failed: ' . $e->getMessage()]);
    }
}
?>