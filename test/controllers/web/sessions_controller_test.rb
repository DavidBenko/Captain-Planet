# -*- encoding : utf-8 -*-
require 'test_helper'
module Web
  class SessionsControllerTest < ActionController::TestCase

    let(:user) { FactoryGirl.create(:user) }

    it 'renders correct form when new action called' do
      visit sign_in_path
      assert_selector('legend', text: 'Sign in')
      refute_selector('div.control-group.error')
      refute_selector('span.help-inline', text: 'e-mail')
      refute_selector('span.help-inline', text: 'password')
    end

    it 'redirects to the main screen after successful sign in' do
      visit sign_in_path
      fill_in 'E-mail', with: user.e_mail
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      assert_link('Sign out', href: sign_out_path)
      skip 'Ensure that main screen is shown after signing in'
    end

    describe 'rejects empty form' do
      before do
        visit sign_in_path
        click_button 'Sign in'
      end

      it 'displays error message' do
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Wrong sign-in information has been provided')
        assert_selector('div.control-group.error input#session_e_mail')
        assert_selector('span.help-inline', text: 'e-mail')
        assert_selector('div.control-group.error input#session_password')
        assert_selector('span.help-inline', text: 'password')
      end

      it 'does not display error message after going to another page' do
        visit root_path
        refute_selector('div.alert.alert-error')
      end

    end

    describe 'rejects incorrectly filled form' do
      before { visit sign_in_path }
      it 'rejects missing e-mail address' do
        fill_in 'Password', with: 'foobar'
        click_button 'Sign in'
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Wrong sign-in information has been provided')
        assert_selector('div.control-group.error input#session_e_mail')
        assert_selector('span.help-inline', text: 'e-mail')
        refute_selector('div.control-group.error input#session_password')
        refute_selector('span.help-inline', text: 'password')
      end
      it 'rejects wrong e-mail address' do
        fill_in 'E-mail', with: 'wrong-e-mail-address'
        fill_in 'Password', with: 'foobar'
        click_button 'Sign in'
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Wrong sign-in information has been provided')
        assert_selector('div.control-group.error input#session_e_mail')
        assert_selector('span.help-inline', text: 'Please provide valid e-mail address')
        refute_selector('div.control-group.error input#session_password')
        refute_selector('span.help-inline', text: 'password')
      end
      it 'rejects missing password' do
        fill_in 'E-mail', with: 'somebody@somewhere.net'
        click_button 'Sign in'
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Wrong sign-in information has been provided')
        refute_selector('div.control-group.error input#session_e_mail')
        refute_selector('span.help-inline', text: 'e-mail')
        assert_selector('div.control-group.error input#session_password')
        assert_selector('span.help-inline', text: 'password')
      end
      it 'rejects whole form when e-mail is wrong' do
        fill_in 'E-mail', with: "#{user.e_mail}.com"
        fill_in 'Password', with: user.password
        click_button 'Sign in'
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Invalid e-mail or password')
        assert_selector('div.control-group.error input#session_e_mail')
        assert_selector('div.control-group.error input#session_password')
        refute_selector('span.help-inline', text: 'e-mail')
        refute_selector('span.help-inline', text: 'password')
      end
      it 'rejects whole form when password is wrong' do
        fill_in 'E-mail', with: user.e_mail
        fill_in 'Password', with: user.password * 2
        click_button 'Sign in'
        assert_selector('div.alert.alert-error', text: 'Error')
        assert_selector('div.alert.alert-error', text: 'Invalid e-mail or password')
        assert_selector('div.control-group.error input#session_e_mail')
        assert_selector('div.control-group.error input#session_password')
        refute_selector('span.help-inline', text: 'e-mail')
        refute_selector('span.help-inline', text: 'password')
      end
    end

    it 'redirects to the root page after sign out' do
      sign_in user
      click_link 'Sign out'
      assert_equal root_path, page.current_path, 'Must forward to the root path after sign out'
      assert_link('Sign in', href: sign_in_path)
    end

  end
end
