// utils.js
// Chuyển các hàm thông báo và chuyển hướng từ PHP sang JavaScript

/**
 * Hiển thị thông báo lỗi (màu đỏ) và ngừng thực thi bằng cách throw error.
 * @param {string} msg - Thông báo lỗi cần hiển thị.
 */
function ErrorMessage(msg = "") {
  const container = document.getElementById("messageContainer");
  if (container) {
    container.innerHTML = `<div class="alert alert-danger">${msg}</div>`;
  }
  throw new Error(msg); // dừng toàn bộ script
}

/**
 * Hiển thị thông báo thành công (màu xanh lá).
 * @param {string} msg - Thông báo thành công cần hiển thị.
 */
function Message(msg = "") {
  const container = document.getElementById("messageContainer");
  if (container) {
    container.innerHTML = `<div class="alert alert-success">${msg}</div>`;
  }
}

/**
 * Chuyển hướng trình duyệt sau khoảng thời gian 5 giây.
 * @param {string} url - URL cần chuyển hướng đến.
 */
function Redirect(url) {
  setTimeout(() => {
    window.location.href = url;
  }, 5000); // 5000 ms = 5 giây
}

// Export nếu dùng module (ESM)
// export { ErrorMessage, Message, Redirect };
