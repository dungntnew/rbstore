class StoreController < ApplicationController
  include CurrentCounter
  before_action :track, only: [:index]
  def index
    @products = Product.order(:title)
  end
end
