module GreenButton
  class GBBase
    include HTTParty
    include ApiFormats
    format :xml
  end
  module DataCustodian
    class DataCustodian <GBBase
      self.base_uri 'services.greenbuttondata.org:443/DataCustodian/espi/1_1/resource'
    end
    class ApplicationInformation < DataCustodian

      attr_accessor :data_custodian_application_status
      attr_accessor :third_party_notify_uri
      attr_accessor :data_custodian_bulk_request_uri
      attr_accessor :data_custodian_resource_endpoint
      attr_accessor :third_party_scope_selection_screen_uri
      attr_accessor :client_secret
      attr_accessor :redirect_uri
      attr_accessor :client_id
      attr_accessor :scope
      attr_accessor :data_custodian_id
      attr_accessor :third_party_application_name

      def self.parse_application_information(app_info)
        app = ApplicationInformation.new
        app.data_custodian_application_status = app_info[:dataCustodianApplicationStatus]
        app.third_party_notify_uri = app_info[:thirdPartyNotifyUri]
        app.data_custodian_bulk_request_uri = app_info[:dataCustodianBulkRequestURI]
        app.data_custodian_resource_endpoint = app_info[:dataCustodianResourceEndpoint]
        app.third_party_scope_selection_screen_uri = app_info[:thirdPartyScopeSelectionScreenURI]
        app.client_secret = app_info[:client_secret]
        app.redirect_uri = app_info[:redirect_uri]
        app.client_id = app_info[:client_id]
        app.scope = app_info[:scope]
        app.data_custodian_id = app_info[:dataCustodianId]
        app.third_party_application_name = app_info[:thirdPartyApplicationName]
        app
      end
      def self.parse_application_information_array(app_info = [])
        ret = []
        app_info.each do |app|
          ret << self.parse_application_information(app)
        end
        ret
      end

      def self.all
        apps = HashWithIndifferentAccess.new(get('/ApplicationInformation').parsed_response)[:feed][:entry][:content]['ApplicationInformation']
        if apps.is_a?(Array)
          self.parse_application_information_array(apps)
        else
          [self.parse_application_information(apps)]
        end
      end

      def self.find_by_id(app_info_id)
        app = HashWithIndifferentAccess.new(get("/ApplicationInformation/#{app_info_id}").parsed_response)[:feed][:entry][:content]['ApplicationInformation']
        self.parse_application_information(app)
      end

      def xml
        # return instance as xml
      end

      def create
        # post instance to server
      end

      def update
        # put instance to server
      end

      def delete
        # delete instance to server
      end
    end
    class Authorization < DataCustodian
      def self.all
        auths = HashWithIndifferentAccess.new(get('/Authorization').parsed_response)[:feed][:entry][:content]['Authorization']
      end
    end
  end
end