class BuildingPerformance
  include HTTParty
  base_uri 'https://bpd.lbl.gov/api/v1'

  BPD_USER_NAME = 'dbenko@prndl.us'

=begin
  /analyze/peers
  Canonical URL:
    https://bpd.lbl.gov/api/v1/analyze/peers/
  Description: Used to investigate energy use intensity (EUI) trends for the peer group defined by filters parameter
  Method type: POST
=end
  def peers
    self.class.post(
      "/analyze/peers/",
      :body => payload,
      :headers => headers
    ).parsed_response
  end

=begin
  /analyze/counts-per-state
  Canonical URL:
    https://bpd.lbl.gov/api/v1/analyze/counts-per-state/
  Description: Used to find number of buildings per state for the peer group defined by the filter parameter
  Method type: POST
=end
  def counts_per_state
    self.class.post(
      "/analyze/counts-per-state/",
      :body => payload,
      :headers => headers
    ).parsed_response
  end

=begin
  /analyze/compare/eui
  Canonical URL:
    https://bpd.lbl.gov/api/v1/analyze/compare/eui
  Description: Describes distribution of EUI changes (+ or -) between two similar groups of buildings if one technology was replaced by another
  Method type: POST
=end
  def compare_eui
    self.class.post(
        "/analyze/compare/eui/",
        :body => payload,
        :headers => headers
    ).parsed_response
  end

  def payload
    payload = {
      'filters' => {
        'state' => ['CA', 'IL' 'OR'],
          'facility-type' => ['Retail - Big Box (> 50K sf)']
      },
      'number_of_bins' => 25
    }
    payload.to_json
  end
  def headers
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "ApiKey #{ BPD_USER_NAME }:#{ ENV['BUILDING_PERFORMANCE_API_KEY'] }"
    }
  end
end