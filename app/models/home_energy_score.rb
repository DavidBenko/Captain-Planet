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
  #
  #  http://trk-hesapici-sb.hescloud.net/st_api/wsdl
  #

  class HomeEnergyScore
    extend Savon::Model
    client wsdl: 'http://trk-hesapici-sb.hescloud.net/st_api/wsdl'

    def list_operations
      client.operations
    end

  end
end