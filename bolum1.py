# Bölüm 1 algoritma ve izleme

# Soru 1.1
# Döngüde i total ve result nasıl değişiyor diye baktım
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

print("Soru 1.1 - izleme")
print("i | numbers[i] | total | result")
for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])
    print(i, "|", numbers[i], "|", total, "|", result)

print("Çift sayıların toplamı:", total)
print("Tek sayılar:", result)
# Sonuçta total 14 result da [7, 9, 5, 1] oluyor


# Soru 1.2
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22

# Sözde kod:
# En uzun ve şu anki seriyi başta 0 yaptım
# Sayılara sırayla baktım
# Eşikten büyükse seriyi uzattım değilse baştan başladım
# Şu anki seri daha uzunsa en uzun olanı güncelledim
# Döngü bitince en uzun seriyi yazdırdım

en_uzun = 0
mevcut = 0
for reading in readings:
    if reading > threshold:
        mevcut = mevcut + 1
        if mevcut > en_uzun:
            en_uzun = mevcut
    else:
        mevcut = 0

print("Soru 1.2 - en uzun seri:", en_uzun)
# En uzun seri 5 tane çıkıyor


# Soru 1.3
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

course_counts = {}
for record in records:
    course = record["course"]
    if course in course_counts:
        course_counts[course] = course_counts[course] + 1
    else:
        course_counts[course] = 1

print("Soru 1.3 - ders sayıları:", course_counts)
# Sonuç VTYS 3 Yapay Zeka 2 Robotik 1 oluyor
