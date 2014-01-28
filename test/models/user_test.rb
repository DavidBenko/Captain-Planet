# -*- encoding : utf-8 -*-
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = FactoryGirl.build(:user)
  end

  def test_must_be_valid
    assert @user.valid?, 'Must be valid'
  end

  def test_must_respond_to_e_mail
    assert @user.respond_to?(:e_mail), 'Must respond to :e_mail'
  end

  def test_e_mail_must_be_lower_cased_on_save
    e_mail_in_mixed_case = 'uSeR@ExAmPlE.CoM'
    @user.e_mail = e_mail_in_mixed_case
    @user.save!
    assert_equal @user.reload.e_mail, e_mail_in_mixed_case.downcase, 'E-mail must be lower cased on save'
  end

  def test_non_unique_e_mail_must_be_rejected
    user_with_same_e_mail = @user.dup
    @user.save!
    refute user_with_same_e_mail.valid?, 'User with duplicated e-mail address must not be valid'
  end

  def test_authentication
    assert @user.respond_to?(:authenticate), 'Must respond to :authenticate'

    @user.password = @user.password_confirmation = 'foobar'
    @user.save!

    found_user = User.find_by e_mail: @user.e_mail
    assert_equal @user, found_user.authenticate('foobar'), 'Authenticated user must be the same as our user'

    wrong_authentication_result = found_user.authenticate('foobaz')
    refute wrong_authentication_result.instance_of?(User), 'Wrong authentication result must not be instance of User'
    refute_equal @user, wrong_authentication_result, 'Wrong authentication result must not be the same as our user'
    refute wrong_authentication_result, 'Wrong authentication result must be false'
  end

  def test_remember_token
    assert @user.respond_to?(:remember_token), 'Must respond to :remember_token'

    @user.save!

    refute_nil @user.remember_token, 'Remember token must not be nil after save'
    refute_empty @user.remember_token, 'Remember token must not be empty after save'
  end

end
