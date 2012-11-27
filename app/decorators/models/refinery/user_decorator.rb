::Refinery::User.class_eval do
  has_one :profile, :class_name => 'Refinery::Members::Item'
end
