# Bölüm 2 veritabanı konuları

## 1 Excel yerine veritabanı kullanmak

Bence excel dosyaları çoğaldıkça aynı bilgiyi birkaç yere yazmak gerekiyor hocam. Bu da bir yerde yapılan değişikliğin diğer dosyalarda unutulmasına ve bilgilerin tutmamasına yol açabiliyor. Veritabanında bilgiler tek yerde durduğu için gerektiğinde sorgulayarak bulabiliyoruz aynı dosyayı birkaç kişi düzenleyince de değişiklikler karışabiliyor. DBMS bu işlemleri ve aynı anda erişimi yönetmeye yardımcı oluyor. Dosyalar büyüyünce arama ve rapor hazırlamak zorlaşıyor ama veritabanında kayıtları sorgularla daha kolay bulabiliyoruz.

## 2 Birincil anahtar ne işe yarıyor

Birincil anahtar, kayıtları birbirinden ayırmamızı sağlıyor. Aynı anahtar değeri iki farklı kayıtta kullanılamıyor. Öğrenci numarası bu iş için uygun hocam çünkü her öğrenciye farklı bir numara veriliyor. Ad soyad ise pek uygun değil, aynı isimde başka kişiler olabilir hatta kişinin adı değişebilir.

## 3 DBMS ile veritabanı arasındaki fark

Veritabanı düzenlenmiş bilgilerin kendisi oluyor. DBMS ise bu bilgileri oluşturmak, sorgulamak ve korumak için kullandığımız yazılım. Yani kısaca hocam veritabanı bilgiler, DBMS de bu bilgileri yönetmemizi sağlayan sistem diyebiliriz. PostgreSQL de bir DBMS örneği.

## 4 İki kişi aynı kaydı değiştirirse ne olur

İki kişi aynı kaydı aynı anda değiştirirse birinin yaptığı değişiklik diğerinin üstüne yazılabilir. DBMS eşzamanlı işlemleri ve kilitleme kurallarını kullanarak bunun önüne geçmeye çalışıyor hocam.
