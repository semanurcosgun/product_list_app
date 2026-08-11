class Validators

 {
  static String? validateUsername(String? value) {
    final String username = value?.trim() ?? '';

    if (username.isEmpty) {
      return 'Kullanici adi boş birakilamaz';
    }

    if (username.length < 3) {
      return 'Kullanici adi en az 3 karakter olmalidir';
    }

    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!usernameRegex.hasMatch(username)) {
      return 'Kullanici adi yalnizca harf, rakam ve _ içerebilir';
    }

    return null;
  }
  static String? validatePassword(String? value) {
    final String password = value ?? '';

    if (password.isEmpty) {
      return 'Şifre boş birakilamaz';
    }

    if (password.length < 6) {
      return 'Şifre en az 6 karakter olmalidir';
    }

    return null;
  }

   static String? validateEmail(String? value) {
    final String email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email boş birakilamaz';
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Geçerli bir email adresi giriniz';
    }

    return null;
  }
  static String? validateFullName(String? value) {
    final String fullName = value?.trim() ?? '';

    if (fullName.isEmpty) {
      return 'Ad soyad boş birakilamaz';
    }

    if (fullName.length < 3) {
      return 'Ad soyad en az 3 karakter olmalidir';
    }

    final RegExp fullNameRegex = RegExp(
      r"^[a-zA-ZçÇğĞiİöÖşŞüÜ\s]+$",
    );

    if (!fullNameRegex.hasMatch(fullName)) {
      return 'Ad soyad yalnizca harf içermelidir';
    }

    return null;
  }
   static String? validatePhone(String? value) {
    final String phone = value?.trim() ?? '';

    if (phone.isEmpty) {
      return 'Telefon numarasi boş birakilamaz';
    }

    if (phone.length < 10) {
      return 'Telefon numarasi en az 10 rakam olmalidir';
    }

    final RegExp phoneRegex = RegExp(r'^[0-9]+$');

    if (!phoneRegex.hasMatch(phone)) {
      return 'Telefon numarasi yalnizca rakamlardan oluşmalidir';
    }

    return null;
  }
 static String? validateBirthDate(String? value) {
    final String birthDate = value?.trim() ?? '';

    if (birthDate.isEmpty) {
      return 'Doğum tarihi seçilmelidir';
    }

    return null;
  }
 
  static String? validateAgainPassword(
  String? value,
  String password,
) {
  final againPassword = value?.trim();

  if (againPassword == null || againPassword.isEmpty) {
    return 'Şifre tekrari boş birakilamaz';
  }

  if (againPassword != password) {
    return 'Şifreler ayni olmalidir';
  }

  return null;
}
}
