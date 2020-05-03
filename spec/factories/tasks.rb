FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "test_title_#{n}"}
    sequence(:description) { |n| "test_description_#{n}"}
    end_deadline { '2020-06-01' }
    status { '着手中' }
    priority { '低' }
  end
  factory :deadline_first, class: Task do
    title { "deadline_first" }
    description { "deadline_first" }
    end_deadline { '2020-06-02' }
    priority { '中' }
  end
  factory :deadline_second, class: Task do
    title { "deadline_second" }
    description { "deadline_second" }
    end_deadline { '2020-06-03' }
    status { '未着手' }
    priority { '高' }
  end
  factory :low_priority, class: Task do
    title { "low_priority" }
    description { "low_priority" }
    end_deadline { '2020-06-03' }
    status { '未着手' }
    priority { '低' }
  end
  factory :middle_priority, class: Task do
    title { "middle_priority"}
    description { "middle_priority" }
    end_deadline { '2020-06-03' }
    status { '未着手' }
    priority { '中' }
  end
  factory :high_priority, class: Task do
    title { "high_priority"}
    description { "high_priority" }
    end_deadline { '2020-06-03' }
    status { '未着手' }
    priority { '高' }
  end
end
