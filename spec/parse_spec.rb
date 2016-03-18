require 'podspec'

describe Podspec do
  describe "parse" do
    context "given a tag with alpha" do
      value = Podspec::tag 'v1.2'
      expected = '1.2'
      it "alpha is escaped" do
        expect(value).to eql(expected)
      end
    end

    context "given a tag with alpha and -" do
      value = Podspec::tag 'docs-1.2'
      expected = '1.2'
      it "alpha and - are escaped" do
        expect(value).to eql(expected)
      end
    end

    context "given a tag with -" do
      value = Podspec::tag '-1.2-'
      expected = '1.2'
      it "- is escaped" do
        expect(value).to eql(expected)
      end
    end
  end
end
