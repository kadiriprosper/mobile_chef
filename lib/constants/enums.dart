enum DashboardSectionCategoryEnum {
  beef,
  vegetarian,
  seafood,
}

enum LoginTypeEnum {
  google,
  email,
}

LoginTypeEnum? stringToLoginType(String? loginType) =>
loginType == null ? null :
    loginType == 'LoginTypeEnum.google'
        ? LoginTypeEnum.google
        : LoginTypeEnum.email;
