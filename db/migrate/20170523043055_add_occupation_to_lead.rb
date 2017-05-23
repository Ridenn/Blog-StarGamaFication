class AddOccupationToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :occupation, :integer
  end
end
