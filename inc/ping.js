import { supabase } from "./config.js";

async function pingDatabase() {
  try {
    const { error } = await supabase.rpc("ping");
    if (error) {
      console.error("Ping error:", error.message);
    } else {
      console.log("Ping successfully!");
    }
  } catch (err) {
    console.error("Connect Error:", err);
  }
}
// Gọi ping mỗi 7 ngày
setInterval(pingDatabase, 604800000);
// Ping ngay khi vào trang
pingDatabase();

//Hàm thông báo popup cho người dùng nếu mất kết nối
function showErrorPopup(message) {
  // Cập nhật nội dung lỗi
  document.getElementById("errorModalBody").innerText = message;
  // Hiện modal
  const errorModal = new bootstrap.Modal(document.getElementById("errorModal"));
  errorModal.show();
}

//Hàm ghi log ra server mỗi lần ping lỗi
function sendErrorLog(errorMessage) {
  $.post("inc/log-error.php", {
    error: errorMessage,
    timestamp: new Date().toISOString(),
  });
}
