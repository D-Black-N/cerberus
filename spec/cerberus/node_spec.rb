# frozen_string_literal: true

RSpec.describe Cerberus::Node do
  subject { described_class.new(operator:, children:).evaluate({}) }

  let(:children) do
    [
      instance_double(Cerberus::Condition, evaluate: first_condition),
      instance_double(Cerberus::Condition, evaluate: second_condition)
    ]
  end

  context "when operator = :and" do
    let(:operator) { :and }

    context "when result true" do
      let(:first_condition) { true }
      let(:second_condition) { true }

      it { is_expected.to be_truthy }
    end

    context "when result false" do
      let(:first_condition) { false }
      let(:second_condition) { true }

      it { is_expected.to be_falsey }
    end
  end

  context "when operator = :or" do
    let(:operator) { :or }

    context "when result true" do
      let(:first_condition) { false }
      let(:second_condition) { true }

      it { is_expected.to be_truthy }
    end

    context "when result false" do
      let(:first_condition) { false }
      let(:second_condition) { false }

      it { is_expected.to be_falsey }
    end
  end

  context "with nested tree" do
    subject { described_class.new(operator:, children:).evaluate({}) }

    let(:operator) { :and }
    let(:children) do
      [
        described_class.new(operator: :or, children: [first_condition, second_condition]),
        described_class.new(operator: :or, children: [third_condition, fourth_condition])
      ]
    end
    let(:first_condition) { instance_double(Cerberus::Condition, evaluate: first_evaluate) }
    let(:second_condition) { instance_double(Cerberus::Condition, evaluate: second_evaluate) }
    let(:third_condition) { instance_double(Cerberus::Condition, evaluate: third_evaluate) }
    let(:fourth_condition) { instance_double(Cerberus::Condition, evaluate: fourth_evaluate) }

    context "when result true" do
      let(:first_evaluate) { true }
      let(:second_evaluate) { false }
      let(:third_evaluate) { true }
      let(:fourth_evaluate) { false }

      it { is_expected.to be_truthy }
    end

    context "when result false" do
      let(:first_evaluate) { true }
      let(:second_evaluate) { false }
      let(:third_evaluate) { false }
      let(:fourth_evaluate) { false }

      it { is_expected.to be_falsey }
    end
  end
end
