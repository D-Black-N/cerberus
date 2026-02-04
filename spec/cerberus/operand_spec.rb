# frozen_string_literal: true

RSpec.describe Cerberus::Operand do
  subject(:resolve) { described_class.new(kind:, name:, value:, value_type:).resolve(context) }

  let(:context) { {} }

  context "with literal value" do
    let(:kind) { "constant" }
    let(:name) { nil }
    let(:value) { "42" }
    let(:value_type) { "integer" }

    it "returns casted literal" do
      is_expected.to eq(42)
    end
  end

  context "with context" do
    let(:kind) { "subject" }
    let(:name) { "role" }
    let(:value) { nil }
    let(:value_type) { nil }

    context "when context values are hashes" do
      let(:context) { { subject: { role: "admin" } } }

      it { is_expected.to eq("admin") }

      context "with nested attributes" do
        let(:kind) { "subject" }
        let(:name) { "data.role" }
        let(:context) { { subject: { data: { role: "admin" } } } }

        it { is_expected.to eq("admin") }
      end
    end

    context "when context values are objects" do
      let(:object) { Struct.new(:role) }
      let(:context) { { subject: object.new(role: "admin") } }

      it { is_expected.to eq("admin") }

      context "with nested attributes" do
        let(:kind) { "subject" }
        let(:name) { "data.role" }
        let(:object) { Struct.new(:data) }
        let(:nested_object) { Struct.new(:role) }
        let(:context) { { subject: object.new(data: nested_object.new(role: "admin")) } }

        it { is_expected.to eq("admin") }
      end
    end

    context "when value does not exist" do
      let(:context) { { subject: { role: "admin" } } }
      let(:name) { "test" }

      it "raised error" do
        expect { resolve }.to raise_error(KeyError)
      end

      context "with object" do
        let(:object) { Struct.new(:role) }
        let(:context) { { subject: object.new(role: "admin") } }
        let(:name) { "test" }

        it "raised error" do
          expect { resolve }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
