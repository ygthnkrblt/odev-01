-- Bölüm 3 select ve where
-- Sorguları bu şekilde yazdım hocam
-- Satır sayılarını seed dosyasındaki verilere göre ekledim
-- Kendi veritabanında çalıştırıp bakmak lazım

-- Soru 1 bütün çağrıların id ve model adlarına baktım
SELECT id, model_name
FROM llm_calls;
-- 12 satır geliyor

-- Soru 2 model adını model diye yazdırıp tokenları topladım
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
-- Burada da 12 satır var

-- Soru 3 iki saniyeden uzun süren çağrılara baktım
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır çıkıyor

-- Soru 4 Ece'nin yaptığı çağrıları seçtim
SELECT id, model_name, user_name
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır geliyor

-- Soru 5 chat olmayan çağrılara baktım
SELECT id, model_name, task_type
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır çıkıyor

-- Soru 6 Claude modellerinde 1 saniyeyi geçenleri buldum
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name ILIKE 'claude%'
  AND latency_ms > 1000;
-- 2 satır çıktı

-- Soru 7 kod veya çeviri işi olup maliyeti 0.01 dolardan fazla olanlar
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate')
  AND cost_usd > 0.01;
-- 3 satır geliyor

-- Soru 7 parantez koymadan da denedim
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE task_type = 'code' OR task_type = 'translate' AND cost_usd > 0.01;
-- Bu sefer de 3 satır çıktı hocam
-- PostgreSQL önce AND kısmına baktığı için sonuç aynı oldu
-- code olan iki kaydın da maliyeti 0.01 dolardan fazla

-- Soru 8 gecikmesi 500 ile 1500 ms arasında olanlara baktım
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- Sınırlar da dahil 3 satır çıkıyor

-- Soru 9 GPT-4o modellerini seçtim
SELECT id, model_name
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır geliyor

-- Soru 10 adında mini geçen modelleri aradım büyük küçük harf fark etmiyor
SELECT id, model_name
FROM llm_calls
WHERE model_name ILIKE '%mini%';
-- 3 satır çıktı id 6 9 ve 10
-- Ben bir tane çıkar sanmıştım ama gemini adında da mini geçiyor

-- Soru 10b bu sefer sadece gpt-4o-mini aradım
SELECT id, model_name
FROM llm_calls
WHERE model_name ILIKE '%-mini%';
-- 1 satır çıktı id 9
-- Tireyi ekleyince gemini modelleri gelmedi

-- Soru 11 önce kullanıcıya sonra maliyeti yüksekten düşüğe sıraladım
SELECT id, user_name, cost_usd
FROM llm_calls
ORDER BY user_name ASC NULLS FIRST, cost_usd DESC NULLS FIRST;
-- 12 satır geldi
-- NULL olan kullanıcı ve maliyetler de sonuçta var

-- Soru 12 en pahalı üç çağrıyı buldum NULL maliyetleri sona attım
SELECT id, model_name, cost_usd
FROM llm_calls
ORDER BY cost_usd DESC NULLS LAST
LIMIT 3;
-- 3 satır çıktı id 7 2 ve 4

-- Soru 13 iş türlerini tekrarsız gösterdim
SELECT DISTINCT task_type
FROM llm_calls
ORDER BY task_type;
-- 5 farklı iş türü var

-- Soru 14a tekrarsız kullanıcıları sıraladım
SELECT DISTINCT user_name
FROM llm_calls
WHERE user_name IS NOT NULL
ORDER BY user_name;
-- NULL olanları almadım 5 satır geldi

-- Soru 14b kullanıcıları Türkçe sıralamayı da denedim hocam
SELECT DISTINCT user_name COLLATE "tr-TR-x-icu" AS user_name
FROM llm_calls
WHERE user_name IS NOT NULL
ORDER BY user_name;
-- Yine 5 satır çıktı
-- Oğuz isminde ğ var ama bu veride sıralama değişmedi
-- Sıralama Deniz Ece Mert Oğuz ve Selin oldu

-- Soru 15 14 Ekimden sonra 1 saniyeyi geçen çağrılara baktım
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at >= TIMESTAMPTZ '2026-10-15 00:00:00+03'
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- Gecikmesi uzun olandan kısaya sıraladım 5 satır çıktı
