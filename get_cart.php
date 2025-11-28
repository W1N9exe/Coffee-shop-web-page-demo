<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);


session_start();
header('Content-Type: application/json');

error_reporting(E_ALL);
ini_set('display_errors', 1);

if (!isset($_SESSION['cart']) || empty($_SESSION['cart'])) {
    echo json_encode([
        'status' => 'success',
        'cart_items' => [],
        'total_count' => 0,
        'total_price' => '0.00'
    ]);
    exit;
}

$total_count = 0;
$total_price = 0;

foreach ($_SESSION['cart'] as $item) {
    $total_count += $item['qty'];
    $total_price += $item['price'] * $item['qty'];
}

echo json_encode([
    'status' => 'success',
    'cart_items' => $_SESSION['cart'],
    'total_count' => $total_count,
    'total_price' => number_format($total_price, 2)
]);
?>