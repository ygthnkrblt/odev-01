# Yapay zeka kullanımı

Bu ödevde Gemini'den anlamadığım yerleri sormak için yardım aldım. SELECT ve WHERE komutlarını, NULL değerini ve sorguları nasıl çalıştıracağımı sordum. Sonra örneklere bakıp kendim de anlamaya çalıştım.

- `SELECT id, model_name FROM llm_calls;` yazınca tablodaki çağrıların id ve model adları geliyor.
- `WHERE` ile sadece bakmak istediğim kayıtları seçebiliyorum. Mesela gecikmesi uzun olanları bulmak için `WHERE latency_ms > 2000` yazdım.
- Boş maliyetleri ararken `WHERE cost_usd IS NULL` kullanmam gerektiğini öğrendim. `= NULL` yazınca aynı şekilde çalışmıyor çünkü NULL sıfır demek değil.
- Sorguların ne yaptığını anlamak için örneklere baktım. PostgreSQL'de çalıştırıp sonuçları kontrol etmem gerektiğini de öğrendim.