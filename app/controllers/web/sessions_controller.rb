# -*- encoding : utf-8 -*-
module Web
  class SessionsController < Web::ControllerBase

    def new
      @session = Session.new
    end

    def create
      session_params = params[:session]
      @session = Session.new(session_params[:e_mail], session_params[:password])

      unless @session.valid?
        flash.now[:error] = t('sessions.create.error.wrong_sign_in_data')
        render 'new'
        return
      end

      user = @session.authenticate
      if user
        sign_in user
        flash[:success] = t('sessions.create.success')
        redirect_to :root
      else
        flash.now[:error] = t('sessions.create.error.authentication_failure')
        @authentication_failed = true
        render 'new'
      end
    end

    def destroy
      sign_out
      redirect_to :root
      clear_stored_location
    end
  end
end
