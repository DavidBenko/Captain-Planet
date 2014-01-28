# -*- encoding : utf-8 -*-
require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def setup
    @model = Session.new
  end

end
