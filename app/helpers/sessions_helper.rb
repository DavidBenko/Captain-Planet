# -*- encoding : utf-8 -*-
module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user                  = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def store_location(location = nil)
    session[:return_to] = location || request.url
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_stored_location
  end

  def clear_stored_location
    session.delete(:return_to)
  end

end
