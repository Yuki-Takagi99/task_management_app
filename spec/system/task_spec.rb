require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title_01'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'test_title_03'
        expect(task_list[1]).to have_content 'test_title_02'
        expect(task_list[2]).to have_content 'test_title_01'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it 'タスクが終了期限の昇順に並んでいる' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.deadline_row')
        expect(task_list[0]).to have_content '2020-06-01'
        expect(task_list[1]).to have_content '2020-06-02'
      end
    end
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高・中・低の順で並んでいる' do
        visit tasks_path
        click_on '優先順位でソートする'
        task_list = all('.priority_row')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
      end
    end
    context '検索をした場合' do
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in 'タイトル', with: 'test_title_01'
        click_on '検索'
        expect(page).to have_content 'test_title_01'
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content '着手中'
      end
      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        fill_in 'タイトル', with: 'test_title_01'
        select '着手中', from: '状態'
        click_on '検索'
        expect(page).to have_content 'test_title_01'
        expect(page).to have_content '着手中'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タイトル', with: 'test_title_03'
        fill_in '詳細', with: 'test_description_03'
        click_on '登録する'
        expect(page).to have_content 'test_title_03'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         task = FactoryBot.create(:task, title: 'test_title_04', description: 'test_description_04')
         visit tasks_path
         click_on 'test_title_04'
         expect(page).to have_content 'test_description_04'
       end
     end
  end
end
