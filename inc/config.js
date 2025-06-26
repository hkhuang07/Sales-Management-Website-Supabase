//Connect to Supabase
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const SUPABASE_URL = "https://tyltpbedtadxhpmgrgxa.supabase.co"; // URL
//Mã url: https://tyltpbedtadxhpmgrgxa.supabase.co
const SUPABASE_ANON_KEY =
  "<MY_ANON_KEY>";

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
