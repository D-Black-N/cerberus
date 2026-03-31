# frozen_string_literal: true

RSpec.describe Cerberus::Domain::Policy do
  subject { described_class.new(rules:, strategy:).evaluate({}) }

  let(:action) { 'test' }
  let(:entity) { 'Object' }
  let(:rules) { [] }
  let(:strategy) { :permit_overrides }

  before { allow(Cerberus::Domain::Strategies::PermitOverrides).to receive(:combine).and_return(:permit) }

  it { is_expected.to be :permit }
end
