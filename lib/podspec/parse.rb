# Parse GitHub repository into spec values
module Podspec
  class << self
    require 'github-readme'

    SOURCE_FILES = [
      'Sources'
    ]

    def tag(name)
      name.gsub(/[A-z]/, '').gsub('-','')
    end

    def ver(t)
      return t if t=='TODO'

      t.gsub(/[a-zA-Z]/, '')
    end

    def parse(repo)
      puts "Generating Podspec for #{repo}..."

      begin
        c = Octokit
      rescue => e
        return {
          'error' => e
        }
      end

      begin
        r = c.repo(repo, :accept => 'application/vnd.github.drax-preview+json')

        lang = r['language']
        unless (lang == 'Swift') || (lang == 'Objective-C')
          return {
            'error' => "#{lang} is not supported"
          }
        end

        name = r['name']
        summary = r['description']

        begin
          license = r['license']['name']
        rescue
          license = nil
        end

        begin
          tags = c.tags(repo)
        rescue => e
          return {
            'error' => e
          }
        end

        if c.tags(repo).count > 0
          t = tags.sort do |a,b|
            v1 = tag a['name']
            v2 = tag b['name']
            Gem::Version.new(v2) <=> Gem::Version.new(v1)
          end[0]

          tag = t['name']
        else
          tag = 'TODO'
        end

        version = ver(tag)

        contents = c.contents repo
        folders = contents.select { |x| x['type']=='dir'}.map { |f| f['name'] }

        source_files = SOURCE_FILES
        source_files.push name
        intersect = source_files & folders
        source_folder = intersect.count == 0 ? nil : intersect[0]

        warnings = []
        warnings.push 'No sources found' if source_folder.nil?

        contents.select { |x| x['type']=='file'}
        .map { |f| f['name'] }
        .each do |x|
          warnings.push "A Podspec already exists for #{repo}" if x.include? 'podspec'
        end

        html_url = r['html_url']
        homepage = r['homepage']

        username = r['owner']['login']
        u = c.user username
        author = u['name']

        git = r['git_url']

        r = GitHubReadme::get repo
        if r['error'].nil?
          readme = r['readme']
          description = r['summary']
        else
          readme = nil
          description = nil
        end

        return {
          'error' => nil,
          'name' => name,
          'summary' => summary,
          'description' => description,
          'license' => license,
          'git' => git,
          'tag' => tag,
          'version' => version,
          'author' => author,
          'source_folder' => source_folder,
          'html_url' => html_url,
          'homepage' => homepage,
          'readme' => readme,
          'warnings' => warnings
        }
      rescue => e
        return {
          'error' => e
        }
      end
    end

  end # class
end # module
