# -*- encoding : utf-8 -*-
require 'test_helper'

module Web
  class WelcomeControllerTest < ActionController::TestCase

    it 'renders home page at the root' do
      visit root_path
      assert page.has_title?('Rails4Template - Rails4Template'), 'Page must have the correct title'
      assert_selector('h1', text: 'Rails4Template')
    end

  end
end
