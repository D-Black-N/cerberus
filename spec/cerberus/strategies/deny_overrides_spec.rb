# frozen_string_literal: true

RSpec.describe Cerberus::Strategies::DenyOverrides do
  subject { described_class.new.combine(rules, {}) }

  let(:rules) do
    [
      instance_double(Cerberus::Rule, evaluate: first_rule),
      instance_double(Cerberus::Rule, evaluate: second_rule)
    ]
  end

  context "when deny" do
    let(:first_rule) { :permit }
    let(:second_rule) { :deny }

    it { is_expected.to be :deny }
  end

  context "when permit" do
    let(:first_rule) { nil }
    let(:second_rule) { :permit }

    it { is_expected.to be :permit }
  end

  context "when not applicable" do
    let(:first_rule) { nil }
    let(:second_rule) { nil }

    it { is_expected.to be_nil }
  end
end
