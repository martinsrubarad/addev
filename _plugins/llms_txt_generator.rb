module Jekyll
  class LlmsTxtPage < Page
    def initialize(site, dir, content, title)
      @site = site
      @base = site.source
      @dir = dir
      @name = "llms.txt"

      process(@name)
      self.data = {
        "layout" => nil,
        "sitemap" => false,
      }
      self.content = "# #{title}\n\n#{content}"
    end
  end

  class LlmsTxtGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.pages.select { |p| eligible?(p) }.each do |page|
        llms_page = build_llms_page(site, page)
        site.pages << llms_page
      end
    end

    private

    def eligible?(page)
      return false unless page.ext == ".md"
      return false unless page.data["permalink"]
      return false if page.data["llms"] == false
      return false if page.data["permalink"] == "/404.html"
      true
    end

    def build_llms_page(site, page)
      title = page.data["title"] || "Untitled"
      content = clean_content(page.content)
      content = rewrite_links(content)

      dir = page.data["permalink"].chomp("/")
      LlmsTxtPage.new(site, dir, content, title)
    end

    def clean_content(content)
      text = content
        .gsub(/\{:\s*\.[^}]+\}\s*\n?/, "")       # strip kramdown IAL
        .gsub(/<\/?div[^>]*>\s*\n?/, "")           # strip HTML div tags
        .gsub(/\n{3,}/, "\n\n")                    # collapse excess blank lines
      text.strip
    end

    def rewrite_links(content)
      # Rewrite internal markdown links that use {{ site.baseurl }}
      # [text]({{ site.baseurl }}/path/) -> [text]({{ site.baseurl }}/path/llms.txt)
      content.gsub(
        /(\]\(\{\{\s*site\.baseurl\s*\}\}\/[^)]*?)\/\)/
      ) do
        "#{$1}/llms.txt)"
      end
    end
  end
end
