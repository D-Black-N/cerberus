# frozen_string_literal: true

RSpec.describe Cerberus::Policy do
  subject { described_class.new(action:, entity:, rules:, strategy:).evaluate({}) }

  let(:action) { "test" }
  let(:entity) { "Object" }
  let(:rules) { [] }
  let(:strategy) { instance_double(Cerberus::Strategies::PermitOverrides, combine: :permit) }

  it { is_expected.to be :permit }
end
