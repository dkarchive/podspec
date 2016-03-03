# Create spec
module Podspec
  class << self

    DESC = "# s.description  = \"A description of the Pod more detailed than the summary.\""
    IOS = '8.0'
    OSX = '10.9'
    WATCHOS = '2.0'
    TVOS = '9.0'

    def description(d, s)
      description = DESC

      if d.nil?
        description = DESC
      else
        description =
          if d == s
            DESC
          else
            "s.description  = \"#{d}\""
          end
      end

      description
    end

    def escape(s)
      return '' if s.nil?
      s.gsub('"', '\"')
    end

    def format(options)
      name = options['name']
      version = options['version']
      summary = options['summary']
      description = options['description']
      homepage = options['homepage']
      license = options['license']
      author = options['author']
      source = options['source']
      source_files = options['source_files']
      ios = options['ios']
      osx = options['osx']
      watchos = options['watchos']
      tvos = options['tvos']

      %{Pod::Spec.new do |s|
        s.name         = "#{name}"
        s.version      = "#{version}"
        s.summary      = "#{summary}"
        #{description}

        s.homepage     = "#{homepage}"

        s.license      = "#{license}"

        s.author       = "#{author}"

        s.source       = #{source}

        s.source_files = "#{source_files}"

        s.ios.deployment_target = "#{ios}"
        # s.osx.deployment_target = "#{osx}"
        # s.watchos.deployment_target = "#{watchos}"
        # s.tvos.deployment_target = "#{tvos}"
      end
      }
    end

    def homepage(s)
      homepage = s['homepage']
      homepage = s['html_url'] if homepage.nil? || homepage==''
      homepage
    end

    def source_files(s)
      "#{s['source_folder']}/*.{h,m,swift}"
    end

    def make_options(s)
      homepage = homepage s

      git = s['git'].sub('git://', 'https://')

      license = escape s['license']

      source_files = source_files s

      summary = s['summary']

      {
        'name' => s['name'],
        'version' => s['version'],
        'summary' => summary,
        'description' => description(s['description'], summary),
        'homepage' => homepage,
        'license' => escape(s['license']),
        'author' => s['author'],
        'source' => "{ :git => \"#{git}\", :tag => \"#{s['tag']}\" }",
        'source_files' => source_files,
        'ios' => IOS,
        'osx' => OSX,
        'watchos' => WATCHOS,
        'tvos' => TVOS
      }
    end

    def create_spec(s)
      options = make_options s
      format options
    end

  end # class
end
