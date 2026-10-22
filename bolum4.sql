-- Bölüm 4 gruplama ve NULL
-- Bu bölümde gruplama ve NULL konularına baktım hocam
-- Satır sayılarını seed verisine göre yazdım veritabanında kontrol etmek lazım

-- Soru 1 toplam kaç çağrı var ona baktım
SELECT COUNT(*) AS call_count
FROM llm_calls;
-- Toplam 12 çağrı var

-- Soru 2 iki saniyeden uzun süren çağrıları saydım
SELECT COUNT(*) AS slow_call_count
FROM llm_calls
WHERE latency_ms > 2000;
-- Beş çağrı 2 saniyeden uzun

-- Soru 3 toplam maliyet ve token sayısına baktım
SELECT SUM(cost_usd) AS total_cost_usd,
       SUM(prompt_tokens + completion_tokens) AS total_tokens
FROM llm_calls;
-- Maliyet 0.0631 USD token toplamı da 14340 çıkıyor
-- NULL olan maliyet toplamın içine girmiyor

-- Soru 4 ortalama gecikmeyi bir basamakla gösterdim
SELECT ROUND(AVG(latency_ms), 1) AS avg_latency_ms
FROM llm_calls;
-- Bütün kayıtların ortalaması 1848.3 ms çıktı

-- Soru 5 en hızlı ve en yavaş çağrıya baktım
SELECT MIN(latency_ms) AS fastest_ms,
       MAX(latency_ms) AS slowest_ms
FROM llm_calls;
-- En hızlısı 380 ms en yavaşı 4100 ms arada bayağı fark var

-- Soru 6 iş türlerine göre çağrıları saydım
SELECT task_type, COUNT(*) AS call_count
FROM llm_calls
GROUP BY task_type
ORDER BY task_type;
-- 5 grup çıktı her grup bir iş türü
-- chat ve summarize türlerinde üçer kayıt var

-- Soru 7 her modelin çağrı sayısı ve toplam maliyetine baktım
SELECT model_name,
       COUNT(*) AS call_count,
       SUM(cost_usd) AS total_cost_usd
FROM llm_calls
GROUP BY model_name
ORDER BY total_cost_usd DESC NULLS LAST;
-- 7 model grubu var toplam maliyeti en yüksek olan claude-sonnet

-- Soru 8 kullanıcı ve iş türüne göre çağrı sayılarını gösterdim
SELECT user_name, task_type, COUNT(*) AS call_count
FROM llm_calls
GROUP BY user_name, task_type
ORDER BY user_name NULLS FIRST, task_type;
-- 12 grup çıktı hocam
-- Anonim kullanıcının adı NULL olduğu için ayrı bir grup olmuş

-- Soru 9 ikiden fazla çağrısı olan modellere baktım
SELECT model_name, COUNT(*) AS call_count
FROM llm_calls
GROUP BY model_name
HAVING COUNT(*) > 2
ORDER BY call_count DESC;
-- Sadece gpt-4o üç çağrı almış o yüzden tek grup çıktı
-- İki çağrısı olanlar bu şartı sağlamıyor

-- Soru 10 önce 500 ms üstündeki çağrıları aldım sonra iki veya daha fazla çağrısı olan modellere baktım
SELECT model_name,
       COUNT(*) AS call_count,
       ROUND(AVG(latency_ms), 1) AS avg_latency_ms
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING COUNT(*) >= 2
ORDER BY avg_latency_ms DESC;
-- 3 grup çıktı
-- WHERE çağrıları filtreliyor HAVING de gruplara bakıyor

-- Soru 11 sütunlarda kaç tane dolu değer var baktım
SELECT COUNT(*) AS total_rows,
       COUNT(id) AS id_filled,
       COUNT(model_name) AS model_filled,
       COUNT(user_name) AS user_filled,
       COUNT(task_type) AS task_filled,
       COUNT(prompt_tokens) AS prompt_filled,
       COUNT(completion_tokens) AS completion_filled,
       COUNT(latency_ms) AS latency_filled,
       COUNT(cost_usd) AS cost_filled,
       COUNT(created_at) AS created_filled
FROM llm_calls;
-- Toplam 12 satır var kullanıcı adı ve maliyetlerde 11 dolu değer var
-- Bir çağrının kullanıcısı bir çağrının da maliyeti bilinmiyor

-- Soru 12a NULL değerini eşittir ile aramayı denedim olmadı
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd = NULL;
-- Sonuç gelmiyor çünkü NULL normal eşittirle bulunmuyor

-- Soru 12b faturası gelmeyen çağrıyı bu şekilde buldum
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NULL;
-- Bir satır çıktı id 11
-- Eksik maliyeti bulmak için IS NULL kullandım

-- Soru 13 NULL değerleri atlayınca ve sıfır sayınca ortalama nasıl değişiyor baktım
SELECT AVG(cost_usd) AS avg_known_cost,
       AVG(COALESCE(cost_usd, 0)) AS avg_cost_if_null_zero
FROM llm_calls;
-- Sonuçlar yaklaşık 0.005736 ve 0.005258 USD arada 0.000478 USD fark var
-- İlk ortalama bilinen 11 faturaya bakıyor diğeri boş faturayı sıfır sayıyor
-- Fatura gelmedi diye ücretsiz demek değil o yüzden ilk sonuç daha mantıklı bence

-- Soru 14 günlere göre çağrı sayısı ve maliyeti çıkardım
SELECT created_at::date AS call_day,
       COUNT(*) AS call_count,
       SUM(cost_usd) AS total_cost_usd
FROM llm_calls
GROUP BY created_at::date
ORDER BY call_day;
-- 6 gün çıktı en çok çağrı 16 Ekimde 5 tane
-- Maliyet düşük görünebilir çünkü 11 numaralı çağrının maliyeti NULL ve SUM bunu saymıyor

-- Soru 15 çağrıları hızlı orta ve yavaş diye ayırdım
SELECT CASE
           WHEN latency_ms < 1000 THEN 'Hızlı'
           WHEN latency_ms < 2500 THEN 'Orta'
           ELSE 'Yavaş'
       END AS latency_category,
       COUNT(*) AS call_count,
       ROUND(AVG(latency_ms), 1) AS avg_latency_ms
FROM llm_calls
GROUP BY CASE
             WHEN latency_ms < 1000 THEN 'Hızlı'
             WHEN latency_ms < 2500 THEN 'Orta'
             ELSE 'Yavaş'
         END
ORDER BY MIN(latency_ms);
-- ORDER BY içine ayrı bir CASE yazınca PostgreSQL hata verdi
-- Ben de en küçük gecikmeye göre sıraladım aynı sıra oluyor
-- 3 grup var hızlı orta ve yavaş gruplarında dörder çağrı var
-- Ortalamalar sırayla 607.5 ms 1775.0 ms ve 3162.5 ms
