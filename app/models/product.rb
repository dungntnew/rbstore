class Product < ActiveRecord::Base
  
  # title, description, image_url must presence
  validates :title, :description, :image_url, presence: true
  
  # ensuare price is numericality and have value >= 0.01
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
 
  # ensure each product has a unique title
  validates :title, uniqueness: true
  
  # validate that the url entered for the image is valid.
  validates :image_url, allow_blank:true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
