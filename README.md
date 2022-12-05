# final-project

Vakıfbank IOS Swift Bootcamp Bitirme Projesi

Genel Detaylar:
3 ana ekrandan oluşan public API tabanlı bir uygulaması yapılması beklenmektedir.(API
sonradan kararlaştırılacaktır.)
Aşağıda yazılmış olan tüm maddeler ideal uygulamayı tarif etmekle beraber; herkes
başardığı özelliklere göre değerlendirilecektir.
Yapılmış maddelerin başarılı uygulanmış olması tüm maddeleri tamamlamaktan daha
önemlidir.
Git Kullanımı:
- Uygulama github.com sayfasına public repo olarak yüklenmelidir.
- Git commitleri atomic olmalı ve genel commit mesajları kurallarına dikkat
edilmelidir. - Commit mesajları atılırken branch yapısına dikkat edilmelidir.
(Develop, Feature vb. branch’ler oluşturulmalıdır.)
1. Ekran: (Liste Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Item’lar arasında arama yapılabilmelidir.
- Item’ları sıralama butonu ile sıralanabilmelidir.
- Sadece item’lar güncellendiğinde görünüm güncellenmelidir. (Ekrana her
girişte güncelleme olmamalı)
2. Ekran: (Detay Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Item’a basıldığında ilgili detaya yönlenmelidir.(Alanlar belirtilecektir.)
- Edit işlemleri için aynı ekran kullanılacaktır.
- Düzenlemede tüm alanlar eklenmemişse item kaydedilmemelidir.
3. Ekran: (Yeni Giriş Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Ekran present şekilde açılmalıdır.
- Ekleme tüm alanlar eklenmemişse item kaydedilmemelidir.
Uygulama gereklilikleri:
- SPM veya Cocoapods kullanılmalıdır.
- Uygulamada hata mesajları ve bekleme esnasında activity indicator

kullanılmalıdır.. - İşlemler CoreData ile yapılmalıdır.
- CoreData’ya bir CoreDataManager üzerinden erişilmelidir.
- Local push entegrasyonu sağlanmalıdır.
- Notification yönetimi bir localNotificationManager aracılığıyla
yapılmalıdır. - Localization sağlanmalıdır.
- ViewModel localNotificationManager’a notificationManager protokolü üzerinden
erişmelidir.
- Uygulamanın unit test yaklaşımı ve coverage yüzdesi değerlendirme kriterleri
arasındadır.
- UI ve animasyon tamamen tercihe bağlı olup farklı cihaz görünümleri
gözetilmelidir.

1- API - https://rawg.io/apidocs - Dokümantasyon Chrome ile açılmalıdır.
2- Git reposu public gözüküyor ancak ödevler nasıl yükleniyorsa aynı sistem kullanılacaktır.
3- ReadMe dosyası repoda olmalıdır.
4- Liste ekranı için istenilen filtre kullanılabilir(2022 de çıkan oyunlar, platforma özel
oyunlar veya popüler oyunlar olabilir.)
5- Detay ekranında Fotoğraf ve en az 4 bilgi olacak.
6- Listeden detaya gidildiğinde favorilere ekleme olacak başka bir editleme olmayacak.(2.
Ekrandaki editleme maddesi)
7- Favorilerin listelendiği bir ekran olacak.
8- Liste şeklinde Notlar ekranı olacak. Oyunlara ait not ekleyebileceğim ve mevcut notları
düzenleyebileceğim.(Dokümandaki 3. Ekran Yeni giriş ekranı bu kısımda olacak)
9- Hatalar yakalanmalı ve alert şeklinde gösterilmelidir.
