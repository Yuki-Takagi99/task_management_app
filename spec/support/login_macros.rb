module LoginMacros
  def login
    visit new_session_path
    fill_in 'メールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: '00000000'
    click_button 'ログイン'
  end

  def login_admin
    visit new_session_path
    fill_in 'メールアドレス', with: 'admin@example.com'
    fill_in 'パスワード', with: '00000000'
    click_button 'ログイン'
    click_on 'ユーザー管理'
  end
end
