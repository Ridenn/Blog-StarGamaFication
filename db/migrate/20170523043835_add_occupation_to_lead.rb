class AddOccupationToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :occupation, :integer, default: 0
  end
end
