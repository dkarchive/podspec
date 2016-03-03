require 'podspec'

describe Podspec do
  describe "escape" do
    context "given text with \"" do
      value = Podspec::escape 'BSD 2-clause "Simplified" License'
      expected = 'BSD 2-clause \"Simplified\" License'
      it "\" is escaped" do
        expect(value).to eql(expected)
      end
    end
  end

  describe "description" do
    context "given the same summary and description" do
      value = Podspec::description 's', 's'
      expected = '# s.description  = "A description of the Pod more detailed than the summary."'
      it "description is commented out" do
        expect(value).to eql(expected)
      end
    end

    context "given different summary and description" do
      value = Podspec::description 'desc', 't'
      expected = 's.description  = "desc"'
      it "description is set" do
        expect(value).to eql(expected)
      end
    end
  end

  describe "homepage" do
    context "given homepage" do
      expected = 'https://podspec.io'
      hash = {
        'homepage' => expected,
        'html_url' => 'https://github.com/dkhamsing/podspec'
      }
      value = Podspec::homepage hash
      it "homepage is set" do
        expect(value).to eql(expected)
      end
    end

    context "given nil homepage" do
      expected = 'https://github.com/dkhamsing/podspec'
      hash = {
        'homepage' => nil,
        'html_url' => expected
      }
      value = Podspec::homepage hash
      it "html_url is set" do
        expect(value).to eql(expected)
      end
    end

    context "given empty homepage" do
      expected = 'https://github.com/dkhamsing/podspec'
      hash = {
        'homepage' => '',
        'html_url' => expected
      }
      value = Podspec::homepage hash
      it "html_url is set" do
        expect(value).to eql(expected)
      end
    end
  end

  describe "source files" do
    context "given source files hash" do
      # folder = 'Source'
      hash = { 'source_folder' => 'Source' }
      value = Podspec::source_files hash
      expected = "#{hash['source_folder']}/*.{h,m,swift}"
      it "source_files gets formatted" do
        expect(value).to eql(expected)
      end
    end
  end
end
