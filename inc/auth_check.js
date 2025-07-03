import { supabase } from './config.js';

export async function checkAdminOrManagerRole() {
  const {
    data: { user },
    error
  } = await supabase.auth.getUser();

  if (error || !user) {
    // Chưa đăng nhập => chuyển đến trang đăng nhập
    window.location.href = "signin.html";
    return false;
  }

  // Lấy thông tin người dùng từ bảng tbl_users
  const { data: userInfo, error: userError } = await supabase
    .from('tbl_users')
    .select('role, is_blocked')
    .eq('id', user.id)
    .single();

  if (userError || !userInfo) {
    // Không tìm thấy user => lỗi 404
    window.location.href = "error_404.html";
    return false;
  }

  if (userInfo.is_blocked) {
    // Bị khóa => không cho truy cập
    window.location.href = "error_403.html";
    return false;
  }

  if (userInfo.role !== 'admin' && userInfo.role !== 'manager') {
    // Không đủ quyền => lỗi 403
    window.location.href = "error_403.html";
    return false;
  }

  // Tất cả điều kiện hợp lệ
  return true;
}
