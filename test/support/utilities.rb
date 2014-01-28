# -*- encoding : utf-8 -*-
def sign_in(user)
  visit sign_in_path unless page.has_selector?('legend', text: 'Sign in')
  fill_in 'E-mail', with: user.e_mail
  fill_in 'Password', with: user.password
  click_button 'Sign in'
  cookies[:remember_token] = user.remember_token
end
