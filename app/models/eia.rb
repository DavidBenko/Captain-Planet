module EIA
  #
  # ENERGY INFORMATION ADMINISTRATION API
  # The U.S. Energy Information Administration (EIA) collects, analyzes,
  # and disseminates independent and impartial energy information to promote
  # sound policymaking, efficient markets, and public understanding of energy
  # and its interaction with the economy and the environment.
  #
  #
  # Category Id's are pulled from
  # http://api.eia.gov/category?api_key={API_KEY}&category_id=371&out=json
  #

  module ApiFormats
    def getCategories(category=nil, options={})
      params = {:category_id => category, :out => 'json', :api_key => ENV['EIA_API_KEY']}
      options.merge!({:query => HashWithIndifferentAccess.new(params)})
      self.class.get('/category', options)
    end
  end

  class EIACategory
    include HTTParty
    base_uri 'api.eia.gov'
    include ApiFormats
    @category_id = -1

    def getChildCategories
      getCategories(@category_id, {})
    end
  end

  class SEDS < EIACategory
    @category_id = 40203
  end
  class Electricity < EIACategory
    @category_id = 0
  end
  class NaturalGas < EIACategory
    @category_id = 714804
  end
  class Petroleum < EIACategory
    @category_id = 714755
  end
end