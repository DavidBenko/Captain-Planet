# -*- encoding : utf-8 -*-
module Web
  class WelcomeController < Web::ControllerBase
    def index
      eia = EIA::Electricity.new
      eia.sync_with_server
      p eia.parent_category_id
      p eia.get_child_categories
    end
  end
end
