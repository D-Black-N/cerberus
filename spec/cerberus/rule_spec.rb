# frozen_string_literal: true

RSpec.describe Cerberus::Rule do
  subject { described_class.new(effect:, condition:).evaluate({}) }

  let(:condition) { instance_double(Cerberus::Node, evaluate:) }

  context "when rule applicable" do
    let(:evaluate) { true }

    context "when permit" do
      let(:effect) { :permit }

      it { is_expected.to be effect }
    end

    context "when deny" do
      let(:effect) { :deny }

      it { is_expected.to be effect }
    end
  end

  context "when rule not applicable" do
    let(:evaluate) { false }
    let(:effect) { :permit }

    it { is_expected.to be_nil }
  end
end
