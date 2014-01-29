# -*- encoding : utf-8 -*-
module Web
  class WelcomeController < Web::ControllerBase
    def index
      eia = EIA::Electricity.new
      p eia.getChildCategories().inspect
    end
  end
end
