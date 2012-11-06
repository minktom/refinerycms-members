
FactoryGirl.define do
  factory :member_group, :class => Refinery::MemberGroups::MemberGroup do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

