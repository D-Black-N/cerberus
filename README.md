# Cerberus

Cerberus is a rule engine for Ruby applications inspired by the XACML (eXtensible Access Control Markup Language) standard.

👉 Learn more about XACML: https://en.wikipedia.org/wiki/XACML

It provides a structured way to define, manage, and evaluate rules and policies in a consistent and scalable manner. It provides a structured way to define, manage, and evaluate rules and policies in a consistent and scalable manner.

While internally it follows a modular architecture with pluggable adapters and dependency injection, its primary goal is to offer a familiar policy-based approach similar to XACML, adapted for Ruby applications.

---

## 📋 Requirements

- Ruby >= 3.1
- Rails >= 7.0 (only for ActiveRecord adapter)
- PostgreSQL (recommended, due to JSONB support)

---

## ✨ Features

* Decoupled domain and infrastructure layers
* Pluggable persistence adapters (ActiveRecord, future: Sequel, etc.)
* Dependency injection via container
* Composable operations (use-cases)
* Flexible rule and expression system

---

## 🚀 Installation

Add this line to your application's Gemfile:

```ruby
gem 'cerberus'
```

And then execute:

```bash
bundle install
```

---

## ⚙️ Configuration

Create an initializer:

```ruby
# config/initializers/cerberus.rb

Cerberus::Base.plugin :active_record
```

---

## 🧱 Database Setup

### Install migrations

#### Create task

```ruby
Cerberus::Generators::Migrations.install!(:active_record, 'path/to/migrations/dir')
```

```bash
bin/rails db:migrate
```

---

### Manual migration example

If you prefer to manage schema manually:

```ruby
class InitCerberusMigration < ActiveRecord::Migration[7.0]
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
    t.string :kind, null: false
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
```

---

## 🧩 Usage

### Create a rule

```ruby
rule = Cerberus::Domain::Rule.create(name: "Test rule")
```

### Add expressions

```ruby
rule.expressions.create!(kind: "equals", payload: { field: "status", value: "active" })
```

---

### Using operations

```ruby
result = Cerberus::Operations::Rules::Create.call(name: "Test")

if result.success?
  rule = result.value!
else
  puts result.failure
end
```

⚠️ Do not use infrastructure models directly in your application. Always go through domain or operations layer.

---

## 🧪 Testing

Example with RSpec:

```ruby
RSpec.describe Cerberus::Domain::Rule do
  it 'creates a rule' do
    expect { described_class.create(name: 'Test') }
      .to change(described_class, :count).by(1)
  end
end
```

---

## 🏗 Architecture

```
cerberus/
  domain/        # Pure business logic
  infra/         # Adapters (ActiveRecord, etc.)
  operations/    # Use cases
  plugins/       # Set up for plugins
```

---

## ⚠️ Important Notes

* Do not depend on `infra` layer directly
* Always use public API (operations, domain interfaces)
* Database schema may evolve — check migrations on upgrade

---

## 🛠 Roadmap

* [ ] Sequel adapter
* [ ] ROM adapter
* [ ] YAML adapter
* [ ] Async evaluation
* [ ] Rule builder DSL

---

## 💡 Example Workflow

```ruby
# seeds
op1 = operand.create!(kind: :resource, name: 'nested.role')
op2 = operand.create!(kind: :subject, name: 'role')

r1 = rule.create!(effect: :permit)
c1 = condition.create!(rule: r1, operator: :eq, left_operand: op1, right_operand: op2)
p = policy.create!(action: :update, resource_type: :vehicle, strategy: :permit_overrides)
p.rules << r1

# usage
Cerberus::Base.authorize!(
  action: :update,
  resource_type: :vehicle,
  subject: Struct.new(:id, :role).new(1, 'admin'),
  resource: Struct.new(:nested).new(Struct.new(:role).new('admin'))
)
```

---

## 📄 License

MIT