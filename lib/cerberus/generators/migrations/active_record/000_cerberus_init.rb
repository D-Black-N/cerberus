# frozen_string_literal: true

class InitCerberusMigration < ActiveRecord::Migration
  create_table :cerberus_policies do |t|
    t.string :action, null: false
    t.string :resource_type, null: false
    t.string :strategy, null: false

    t.timestamp
  end

  add_index :cerberus_policies, %i[action resource_type], unique: true, name: 'index_cerberus_policies_uniqueness'

  create_table :cerberus_rules do |t|
    t.string :effect, null: false

    t.timestamps
  end

  create_table :cerberus_policy_rules do |t|
    t.belongs_to :policy, foreign_key: { to_table: :cerberus_policies }
    t.belongs_to :rule, foreign_key: { to_table: :cerberus_rules }

    t.timestamps
  end

  create_table :cerberus_operands do |t|
    t.string :kind, null: false,
    t.string :value
    t.string :name
    t.string :value_type

    t.timestamps
  end

  create_table :cerberus_expressions do |t|
    t.string :type, null: false
    t.string :operator, null: false
    t.belongs_to :rule, foreign_key: { to_table: :cerberus_rules }
    t.belongs_to :parent, foreign_key: { to_table: :cerberus_expressions }
    t.belongs_to :left_operand, foreign_key: { to_table: :cerberus_operands }
    t.belongs_to :right_operand, foreign_key: { to_table: :cerberus_operands }

    t.timestamps
  end
end
