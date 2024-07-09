<?php
// Koneksi ke database
$servername = "localhost";
$username = "u1574155_samsul"; // Ganti dengan username database Anda
$password = "samsul2024"; // Ganti dengan password database Anda
$dbname = "u1574155_samsul"; // Ganti dengan nama database Anda

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Periksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Query untuk mengambil data produk
$sql = "SELECT imageUrl, name, price, store, sold FROM katalog";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Jika ada data, simpan dalam array
    $products = array();
    while($row = $result->fetch_assoc()) {
        $products[] = $row;
    }

    // Encode array dalam format JSON dan kirimkan
    echo json_encode($products);
} else {
    echo "0 results";
}
$conn->close();
?>
