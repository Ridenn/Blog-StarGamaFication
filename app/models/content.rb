class Content < ApplicationRecord
  validates :site_area, presence: true
  validates :featured_image, presence: true
  validates :content, presence: true


  enum site_area: [ :hero, :panel, :minibox1, :minibox2, :slider, :footer1, :footer2 ]

  def self.options_for_select
    site_areas
  end
end
