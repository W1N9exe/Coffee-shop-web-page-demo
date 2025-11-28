<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

error_reporting(E_ALL);
ini_set('display_errors', 1);

$input = json_decode(file_get_contents('php://input'), true);
$action = $input['action'] ?? $_POST['action'] ?? '';

if (!isset($_SESSION['cart'])) {
    $_SESSION['cart'] = [];
}

if ($action === 'update') {
    $items = $input['items'] ?? [];
    
    $updated = false;
    foreach ($items as $updateItem) {
        $productId = $updateItem['id'];
        $newQuantity = intval($updateItem['quantity']);
        
        foreach ($_SESSION['cart'] as &$item) {
            if ($item['id'] === $productId) {
                $item['qty'] = $newQuantity;
                $updated = true;
                break;
            }
        }
    }
    
    if ($updated) {
        echo json_encode([
            'status' => 'success', 
            'message' => 'Cart updated successfully',
            'cart_count' => count($_SESSION['cart'])
        ]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No items updated']);
    }
    
} elseif ($action === 'remove') {
    $productId = $_POST['product_id'] ?? '';
    
    if (!empty($productId)) {
        $initialCount = count($_SESSION['cart']);
        $_SESSION['cart'] = array_filter($_SESSION['cart'], function($item) use ($productId) {
            return $item['id'] !== $productId;
        });
        
        $_SESSION['cart'] = array_values($_SESSION['cart']);
        
        if (count($_SESSION['cart']) < $initialCount) {
            echo json_encode([
                'status' => 'success', 
                'message' => 'Item removed successfully',
                'cart_count' => count($_SESSION['cart'])
            ]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Item not found in cart']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No product ID provided']);
    }
    
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid action']);
}
?>