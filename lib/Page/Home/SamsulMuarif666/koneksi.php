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

// Tangkap data dari form
$name = $_POST['name'];
$price = $_POST['price'];
$store = $_POST['store'];
$sold = $_POST['sold'];
$description = $_POST['description'];

// Tangkap file gambar
$image = $_FILES['image'];
$imageName = $image['name'];
$imageTmpName = $image['tmp_name'];

// Simpan gambar ke direktori server
$uploadsDir = 'uploads/';
$targetPath = $uploadsDir . basename($imageName);

// Pindahkan file yang diunggah ke direktori target
if (!move_uploaded_file($imageTmpName, $targetPath)) {
    die("Gagal mengunggah file.");
}

// Query untuk menyimpan produk ke database
$sql = "INSERT INTO `katalog` (imageUrl, name, price, store, sold, description) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssdsss", $imageUrl, $name, $price, $store, $sold, $description);

// Set nilai parameter dan eksekusi statement
$imageUrl = $targetPath; // Gunakan path gambar yang sudah diunggah
if ($stmt->execute()) {
    echo "Produk berhasil diunggah.";
} else {
    echo "Gagal menyimpan produk: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
