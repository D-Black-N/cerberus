# frozen_string_literal: true

RSpec.describe Cerberus::Application::Authorizer do
  let(:authorizer) { described_class.new(resolver:) }
  let(:resolver) { double('Resolver') }
  let(:action) { 'test' }
  let(:resource_type) { 'test' }
  let(:subject_data) { { id: 1, name: 'test' } }
  let(:resource) { { id: 1, name: 'test' } }
  let(:env) { { id: 1, name: 'new' } }
  let(:policy) { instance_double(Cerberus::Domain::Policy) }

  before { allow(resolver).to receive(:resolve).with(action:, resource_type:).and_return(policy) }

  describe '#authorize!' do
    subject { authorizer.authorize!(action:, resource_type:, subject: subject_data, resource:, env:) }

    context 'when policy exist' do
      before do
        allow(policy).to receive(:evaluate).with(subject: subject_data, resource:, env:).and_return(result)
      end

      context 'when permit' do
        let(:result) { :permit }

        it { is_expected.to be_truthy }
      end

      context 'when deny' do
        let(:result) { :deny }

        it { expect { subject }.to raise_error Cerberus::NotAuthorized }
      end

      context 'when not applicable' do
        let(:result) { nil }

        it { expect { subject }.to raise_error Cerberus::NotAuthorized }
      end
    end

    context 'when policy blank' do
      let(:policy) { nil }

      it { expect { subject }.to raise_error Cerberus::NotAuthorized }
    end
  end

  describe '#authorized?' do
    subject { authorizer.authorized?(action:, resource_type:, subject: subject_data, resource:, env:) }

    context 'when policy exist' do
      before do
        allow(policy).to receive(:evaluate).with(subject: subject_data, resource:, env:).and_return(result)
      end

      context 'when permit' do
        let(:result) { :permit }

        it { is_expected.to be_truthy }
      end

      context 'when deny' do
        let(:result) { :deny }

        it { is_expected.to be_falsey }
      end

      context 'when not applicable' do
        let(:result) { nil }

        it { is_expected.to be_falsey }
      end
    end

    context 'when policy blank' do
      let(:policy) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
