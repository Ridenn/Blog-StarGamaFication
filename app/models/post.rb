class Post < ApplicationRecord
  acts_as_disqusable
  validates :title, presence: true, length: {maximum: 140}
  validates :body, presence: true

  belongs_to :admin

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
