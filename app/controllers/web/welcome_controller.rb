# -*- encoding : utf-8 -*-
module Web
  class WelcomeController < Web::ControllerBase
    def index
      #########
      # Running API Tests
      p 'Running API Tests'
      p '---'
      p 'Green Button'
      gb = GreenButton::DataCustodian::ApplicationInformation.new
      p GreenButton::DataCustodian::ApplicationInformation.all.inspect
      p '---'
      p 'Home Energy Score (SOAP)'
      hes = HomeEnergyScore::HomeEnergyScore.new
      p 'Operations List:'
      p hes.list_operations.inspect
      p '---'
      p 'EIA (JSON REST)'
      test = EIA::SEDS.new
      test.sync_with_server
      p 'Synced Object:'
      p test.inspect
      p 'Child Categories: '
      p test.get_child_categories.inspect
      p '---'
    end
  end
end
