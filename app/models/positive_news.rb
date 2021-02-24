# frozen_string_literal: true

class PositiveNews
  URL = 'https://www.positive.news/'

  def scrape_main_article
    Article.create(
      title: main_article.css('a')[1].children.text,
      url: main_article.css('a')[1].attributes['href'].value,
      image_url: main_article.css('img').first.attributes['src'].value,
      type_of_article: 'main'
    )
  end

  def scrape_articles
    articles.each do |article|
      create_article(article, 'normal')
    end
    puts 'Done'
  end

  def scrape_featured_articles
    featured_articles.each do |article|
      create_article(article, 'featured')
    end
    puts 'Done'
  end

  private

  def parsed_page
    @parsed_page ||= Nokogiri::HTML(HTTParty.get(URL))
  end

  def main_article
    parsed_page.css('div.main__article')
  end

  def articles
    parsed_page.css('div.latest__articles').css('.column')
  end

  def featured_articles
    parsed_page.css('div.featured__articles').css('.column')
  end

  def create_article(article, type_of_article)
    Article.create(
      title: article.css('a')[1].children.text,
      url: article.css('a').first.attributes['href'].value,
      image_url: article.css('img').first.attributes['src'].value,
      type_of_article: type_of_article
    )
  end
end
