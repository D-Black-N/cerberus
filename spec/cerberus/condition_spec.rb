# frozen_string_literal: true

RSpec.describe Cerberus::Condition do
  subject(:evaluate) { described_class.new(left:, right:, operator:).evaluate({}) }

  let(:left) { instance_double(Cerberus::Operand, resolve: left_value) }
  let(:right) { instance_double(Cerberus::Operand, resolve: right_value) }

  context "when compared success" do
    let(:operator) { "==" }

    context "when result true" do
      let(:left_value) { "string" }
      let(:right_value) { "string" }

      it { is_expected.to be_truthy }
    end

    context "when result false" do
      let(:left_value) { "string" }
      let(:right_value) { "test" }

      it { is_expected.to be_falsey }
    end
  end

  context "when compare raised error" do
    let(:left_value) { nil }
    let(:right_value) { "string" }
    let(:operator) { ">" }

    it { expect { evaluate }.to raise_error(NoMethodError) }
  end
end
