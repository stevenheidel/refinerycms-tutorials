xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    # Required to pass W3C validation.
    xml.atom :link, nil, {
      :href => tutorials_url(:format => 'rss'),
      :rel => 'self', :type => 'application/rss+xml'
    }

    # Feed basics.
    xml.title             page_title
    xml.description       @page[:body].to_s.gsub(/<\/?[^>]*>/, "") # .to_s protects from nil errors
    xml.link              tutorials_url(:format => 'rss')

    # News items.
    @tutorials.each do |tutorial|
      xml.item do
        xml.title         tutorial.title
        xml.link          tutorial_url(tutorial)
        xml.description   truncate(tutorial.content, :length => 200, :preserve_html_tags => true)
        xml.pubDate       tutorial.updated_at.to_s(:rfc822)
        xml.guid          tutorial_url(tutorial)
      end
    end
  end
end