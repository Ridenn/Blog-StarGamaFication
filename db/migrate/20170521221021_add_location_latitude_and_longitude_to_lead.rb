class AddLocationLatitudeAndLongitudeToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :city, :string
    add_column :leads, :region_name, :string
    add_column :leads, :country_name, :string
    add_column :leads, :latitude, :float
    add_column :leads, :longitude, :float
  end
end
