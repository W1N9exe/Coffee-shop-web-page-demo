<?php
header('Content-Type: application/json');

$host = 'localhost';
$dbname = 'coffee_shop_db';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit;
}

$category = $_GET['category'] ?? '';

$allowed_categories = ['classic', 'blend', 'flavor'];
if (!in_array($category, $allowed_categories)) {
    echo json_encode(['error' => 'Invalid category parameter. Use: classic, blend, or flavor']);
    exit;
}

try {
    $stmt = $pdo->prepare("SELECT id, name, description, price, image_url, category FROM products WHERE category = ?");
    $stmt->execute([$category]);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($products);
    
} catch (PDOException $e) {
    echo json_encode(['error' => 'Query failed: ' . $e->getMessage()]);
}
?>