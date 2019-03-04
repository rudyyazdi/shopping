RSpec.describe Item do
  subject { described_class.new(:ipd) }

  describe "#name" do
    it { is_expected.to have_attributes(name: 'Super iPad') }
  end

  describe "#==" do
    it "is equal to another ipad instance" do
      expect(subject).to eq(described_class.new(:ipd))
    end

    it "is not equal to macbook pro" do
      expect(subject).not_to eq(described_class.new(:mbp))
    end
  end

  describe "#accounted_for" do
    it "can be marked as accounted for" do
      expect(subject).not_to be_accounted_for
      subject.accounted_for!
      expect(subject).to be_accounted_for
    end
  end
end
