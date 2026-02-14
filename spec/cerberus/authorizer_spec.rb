# frozen_string_literal: true

RSpec.describe Cerberus::Authorizer do
  let(:authorizer) { described_class.new(resolver:) }
  let(:resolver) { double("Resolver") }
  let(:action) { "test" }
  let(:subject_data) { { id: 1, name: "test" } }
  let(:resource) { { id: 1, name: "test" } }
  let(:env) { { id: 1, name: "new" } }
  let(:policy) { instance_double(Cerberus::Policy) }

  before { allow(resolver).to receive(:execute).with(action).and_return(policy) }

  describe "#authorize!" do
    subject { authorizer.authorize!(action:, subject: subject_data, resource:, env:) }

    context "when policy exist" do
      before do
        allow(policy).to receive(:evaluate).with(subject: subject_data, resource:, env:).and_return(result)
      end

      context "when permit" do
        let(:result) { :permit }

        it { is_expected.to be_truthy }
      end

      context "when deny" do
        let(:result) { :deny }

        it { expect { subject }.to raise_error Cerberus::NotAuthorized }
      end

      context "when not applicable" do
        let(:result) { nil }

        it { expect { subject }.to raise_error Cerberus::NotAuthorized }
      end
    end

    context "when policy blank" do
      let(:policy) { nil }

      it { expect { subject }.to raise_error Cerberus::NotAuthorized }
    end
  end

  describe "#authorize" do
    subject { authorizer.authorize(action:, subject: subject_data, resource:, env:) }

    context "when policy exist" do
      before do
        allow(policy).to receive(:evaluate).with(subject: subject_data, resource:, env:).and_return(result)
      end

      context "when permit" do
        let(:result) { :permit }

        it { is_expected.to be_truthy }
      end

      context "when deny" do
        let(:result) { :deny }

        it { is_expected.to be_falsey }
      end

      context "when not applicable" do
        let(:result) { nil }

        it { is_expected.to be_falsey }
      end
    end

    context "when policy blank" do
      let(:policy) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
