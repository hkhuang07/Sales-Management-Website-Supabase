//Connect to Supabase
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const SUPABASE_URL = "https://tyltpbedtadxhpmgrgxa.supabase.co"; // URL
//Mã url: https://tyltpbedtadxhpmgrgxa.supabase.co
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR5bHRwYmVkdGFkeGhwbWdyZ3hhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzNzE5NzEsImV4cCI6MjA1OTk0Nzk3MX0.xP7vg1yn4GLReCpO7mYU6qnnq2rw4aekIAkJKcaj0xk";

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
