# -*- encoding : utf-8 -*-
class AddUniqueIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :e_mail, unique: true
  end
end
