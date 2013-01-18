class RemoveAuthFromUsers < ActiveRecord::Migration
  def self.down
       add_column :users, :provider, :string
       add_column :users, :uid, :string
    end

    def self.up
      remove_column :users, :provider
      remove_column :users, :uid
    end
end
