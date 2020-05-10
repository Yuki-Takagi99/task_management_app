require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = create(:user)
    @admin_user = create(:admin_user)

    @task = create(:task, user: @user)
    @second_task = create(:second_task, user: @user)
    @third_task = create(:third_task, user: @user)

    @label = create(:label)
    @second_label = create(:second_label)
    @third_label = create(:third_label)

    create(:labelling, task: @task, label: @label)
    create(:labelling, task: @second_task, label: @second_label)
    create(:labelling, task: @third_task, label: @third_label)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        login
        visit tasks_path
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'second_test_title'
        expect(page).to have_content 'third_test_title'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        login
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'third_test_title'
        expect(task_list[1]).to have_content 'second_test_title'
        expect(task_list[2]).to have_content 'test_title'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it 'タスクが終了期限の昇順に並んでいること' do
        login
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 0.5 # テスト失敗を回避
        task_list = all('.deadline_row')
        expect(task_list[0]).to have_content '2020-06-01'
        expect(task_list[1]).to have_content '2020-06-02'
        expect(task_list[2]).to have_content '2020-06-03'
      end
    end
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高・中・低の順で並んでいること' do
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
      it "タイトルのみで検索できること" do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'test_title'
        click_on '検索'
        expect(page).to have_content 'test_title'
      end
      it "ステータスのみで検索できること" do
        login
        visit tasks_path
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content '着手中'
      end
      it "ラベルのみで検索できること" do
        login
        visit tasks_path
        select 'label1', from: 'label_id'
        click_on '検索'
        expect(page).to have_content 'label1'
      end
      it 'タイトルとステータスで検索できること' do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'test_title'
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content 'test_title'
        expect(page).to have_content '着手中'
      end
      it 'タイトルとラベルで検索できること' do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'test_title'
        select 'label1', from: 'label_id'
        click_on '検索'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'label1'
      end
      it 'ステータスとラベルで検索できること' do
        login
        visit tasks_path
        select '未着手', from: '状態'
        select 'label1', from: 'label_id'
        click_on '検索'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'label1'
      end
      it 'タイトルとステータスとラベルで検索できること' do
        login
        visit tasks_path
        fill_in 'タイトル', with: 'test_title'
        select '未着手', from: '状態'
        select 'label1', from: 'label_id'
        click_on '検索'
        expect(page).to have_content 'test_title'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'label1'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        login
        visit new_task_path
        fill_in 'タイトル', with: 'create_test_title'
        fill_in '詳細', with: 'create_test_description'
        check 'label1'
        click_on '登録する'
        expect(page).to have_content 'create_test_title'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         login
         visit tasks_path
         click_on 'test_title'
         expect(page).to have_content 'test_title'
         expect(page).to have_content 'test_description'
         expect(page).to have_content 'label1'
       end
     end
  end
end
