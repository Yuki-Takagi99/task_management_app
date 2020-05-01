FactoryBot.define do
  factory :task do
    title { 'test_title_01' }
    description { 'test_description_01' }
    end_deadline { '2020-06-01' }
    status { '着手中' }
  end
  factory :second_task, class: Task do
    title { 'test_title_02' }
    description { 'test_description_02' }
    end_deadline { '2020-06-02' }
  end
end
