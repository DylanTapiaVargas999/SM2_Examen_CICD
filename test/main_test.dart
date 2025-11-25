import 'package:flutter_test/flutter_test.dart';
import 'package:vanguardmoney/core/utils/form_validators.dart';
import 'package:vanguardmoney/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  group('Form Validators Tests', () {
    test('validateEmail should return null for valid email', () {
      // Arrange
      const validEmail = 'test@example.com';
      
      // Act
      final result = FormValidators.validateEmail(validEmail);
      
      // Assert
      expect(result, isNull);
    });

    test('validateEmail should return error message for invalid email', () {
      // Arrange
      const invalidEmail = 'invalid-email';
      
      // Act
      final result = FormValidators.validateEmail(invalidEmail);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'Ingresa un email válido');
    });

    test('validateEmail should return error message for empty email', () {
      // Arrange
      const emptyEmail = '';
      
      // Act
      final result = FormValidators.validateEmail(emptyEmail);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'El email es requerido');
    });

    test('validatePassword should return null for valid password', () {
      // Arrange
      const validPassword = 'ValidPass123';
      
      // Act
      final result = FormValidators.validatePassword(validPassword);
      
      // Assert
      expect(result, isNull);
    });

    test('validatePassword should return error for short password', () {
      // Arrange
      const shortPassword = '123';
      
      // Act
      final result = FormValidators.validatePassword(shortPassword);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'La contraseña debe tener al menos 8 caracteres');
    });

    test('validatePassword should return error for password without uppercase', () {
      // Arrange
      const passwordWithoutUpper = 'validpass123';
      
      // Act
      final result = FormValidators.validatePassword(passwordWithoutUpper);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'La contraseña debe tener al menos una mayúscula');
    });

    test('validatePassword should return error for password without lowercase', () {
      // Arrange
      const passwordWithoutLower = 'VALIDPASS123';
      
      // Act
      final result = FormValidators.validatePassword(passwordWithoutLower);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'La contraseña debe tener al menos una minúscula');
    });

    test('validatePassword should return error for password without numbers', () {
      // Arrange
      const passwordWithoutNumbers = 'ValidPassword';
      
      // Act
      final result = FormValidators.validatePassword(passwordWithoutNumbers);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'La contraseña debe tener al menos un número');
    });

    test('validateConfirmPassword should return null when passwords match', () {
      // Arrange
      const password = 'ValidPass123';
      const confirmPassword = 'ValidPass123';
      
      // Act
      final result = FormValidators.validateConfirmPassword(confirmPassword, password);
      
      // Assert
      expect(result, isNull);
    });

    test('validateConfirmPassword should return error when passwords do not match', () {
      // Arrange
      const password = 'ValidPass123';
      const confirmPassword = 'DifferentPass123';
      
      // Act
      final result = FormValidators.validateConfirmPassword(confirmPassword, password);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'Las contraseñas no coinciden');
    });

    test('validateUsername should return null for valid username', () {
      // Arrange
      const validUsername = 'usuario123';
      
      // Act
      final result = FormValidators.validateUsername(validUsername);
      
      // Assert
      expect(result, isNull);
    });

    test('validateUsername should return error for short username', () {
      // Arrange
      const shortUsername = 'ab';
      
      // Act
      final result = FormValidators.validateUsername(shortUsername);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'El nombre debe tener al menos 3 caracteres');
    });

    test('validateUsername should return error for empty username', () {
      // Arrange
      const emptyUsername = '';
      
      // Act
      final result = FormValidators.validateUsername(emptyUsername);
      
      // Assert
      expect(result, isNotNull);
      expect(result, 'El nombre es requerido');
    });
  });

  group('UserModel Tests', () {
    test('UserModel.empty() should create user with empty values', () {
      // Act
      final user = UserModel.empty();
      
      // Assert
      expect(user.id, '');
      expect(user.email, '');
      expect(user.isEmailVerified, false);
      expect(user.displayName, isNull);
      expect(user.photoUrl, isNull);
      expect(user.createdAt, isNull);
    });

    test('UserModel copyWith should create new instance with updated values', () {
      // Arrange
      final originalUser = UserModel.empty();
      const newEmail = 'newemail@test.com';
      const newDisplayName = 'New Name';
      
      // Act
      final updatedUser = originalUser.copyWith(
        email: newEmail,
        displayName: newDisplayName,
        isEmailVerified: true,
      );
      
      // Assert
      expect(updatedUser.email, newEmail);
      expect(updatedUser.displayName, newDisplayName);
      expect(updatedUser.isEmailVerified, true);
      expect(updatedUser.id, originalUser.id); // Should remain unchanged
    });

    test('UserModel copyWith should keep original values when no new values provided', () {
      // Arrange
      final originalUser = const UserModel(
        id: 'test-id',
        email: 'test@example.com',
        displayName: 'Test User',
        isEmailVerified: true,
      );
      
      // Act
      final copiedUser = originalUser.copyWith();
      
      // Assert
      expect(copiedUser.id, originalUser.id);
      expect(copiedUser.email, originalUser.email);
      expect(copiedUser.displayName, originalUser.displayName);
      expect(copiedUser.isEmailVerified, originalUser.isEmailVerified);
      expect(copiedUser.photoUrl, originalUser.photoUrl);
      expect(copiedUser.createdAt, originalUser.createdAt);
    });

    test('UserModel should handle null values correctly', () {
      // Arrange & Act
      const user = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        displayName: null,
        photoUrl: null,
        isEmailVerified: false,
        createdAt: null,
      );
      
      // Assert
      expect(user.id, 'test-id');
      expect(user.email, 'test@example.com');
      expect(user.displayName, isNull);
      expect(user.photoUrl, isNull);
      expect(user.isEmailVerified, false);
      expect(user.createdAt, isNull);
    });

    test('UserModel should store DateTime correctly', () {
      // Arrange
      final testDate = DateTime(2023, 1, 1, 12, 0, 0);
      
      // Act
      final user = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        isEmailVerified: true,
        createdAt: testDate,
      );
      
      // Assert
      expect(user.createdAt, testDate);
      expect(user.createdAt?.year, 2023);
      expect(user.createdAt?.month, 1);
      expect(user.createdAt?.day, 1);
    });
  });

  group('Integration Tests', () {
    test('Complete user registration validation flow', () {
      // Arrange
      const email = 'newuser@example.com';
      const username = 'newuser123';
      const password = 'SecurePass123';
      const confirmPassword = 'SecurePass123';
      
      // Act & Assert - All validations should pass
      expect(FormValidators.validateEmail(email), isNull);
      expect(FormValidators.validateUsername(username), isNull);
      expect(FormValidators.validatePassword(password), isNull);
      expect(FormValidators.validateConfirmPassword(confirmPassword, password), isNull);
    });

    test('Failed user registration validation flow', () {
      // Arrange
      const invalidEmail = 'invalid-email';
      const shortUsername = 'ab';
      const weakPassword = '123';
      const mismatchedConfirm = 'different';
      
      // Act & Assert - All validations should fail
      expect(FormValidators.validateEmail(invalidEmail), isNotNull);
      expect(FormValidators.validateUsername(shortUsername), isNotNull);
      expect(FormValidators.validatePassword(weakPassword), isNotNull);
      expect(FormValidators.validateConfirmPassword(mismatchedConfirm, weakPassword), isNotNull);
    });

    test('UserModel creation and validation integration', () {
      // Arrange
      const email = 'test@example.com';
      const username = 'testuser';
      
      // Act - First validate, then create user
      final emailValidation = FormValidators.validateEmail(email);
      final usernameValidation = FormValidators.validateUsername(username);
      
      // Assert validations pass
      expect(emailValidation, isNull);
      expect(usernameValidation, isNull);
      
      // Create user model
      final user = UserModel(
        id: 'test-id',
        email: email,
        displayName: username,
        isEmailVerified: false,
      );
      
      // Assert user creation
      expect(user.email, email);
      expect(user.displayName, username);
      expect(user.isEmailVerified, false);
    });
  });
}
