require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do

  before do
    @user = create(:user)
    @admin_user = create(:admin_user)
  end

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', description: '失敗テスト', user: @user)
    expect(task).not_to be_valid
  end
  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', description: '', user: @user)
    expect(task).not_to be_valid
  end
  it 'titleとdescriptionに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', description: '成功テスト', user: @user)
    expect(task).to be_valid
  end
  describe '検索機能' do
    context 'scopeメソッドで検索をした場合' do
      before do
        Task.create(title: "task", description: "sample_task", status: "着手中", user: @user)
        Task.create(title: "sample", description: "sample_sample", user: @user)
      end
      it "scopeメソッドでタイトル検索ができる" do
        expect(Task.search_title('task').count).to eq 1
      end
      it "scopeメソッドでステータス検索ができる" do
        expect(Task.search_status('着手中').count).to eq 1
      end
      it "scopeメソッドでタイトルとステータスの両方が検索できる" do
        expect(Task.search_title('task').search_status('着手中').count).to eq 1
      end
    end
  end
end
