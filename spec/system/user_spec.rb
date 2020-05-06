require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    @user = create(:user)
    @admin_user = create(:admin_user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザの新規登録ができること' do
        visit users_new_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on 'アカウントを作成する'
        expect(page).to have_content 'test'
        expect(page).to have_content 'test@example.com'
      end
      it 'ログインしていない時はログイン画面に遷移すること' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context '一般ユーザーのデータが存在する場合' do
      it 'ログインができること' do
        login
        expect(page).to have_content 'sample'
        expect(page).to have_content 'sample@example.com'
      end
      it 'ログインしたユーザーのマイページに遷移できること' do
        login
        expect(page).to have_content 'sample'
        expect(page).to have_content 'sample@example.com'
      end
      it '一般ユーザーが他ユーザの詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        login
        visit user_path(id: 2)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができること' do
        login
        click_on 'ログアウト'
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理権限を持つユーザーが存在する場合' do
      it '管理者は管理画面にアクセスできること' do
        login_admin
        expect(current_path).to eq admin_users_path
      end
      it '一般ユーザーは管理画面にアクセスできないこと' do
        login
        click_on 'ユーザー管理'
        expect(page).to have_content 'あなたは管理者ではありません'
      end
      it '管理者はユーザーを新規登録できること' do
        login_admin
        click_on 'ユーザー登録'
        fill_in '名前', with: 'trial'
        fill_in 'メールアドレス', with: 'trial@example.com'
        check 'input_admin'
        fill_in 'パスワード', with: '00000000'
        fill_in 'パスワード(確認)', with: '00000000'
        click_button '登録'
        expect(page).to have_content 'trial'
        expect(page).to have_content 'trial@example.com'
      end
      it '管理者はユーザーの詳細画面にアクセスできること' do
        login_admin
        click_on 'sample'
        expect(page).to have_content 'sample'
        expect(page).to have_content 'sample@example.com'
      end
      it '管理者はユーザーの編集画面からユーザーを編集できること' do
        login_admin
        click_on '編集', match: :first
        fill_in '名前', with: 'sam'
        fill_in 'メールアドレス', with: 'sam@example.com'
        check 'input_admin'
        fill_in 'パスワード', with: '00000000'
        fill_in 'パスワード(確認)', with: '00000000'
        click_button '登録'
        expect(page).to have_content 'sam'
        expect(page).to have_content 'sam@example.com'
      end
      it '管理者はユーザーを削除できること' do
        login_admin
        page.accept_confirm do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'ユーザー「sample」を削除しました。'
      end
    end
  end
end
