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

  def self.assessment_types
    @@assessment_types
  end

  class HomeEnergyScore
    extend Savon::Model
    client wsdl: 'http://trk-hesapici-sb.hescloud.net/st_api/wsdl'

    operations :submit_address, :submit_inputs, :calculate, :commit_results,
               :generate_label, :retrieve_inputs, :retrieve_label_results,
               :retrieve_extended_results, :retrieve, :retrieve_recommendations,
               :retrieve_buildings_by_id, :delete_buildings_by_id, :archive_buildings_by_id,
               :retrieve_buildings_by_address, :validate_inputs

    def list_operations
      client.operations
    end

    # Creates a new building
    def submit_address(address='', city='', state='', zip_code='', assessment_type='')
      params = {
          'building_address' => {
            'user_key' => ENV['HOME_ENERGY_SCORE_USER_KEY'],
            'qualified_assessor_id' => ENV['HOME_ENERGY_SCORE_QAID'],
            'address' => address,
            'city' => city,
            'state' => state,
            'zip_code' => zip_code,
            'assessment_type' => assessment_type
          }
      }
      super(message: params)
    end

  end
end