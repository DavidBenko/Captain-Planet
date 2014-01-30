module GreenButton
  class DataCustodian
    include HTTParty
    base_uri 'services.greenbuttondata.org:443/DataCustodian/espi/1_1/resource/'

    def meter_reading(i)
      response  = self.class.get("/MeterReading")
    end
  end
end