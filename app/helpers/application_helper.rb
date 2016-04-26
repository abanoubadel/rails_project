module ApplicationHelper
  def header(text)
    content_for(:header) { text.to_s }
  end


  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Yalantlop App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end




