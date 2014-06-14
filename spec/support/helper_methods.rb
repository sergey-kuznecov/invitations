def login_as_user(user=nil)
  @user = user
  @user ||= create(:user)
  login_as @user
end