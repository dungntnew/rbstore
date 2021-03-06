class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_any_line_item
  
  # title, description, image_url must presence
  validates :title, :description, :image_url, presence: true
  
  # ensuare price is numericality and have value >= 0.01
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
 
  # ensure each product has a unique title
  validates :title, uniqueness: true 
  
  # ensuare title has length with mininum: 2 and maximum: 20
  validates :title, length: {
    minimum: 5,
    maximum: 128,
    too_long: 'title too long, must less than 128',
    too_short: 'title too short, must longger 5'
  
  }
  
  # validate that the url entered for the image is valid.
  validates :image_url, allow_blank:true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.latest
    Product.order(:updated_at).last
  end
  
  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
