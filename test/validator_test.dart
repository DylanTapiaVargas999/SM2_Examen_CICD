import 'package:flutter_test/flutter_test.dart';
import '../lib/core/utils/form_validators.dart';

void main() {
  group('FormValidators Tests', () {
    // Prueba 1: Validación de email válido
    test('validateEmail should return null for valid email', () {
      // Arrange
      const validEmail = 'usuario@ejemplo.com';

      // Act
      final result = FormValidators.validateEmail(validEmail);

      // Assert
      expect(result, isNull);
    });

    // Prueba 2: Validación de email inválido sin @
    test('validateEmail should return error for email without @', () {
      // Arrange
      const invalidEmail = 'usuarioejemplo.com';

      // Act
      final result = FormValidators.validateEmail(invalidEmail);

      // Assert
      expect(result, equals('Ingresa un email válido'));
    });

    // Prueba 3: Validación de email inválido sin dominio
    test('validateEmail should return error for email without domain', () {
      // Arrange
      const invalidEmail = 'usuario@';

      // Act
      final result = FormValidators.validateEmail(invalidEmail);

      // Assert
      expect(result, equals('Ingresa un email válido'));
    });

    // Prueba 4: Validación de contraseña válida
    test('validatePassword should return null for valid password', () {
      // Arrange
      const validPassword = 'MiContraseña123';

      // Act
      final result = FormValidators.validatePassword(validPassword);

      // Assert
      expect(result, isNull);
    });

    // Prueba 5: Validación de contraseña muy corta
    test('validatePassword should return error for password too short', () {
      // Arrange
      const shortPassword = '123';

      // Act
      final result = FormValidators.validatePassword(shortPassword);

      // Assert
      expect(result, equals('La contraseña debe tener al menos 8 caracteres'));
    });

    // Prueba 6: Validación de nombre de usuario válido
    test('validateUsername should return null for valid username', () {
      // Arrange
      const validUsername = 'Juan_Perez123';

      // Act
      final result = FormValidators.validateUsername(validUsername);

      // Assert
      expect(result, isNull);
    });

    // Prueba 7: Validación de nombre de usuario muy corto
    test('validateUsername should return error for username too short', () {
      // Arrange
      const shortUsername = 'ab';

      // Act
      final result = FormValidators.validateUsername(shortUsername);

      // Assert
      expect(result, equals('El nombre debe tener al menos 3 caracteres'));
    });
  });

  group('PasswordStrength Tests', () {
    // Prueba adicional: Cálculo de fuerza de contraseña
    test('calculate should return correct strength for different passwords', () {
      // Arrange & Act & Assert
      expect(PasswordStrength.calculate(''), equals(0));
      expect(PasswordStrength.calculate('weak'), greaterThanOrEqualTo(1));
      expect(PasswordStrength.calculate('StrongPass123!'), greaterThan(2));
    });
  });
}