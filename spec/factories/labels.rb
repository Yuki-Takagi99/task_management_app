FactoryBot.define do
  factory :label do
    name { "label1" }
  end
  factory :second_label, class: Label do
    name { "label2" }
  end
  factory :third_label, class: Label do
    name { "label3" }
  end
end
