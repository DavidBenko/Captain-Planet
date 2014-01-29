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
    include HTTParty
    base_uri 'api.eia.gov'
    def get_categories(category_id=nil, options={})
      return category_id if category_id.nil?
      params = {:category_id => category_id, :out => 'json', :api_key => ENV['EIA_API_KEY']}
      options.merge!({:query => HashWithIndifferentAccess.new(params)})
      self.class.get('/category', options)
    end
    def get_series(series_id=nil, options={})
      return series_id if series_id.nil?
      params = {:series_id => series_id, :out => 'json', :api_key => ENV['EIA_API_KEY']}
      options.merge!({:query => HashWithIndifferentAccess.new(params)})
      self.class.get('/series', options)
    end
  end

  class EIACategory
    include ApiFormats
    attr_accessor :name
    attr_accessor :category_id
    attr_accessor :parent_category_id
    attr_accessor :notes
    attr_reader :response_body

    @name = '' if @name.blank?
    @category_id = -1 if @category_id.blank?

    def retrieve_object(force=false)
      return @response_body if (!force) && (!@response_body.blank?)
      @response_body = HashWithIndifferentAccess.new(get_categories(@category_id, {}))
    end

    def sync_with_server(force=false)
      body = retrieve_object(force)
      attrs = body[:category]
      @name = attrs[:name]
    end

    # Returns array of EIA::EIACategory objects
    def get_child_categories
      ret = []
      body = retrieve_object
      cats = body[:category]
      children = cats[:childcategories]
      children.each { |child|
        cat = EIACategory.new
        cat.name = child[:name]
        cat.category_id = child[:category_id]
        ret << cat
      }
      ret
    end

    # Returns array of EIA::EIASeries objects
    def get_child_series
      ret = []
      body = retrieve_object
      cats = body[:category]
      children = cats[:childseries]
      children.each { |child|
        cat = EIASeries.new
        cat.name = child[:name]
        cat.series_id = child[:series_id]
        cat.f = child[:f]
        cat.units = child[:units]
        cat.updated = child[:updated]
        ret << cat
      }
      ret
    end
  end

  class EIASeries
    include ApiFormats
    attr_accessor :name
    attr_accessor :series_id
    attr_accessor :f
    attr_accessor :units
    attr_accessor :updated
    attr_accessor :units_short
    attr_accessor :desc
    attr_accessor :copyright
    attr_accessor :source
    attr_accessor :iso3166
    attr_accessor :lat
    attr_accessor :lon
    attr_accessor :start
    attr_accessor :end
    attr_accessor :data
    attr_reader :response_body

    @name = '' if @name.blank?
    @series_id = -1 if @series_id.blank?

    def retrieve_object(force=false)
      return @response_body if (!force) && (!@response_body.blank?)
      @response_body = HashWithIndifferentAccess.new(get_series(@series_id, {}))
    end

    def sync_with_server(force=false)
      body = retrieve_object(force)
      attrs = body[:series]
      @name = attrs[:name]
      @units = attrs[:units]
      @f = attrs[:f]
      @units_short = attrs[:unitsshort]
      @desc = attrs[:description]
      @copyright = attrs[:copyright]
      @source = attrs[:source]
      @iso3166 = attrs[:iso3166]
      @lat = attrs[:lat]
      @lon = attrs[:lon]
      @start = attrs[:start]
      @end = attrs[:end]
      @updated = attrs[:updated]
      @data = attrs[:data]
    end
  end

  # Helper classes for the base categories
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