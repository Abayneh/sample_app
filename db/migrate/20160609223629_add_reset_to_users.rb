class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rest_digest, :string #rename column is going on rest_digest
    add_column :users, :reset_sent_at, :datetime
  end
end