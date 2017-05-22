class AddIpAddressToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :ip, :string
  end
end
