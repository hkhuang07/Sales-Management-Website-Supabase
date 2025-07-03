//Connect to Supabase
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const SUPABASE_URL = "YOUR-SUPABASE-PROJECT-URL"; // URL
//Mã url: https://tyltpbedtadxhpmgrgxa.supabase.co
const SUPABASE_ANON_KEY = "YOUR-SUPABASE-ANON-KEY";

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
