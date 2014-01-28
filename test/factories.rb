# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    first_name 'Sergey'
    last_name 'Zubtsovskiy'
    e_mail 'sergey.zubtsovskiy@rails4_template.nu'
    password 'foobar'
    password_confirmation 'foobar'
  end
end
