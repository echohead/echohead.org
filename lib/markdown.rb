require 'redcarpet'
require 'pygment'

module Markdown
  @r = Redcarpet::Markdown.new(
         Redcarpet::Render::HTML,
#         :hard_wrap => true,
         :autolink => true,
         :space_after_headers => true,
         :fenced_code_blocks => true)

  def self.to_html md
    Pygment.colorize(@r.render md)
  end

end
