# frozen_string_literal: true

RSpec.describe Cerberus::Types do
  subject { described_class.cast(value, type) }

  context "with string" do
    let(:value) { "test" }
    let(:type) { "string" }

    it { is_expected.to eq("test") }
  end

  context "with integer" do
    let(:value) { "123" }
    let(:type) { "integer" }

    it { is_expected.to eq(123) }
  end

  context "with float" do
    let(:value) { "1.23" }
    let(:type) { "float" }

    it { is_expected.to eq(1.23) }
  end

  context "with boolean" do
    let(:type) { "boolean" }

    context "when value is 'true'" do
      let(:value) { "true" }
      it { is_expected.to be true }
    end

    context "when value is 'false'" do
      let(:value) { "false" }
      it { is_expected.to be false }
    end
  end

  context "with nil" do
    let(:value) { "anything" }
    let(:type) { "nil" }

    it { is_expected.to be_nil }
  end

  context "with time" do
    let(:type) { "time" }
    let(:value) { "2024-01-01 12:34:56" }

    it "returns a Time object" do
      expect(subject).to be_a(Time)
      expect(subject).to eq(Time.parse("2024-01-01 12:34:56"))
    end
  end

  context "with date" do
    let(:type) { "date" }
    let(:value) { "2024-01-01" }

    it "returns a Date object" do
      expect(subject).to be_a(Date)
      expect(subject).to eq(Date.parse("2024-01-01"))
    end
  end

  context "with datetime" do
    let(:type) { "datetime" }
    let(:value) { "2024-01-01T12:34:56" }

    it "returns a DateTime object" do
      expect(subject).to be_a(DateTime)
      expect(subject).to eq(DateTime.parse("2024-01-01T12:34:56"))
    end
  end

  context "with json" do
    let(:type) { "json" }
    let(:value) { '{"key":42}' }

    it "parses json string into a hash" do
      expect(subject).to eq({ "key" => 42 })
    end
  end
end
