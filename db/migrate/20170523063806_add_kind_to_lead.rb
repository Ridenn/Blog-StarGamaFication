class AddKindToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :kind, :string
  end
end
