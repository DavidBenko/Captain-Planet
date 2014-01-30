module HomeEnergyScore
  #
  # The Home Energy Score is similar to a vehicle's mile-per-gallon rating.
  # The Home Energy Score allows homeowners to compare the energy performance
  # of their homes to other homes nationwide. It also provides homeowners
  # with suggestions for improving their homes' efficiency.
  #
  # The process starts with a Home Energy Score Qualified Assessor
  # collecting energy information during a brief home walk-through.
  # Using the Home Energy Scoring Tool, developed by the
  # Lawrence Berkeley National Laboratory, the Qualified Assessor
  # then scores the home on a scale of 1 to 10.
  # A score of 10 indicates that the home has excellent energy performance.
  # A score of 1 indicates the home needs extensive energy improvements.
  # In addition to providing the Score, the Qualified Assessor provides the
  # homeowner with a list of recommended energy improvements and the associated
  # cost savings estimates.
  #
  # http://trk-hesapici-sb.hescloud.net/st_api/wsdl
  #
  #
  # Docs
  # https://developers.buildingsapi.lbl.gov/hescore/documentation/hescore-api-methods
  #

  @@assessment_types= {
      :initial => 'initial',
      :final => 'final',
      :qa => 'qa',
      :alternative => 'alternative',
      :test => 'test',
      :corrected => 'corrected'
  }

  @@result_statuses= {
      :ok => 'OK',
      :fail => 'FAIL'
  }


  def self.assessment_types
    @@assessment_types
  end

  def self.result_statuses
    @@result_statuses
  end

  module HESKeys
    def user_key
      ENV['HOME_ENERGY_SCORE_USER_KEY']
    end

    def qualified_assessor_id
      ENV['HOME_ENERGY_SCORE_QAID']
    end
  end

  class HomeEnergyScore
    include HESKeys
    extend Savon::Model
    client wsdl: 'http://trk-hesapici-sb.hescloud.net/st_api/wsdl'

    operations :submit_address, :submit_inputs, :calculate, :commit_results,
               :generate_label, :retrieve_inputs, :retrieve_label_results,
               :retrieve_extended_results, :retrieve, :retrieve_recommendations,
               :retrieve_buildings_by_id, :delete_buildings_by_id, :archive_buildings_by_id,
               :retrieve_buildings_by_address, :validate_inputs

    # List available SOAP operations
    def list_operations
      client.operations
    end

    #
    # Note: the params hashes need literal string keys (no symbols)
    # for some reason, Savon changes underscore case to camel case for the xml keys
    #

    # Takes an address and creates a default building.
    def submit_address(address='', city='', state='', zip_code='', assessment_type='')
      params = {
          'building_address' => {
            'user_key' => user_key,
            'qualified_assessor_id' => qualified_assessor_id,
            'address' => address,
            'city' => city,
            'state' => state,
            'zip_code' => zip_code,
            'assessment_type' => assessment_type
          }
      }
      result = super(message: params).body[:submit_addressResponse][:submit_address_result]
      bldg = Building.new
      bldg.building_id = result[:building_id]
      [bldg]
    end

    # Modifies or submits inputs for a created building (by submit_address).
    # Note that all inputs do not need to be complete until the calculation step,
    # one can submit and modify multiple times.
    def submit_inputs(building_id,about={},zone={},systems={})
      params = {
          'building' => {
              'user_key' => user_key,
              'building_id' => building_id,
              'about' => about,
              'zone' => zone,
              'systems' => systems
          }.delete_if{|key, value| value.is_a?(Hash) && value.empty? }
      }
      result = super(message: params).body[:submit_inputsResponse][:submit_inputs_result]
      result[:result]
    end

    # This XSD handles the two calculation methods, which have similar submits.
    # calc_base_building() does the energy calculation the current submitted
    # inputs for the building. calc_package_building does the same for the
    # several upgrade runs and assembled the selected upgrades into the a "package"
    # building that combines the recommended upgrades and presents both consumption
    # for that configuration and savings compared to base.
    def calculate(building_id, validates_inputs=true)
      params = {
          'building_info' => {
              'user_key' => user_key,
              'building_id' => building_id,
              'validates_inputs' => (validates_inputs ? 1 : 0)
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Finalizes the model inputs configuration of a created building assessment.
    def commit_results(building_id)
      params = {
          'building_info' => {
              'user_key' => user_key,
              'building_id' => building_id
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Inititates the label generation (PDF document) for a successfully calculated
    # home scoring assessment.
    def generate_label(building_id, force_regenerate=true)
      params = {
          'building_label' => {
              'user_key' => user_key,
              'building_id' => building_id,
              'force_regenerate' => (force_regenerate ? 1 : 0)
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Returns a list of the submitted inputs for an already created building assessment.
    def retrieve_inputs(building_id, period_type, period_number, resource_type, end_use)
      # todo restrict the inputs here
      params = {
          'retrieve_in' => {
              'building_id' => building_id,
              'period_type' => period_type,
              'period_number' => period_number,
              'resource_type' => resource_type,
              'end_use' => end_use
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Returns a list of the submitted inputs for an already created building assessment.
    # This method has a fucking ton of params... like wtf
    # method doc: http://documentation.hescloud.net/api/st/xsd/hes-st_xsd-retrieve-label-results_sb.html
    def retrieve_label_results(label_result={})
      # todo I dont think this is implemented right
      params = {
          'label_result' => label_result
      }
      # todo parse this
      super(message: params).body
    end

    # Returns an extended list of additional results in addition to the official Label results
    # returned by retrieve_label_results().
    def retrieve_extended_results(extended_result={})
      # todo I dont think this is implemented right
      params = {
          'extended_result' => extended_result
      }
      # todo parse this
      super(message: params).body
    end

    # Returns the full set of Scoring Tool building energy calculation results.
    def retrieve(building_id, period_type, period_number, resource_type, end_use)
      # todo restrict the inputs here
      params = {
          'retrieve_in' => {
              'building_id' => building_id,
              'period_type' => period_type,
              'period_number' => period_number,
              'resource_type' => resource_type,
              'end_use' => end_use
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Returns the list upgrade recommendations included in the Package Buildings as
    # determined by calculate_package_building().
    def retrieve_recommendations
      # todo another retrieve
      # http://documentation.hescloud.net/api/st/xsd/hes-st_xsd-retrieve-recommendations_sb.html
    end

    # Returns a list of buildings for a specified Qualified Assessor (QA) number.
    def retrieve_buildings_by_id(limit,offset,archive=false)
      params = {
          'buildings_by_id' => {
              'user_key' => user_key,
              'qualified_assessor_id' => qualified_assessor_id,
              'rows_per_page' => limit,
              'page_number' => offset,
              'archive' => (archive ? 1 : 0)
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Removes one or more specified buildings from the user's list of home assessments in the database.
    def delete_buildings_by_id(buildings=[])
      building_ids = Building.delimited_ids(buildings)
      params = {
          'delete_buildings_by_id' => {
              'user_key' => user_key,
              'qualified_assessor_id' => qualified_assessor_id,
              'buildings' => building_ids
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Tags one or more home assessments in the database as being archived.
    def archive_buildings_by_id(buildings=[], archive=false)
      building_ids = Building.delimited_ids(buildings)
      params = {
          'archive_buildings_by_id' => {
              'user_key' => user_key,
              'qualified_assessor_id' => qualified_assessor_id,
              'buildings' => building_ids,
              'archive' => (archive ? 1 : 0)
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Returns the "Assessment Date" and the "Location" information for a specified address.
    def retrieve_buildings_by_address(query_field,query_text,limit,offset,archive=false)
      params = {
          'buildings_by_address' => {
              'user_key' => user_key,
              'qualified_assessor_id' => qualified_assessor_id,
              'query_field' => query_field,
              'query_text' => query_text,
              'rows_per_page' => limit,
              'page_number' => offset,
              'archive' => (archive ? 1 : 0)
          }
      }
      # todo parse this
      super(message: params).body
    end

    # Basic categorical level input validation.
    def validate_inputs(building_id)
      params = {
          'validate_inputs' => {
              'user_key' => user_key,
              'building_id' => building_id
          }
      }
      # todo parse this
      super(message: params).body
    end
  end

  class Building
    attr_accessor :building_id
    def self.delimited_ids(buildings=[])
      # Change HomeEnergyScore::Building into pipe-delimited id string
      buildings.map{|x| x.building_id}.join('|')
    end
  end

  class File
    attr_accessor :type
    attr_accessor :url
  end

end