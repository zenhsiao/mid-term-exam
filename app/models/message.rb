class Message < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	belongs_to :category
	has_many :comments
end
