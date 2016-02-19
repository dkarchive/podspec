# Parse GitHub repository into spec values
module Podspec
  class << self
    require 'octokit'
    require 'netrc'

    SOURCE_FILES = [
      'Sources'
    ]

    def parse(repo)
      puts "Generating Podspec for #{repo}..."

      begin
        c = Octokit::Client.new(netrc: true)
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
          t = c.tags(repo)[0]
        rescue => e
          return {
            'error' => e
          }
        end

        return {
          'error' => 'No tags'
        } if c.tags(repo).count == 0

        begin
          license = r['license']['name']
        rescue
          license = nil
        end

        begin
          tag = t['name']
          version = tag.gsub(/[a-zA-Z]/, '')
        rescue
          tag = nil
          version = nil;
        end

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

        begin
          re = c.readme repo
          content = re['content']
          readme = Base64.decode64 content unless content.nil?
        rescue => e
          readme = nil
        end

        return {
          'error' => nil,
          'name' => name,
          'summary' => summary,
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
