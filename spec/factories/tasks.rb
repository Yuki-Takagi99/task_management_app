FactoryBot.define do
  factory :task do
    title { "test_title" }
    description { "test_description" }
    end_deadline { '2020-06-01' }
    status { '未着手' }
    priority { '高' }
  end
  factory :second_task, class: Task do
    title { "second_test_title" }
    description { "second_test_description" }
    end_deadline { '2020-06-02' }
    status { '着手中' }
    priority { '中' }
  end
  factory :third_task, class: Task do
    title { "third_test_title" }
    description { "third_test_description" }
    end_deadline { '2020-06-03' }
    status { '完了' }
    priority { '低' }
  end
  # factory :multiple_task, class: Task do
  #   sequence(:title) { |n| "test_title_#{n}"}
  #   sequence(:description) { |n| "test_description_#{n}"}
  #   sequence(:created_at) { |n| Time.current + n.days }
  #   end_deadline { '2020-06-01' }
  #   status { '着手中' }
  #   priority { '低' }
  #   user_id { '1' }
  # end
  # factory :deadline_first, class: Task do
  #   title { "deadline_first" }
  #   description { "deadline_first" }
  #   end_deadline { '2020-06-02' }
  #   priority { '中' }
  # end
  # factory :deadline_second, class: Task do
  #   title { "deadline_second" }
  #   description { "deadline_second" }
  #   end_deadline { '2020-06-03' }
  #   status { '未着手' }
  #   priority { '高' }
  # end
  # factory :low_priority, class: Task do
  #   title { "low_priority" }
  #   description { "low_priority" }
  #   end_deadline { '2020-06-03' }
  #   status { '未着手' }
  #   priority { '低' }
  # end
  # factory :middle_priority, class: Task do
  #   title { "middle_priority"}
  #   description { "middle_priority" }
  #   end_deadline { '2020-06-03' }
  #   status { '未着手' }
  #   priority { '中' }
  # end
  # factory :high_priority, class: Task do
  #   title { "high_priority"}
  #   description { "high_priority" }
  #   end_deadline { '2020-06-03' }
  #   status { '未着手' }
  #   priority { '高' }
  # end
    # factory :search_task, class: Task do
    #   title { "search_title" }
    #   description { "search_description" }
    #   end_deadline { '2020-06-03' }
    #   status { '着手中' }
    #   priority { '高' }
    # end
end
