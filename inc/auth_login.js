import { supabase } from './config.js';

export async function checkLoggedIn() {
  const {
    data: { user },
    error
  } = await supabase.auth.getUser();

  if (error || !user) {
    // Chưa đăng nhập => quay về trang đăng nhập
    window.location.href = "signin.html";
    return false;
  }

  // Lấy thông tin người dùng từ bảng tbl_users
  const { data: userInfo, error: userError } = await supabase
    .from('tbl_users')
    .select('is_blocked')
    .eq('id', user.id)
    .single();

  if (userError || !userInfo) {
    // Không lấy được thông tin => chuyển hướng lỗi 404
    window.location.href = "error_404.html";
    return false;
  }

  if (userInfo.is_blocked) {
    // Tài khoản bị khóa => chuyển hướng lỗi 403
    window.location.href = "error_403.html";
    return false;
  }

  return true;
}
