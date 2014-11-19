class AddUserIdToQuickCodes < ActiveRecord::Migration
  def change
    add_column :quick_codes, :user_id, :integer
  end
end
