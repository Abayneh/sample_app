class ChangeRestDigestToResetDigest < ActiveRecord::Migration
  def change
    rename_column :users, :rest_digest,  :reset_digest
  end
end
