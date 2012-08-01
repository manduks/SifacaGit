class IndexController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index


  end

  def dashboard

  end
end
