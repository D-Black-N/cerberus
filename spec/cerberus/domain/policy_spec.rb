# frozen_string_literal: true

RSpec.describe Cerberus::Domain::Policy do
  subject { described_class.new(rules:, strategy:).evaluate({}) }

  let(:action) { "test" }
  let(:entity) { "Object" }
  let(:rules) { [] }
  let(:strategy) { class_double(Cerberus::Domain::Strategies::PermitOverrides, combine: :permit) }

  it { is_expected.to be :permit }
end
