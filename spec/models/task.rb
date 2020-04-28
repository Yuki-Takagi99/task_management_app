require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', description: '')
    expect(task).not_to be_valid
  end
  it 'titleとdescriptionに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', description: '成功テスト')
    expect(task).to be_valid
  end
end
