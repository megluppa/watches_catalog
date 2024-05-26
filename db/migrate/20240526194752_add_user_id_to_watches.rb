class AddUserIdToWatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :watches, :user, null: false, foreign_key: true
  end
end
