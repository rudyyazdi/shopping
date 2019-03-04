RSpec.describe Item do
  subject { described_class.new(:ipd) }

  describe "#name" do
    it { is_expected.to have_attributes(name: 'Super iPad') }
  end

  describe "#accounted_for" do
    it "can be marked as accounted for" do
      expect(subject).not_to be_accounted_for
      subject.accounted_for!
      expect(subject).to be_accounted_for
    end
  end
end
