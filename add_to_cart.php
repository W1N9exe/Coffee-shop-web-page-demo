<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

error_reporting(E_ALL);
ini_set('display_errors', 1);

// db搵資料
$product_id = $_POST['product_id'] ?? '';
$product_name = $_POST['product_name'] ?? '';
$product_price = $_POST['product_price'] ?? '';

// 驗證
if (empty($product_id) || empty($product_name) || empty($product_price)) {
    echo json_encode([
        'status' => 'error', 
        'message' => 'Error: Missing product information'
    ]);
    exit;
}

// 初始化
if (!isset($_SESSION['cart'])) {
    $_SESSION['cart'] = [];
}

// 檢查商品購物車有無
$item_found = false;
foreach ($_SESSION['cart'] as &$item) {
    if ($item['id'] == $product_id) {
        // 有= +1
        $item['qty'] += 1;
        $item_found = true;
        break;
    }
}

// 無就加入去
if (!$item_found) {
    $new_item = [
        'id' => $product_id,
        'name' => $product_name,
        'price' => $product_price,
        'qty' => 1  
    ];
    $_SESSION['cart'][] = $new_item;
}

// add success
echo json_encode([
    'status' => 'success', 
    'message' => 'Product added to cart',
    'cart_count' => count($_SESSION['cart'])
]);
?>