class Product < ActiveRecord::Base
	belongs_to :category
	has_many :comments, :dependent => :destroy
	validates :name, :description, :price, :presence => true
end
