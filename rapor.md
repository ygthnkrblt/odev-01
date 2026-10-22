# Ödev 1 raporu

**Ad Soyad:** Yiğit Han Karabulut  
**Öğrenci No:** 202607131007  
**Program:** Yapay Zeka Operatörlüğü  
**Veritabanı:** `llm_ops`  
**Tarih:** 23.10.2026

## 1 Neler yaptım

İlk bölümde döngünün içinde neler değişiyor diye adım adım baktım. Eşik değerini geçen sayıların en uzun serisini buldum, dersleri de sözlük kullanarak saydım. İkinci bölümde veritabanı ve DBMS ne demek onu kendi anladığım şekilde yazdım. Sonraki bölümlerde `SELECT`, `WHERE`, sıralama ve `LIMIT` kullandım. En son da gruplama ve `NULL` değerleriyle ilgili sorgulara baktım. Bazı kısımları başta karıştırdım ama örneklerden gidince daha anlaşılır oldu hocam.

## 2 Sonuçlar ve zorlandığım yer

**En zorlandığım soru:** Soru 15 ve `NULL` ile ilgili olan sorular  
**Neden ve nasıl çözdüm:** Soru 15'te hızlı orta ve yavaş diye ayırırken `CASE` kısmını anlamam biraz zaman aldı. Bir de `NULL` normal boş bir değer gibi davranmıyormuş. `IS NULL` ile nasıl bulduğuma ve `SUM` ile `AVG` sonuçlarının niye değiştiğine bakınca daha iyi anladım. Hala biraz karışık geliyor ama en azından mantığını kavradım sanırım.

## 3 Beklemediğim bir sonuç

11 numaralı çağrının `cost_usd` alanı boş yani `NULL`. Ben başta bunun toplamda sıfır gibi sayılacağını düşündüm ama `SUM` bunu toplamıyor. O yüzden özellikle 16 Ekim'in toplam maliyeti daha düşük görünebiliyor. Burada `NULL` ile sıfırın aynı şey olmadığını fark ettim.

## 4 Aldığım hata ve nasıl çözdüm

`ORDER BY` kısmında ayrı bir `CASE` yazınca PostgreSQL hata verdi. Hata mesajında `latency_ms` değerinin `GROUP BY` içinde olması ya da bir toplama fonksiyonunda kullanılması gerektiği yazıyordu.  
Biraz uğraştıktan sonra sıralamayı `MIN(latency_ms)` ile yaptım ve hata düzeldi. Bu kısım ilk başta bana karışık geldi ama nedenini görünce daha mantıklı oldu.

## 5 Yapay zeka kullandım mı

Bu ödevde ChatGPT'den yardım aldım. Bazı soruları açıklamasını ve SQL sorgularını anlamama yardım etmesini istedim. Verilen cevapları olduğu gibi almak yerine ödevdeki tablo ve sütunlara göre kontrol ettim. Yine de sorguların kendi veritabanımda çalışıp çalışmadığını teslim etmeden önce son kez kontrol etmem gerekiyor.

## 6 Kendimi değerlendirmem ve sorum

**Bir dahaki ödevde geliştireceğim şey:** Son güne bırakmadan sorguları çalıştırıp ne sonuç verdiklerine bakmak  
**Derste tekrar görmek istediğim konu:** `NULL` değerlerinin `COUNT`, `SUM` ve `AVG` sonuçlarını nasıl etkilediği hocam
