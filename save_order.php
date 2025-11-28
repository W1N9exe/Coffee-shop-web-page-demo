<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "coffee_shop_db";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    error_log("Received order data: " . print_r($input, true));
    
    if (!$input) {
        throw new Exception('No data received');
    }
    
    if (empty($input['order_number']) || empty($input['customer_phone']) || empty($input['product_details'])) {
        throw new Exception('Missing required fields: order_number, customer_phone, or product_details');
    }
    
    $stmt = $conn->prepare("INSERT INTO orders (order_number, customer_phone, product_details, created_at) VALUES (?, ?, ?, ?)");
    $stmt->execute([
        $input['order_number'],
        $input['customer_phone'],
        $input['product_details'],
        $input['created_at']
    ]);
    
    if ($stmt->rowCount() > 0) {
        $response = [
            'status' => 'success', 
            'message' => 'Order saved successfully',
            'order_id' => $conn->lastInsertId()
        ];
    } else {
        throw new Exception('No rows inserted');
    }
    
    echo json_encode($response);
    
} catch(PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    echo json_encode([
        'status' => 'error', 
        'message' => 'Database error: ' . $e->getMessage()
    ]);
} catch(Exception $e) {
    error_log("General error: " . $e->getMessage());
    echo json_encode([
        'status' => 'error', 
        'message' => $e->getMessage()
    ]);
}

$conn = null;
?>