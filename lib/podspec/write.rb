# Write Podspec file
module Podspec
  class << self
    DESC = "# s.description  = \"A description of the Pod more detailed than the summary.\""
    IOS = '8.0'

    def write_podspec(s)
      name = s['name']

      homepage = s['homepage ']
      homepage = s['html_url'] if homepage.nil?

      git = s['git'].sub('git://', 'https://')

      description = DESC

      summary = "\"#{s['summary']}\""

      d = s['description']

      if d.nil?
        description = DESC
      else
        description =
          if d == summary.gsub('"', '')
            DESC
          else
            "s.description  = \"#{d}\""
          end
      end

      source_files = "#{s['source_folder']}/*.{h,m,swift}"

      spec =
%{Pod::Spec.new do |s|
  s.name         = "#{name}"
  s.version      = "#{s['version']}"
  s.summary      = #{summary}
  #{description}

  s.homepage     = "#{homepage}"

  s.license      = "#{s['license']}"

  s.author       = "#{s['author']}"

  s.source       = { :git => "#{git}", :tag => "#{s['tag']}" }

  s.source_files = "#{source_files}"

  s.ios.deployment_target = "#{IOS}"
  # s.osx.deployment_target = "10.9"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
end
}

      filename = "#{name}.podspec"
      File.open(filename, 'w') { |f| f.write(spec) }

      return filename
    end

  end
end
