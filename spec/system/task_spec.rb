require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        create(:task)
        visit tasks_path
        expect(page).to have_content 'test_title_1'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        create_list(:task, 3)
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'test_title_4'
        expect(task_list[1]).to have_content 'test_title_3'
        expect(task_list[2]).to have_content 'test_title_2'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it 'タスクが終了期限の昇順に並んでいる' do
        create(:task)
        create(:deadline_first)
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
        create(:low_priority)
        create(:middle_priority)
        create(:high_priority)
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
        create(:task)
      end
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in 'タイトル', with: 'test_title_6'
        click_on '検索'
        expect(page).to have_content 'test_title_6'
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content '着手中'
      end
      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        fill_in 'タイトル', with: 'test_title_8'
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content 'test_title_8'
        expect(page).to have_content '着手中'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
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
         task = create(:task, title: 'show_test_title', description: 'show_test_description')
         visit tasks_path
         click_on 'show_test_title'
         expect(page).to have_content 'show_test_description'
       end
     end
  end
end
