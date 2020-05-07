require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = create(:user)
    @admin_user = create(:admin_user)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        create(:task, user: @user)
        login
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        create_list(:multiple_task, 3)
        login
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'test_title_3'
        expect(task_list[1]).to have_content 'test_title_2'
        expect(task_list[2]).to have_content 'test_title_1'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it 'タスクが終了期限の昇順に並んでいる' do
        create(:task, user: @user)
        create(:deadline_first, user: @user)
        login
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 0.5 # テスト失敗を回避
        task_list = all('.deadline_row')
        expect(task_list[0]).to have_content '2020-06-01'
        expect(task_list[1]).to have_content '2020-06-02'
      end
    end
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高・中・低の順で並んでいる' do
        create(:low_priority, user: @user)
        create(:middle_priority, user: @user)
        create(:high_priority, user: @user)
        login
        visit tasks_path
        click_on '優先順位でソートする'
        sleep 0.5 # テスト失敗を回避
        task_list = all('.priority_row')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
      end
    end
    context '検索をした場合' do
      before do
        create(:search_task, user: @user)
      end
      it "タイトルで検索できる" do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'search_title'
        click_on '検索'
        expect(page).to have_content 'search_title'
      end
      it "ステータスで検索できる" do
        login
        visit tasks_path
        select '未着手', from: '状態'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
      it 'タイトルとステータスの両方で検索できる' do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'search_title'
        select '未着手', from: '状態'
        click_on '検索'
        expect(page).to have_content 'search_title'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        login
        visit new_task_path
        fill_in 'タイトル', with: 'create_test_title'
        fill_in '詳細', with: 'create_test_description'
        click_on '登録する'
        expect(page).to have_content 'create_test_title'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         login
         create(:task, user: @user, title: 'show_test_title', description: 'show_test_description')
         visit tasks_path
         click_on 'show_test_title'
         expect(page).to have_content 'show_test_description'
       end
     end
  end
end
