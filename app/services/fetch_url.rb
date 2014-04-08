# encoding: UTF-8

require 'nokogiri'
require 'open-uri'

class FetchUrl
  def initialize(url)
    domain = URI.parse(url).host
    case domain
    when /.pixnet.net/
      @result = pixnet_regular(url)
    else
      @result = {}
    end
  end

  def get_result
    @result
  end

  private
    def get_address(gb_word)
      address = []

      first_key_word = '地址'
      last_key_word = '號'

      while gb_word.size > 0
        if gb_word.index(first_key_word)
          gb_word = gb_word[gb_word.index(first_key_word)..gb_word.size]

          if gb_word.index(last_key_word)
            if gb_word[0..gb_word.index(last_key_word)][2] == ':' || gb_word[0..gb_word.index(last_key_word)][2] == '：'
              address.push gb_word[3..gb_word.index(last_key_word)]
            else
              address.push gb_word[2..gb_word.index(last_key_word)]
            end
            gb_word = gb_word[gb_word.index(last_key_word)..gb_word.size]
          else
            break
          end
        else
            break
        end
      end
      address
    end

    def get_telephone(gb_word)
      telephone = []

      # '07-123-1234',
      # '07-1231234',
      # '(07)123-1234',
      # '(07) 123-1234',
      # '(07) 1231234'

      # /0\d{1,2}-\d{6,8}/
      # /0\d{1,2}-\d{3,4}-\d{4}/
      # /\(0\d{1,2}\)\s{0,1}\d{3,4}-\d{4}/
      # /\(0\d{1,2}\)\s{0,1}\d{7,8}/
      # /（0\d{1,2}）\s{0,1}\d{3,4}-\d{4}/
      # /（0\d{1,2}）\s{0,1}\d{7,8}/

      gb_word.scan(/0\d{1,2}-\d{6,8}|0\d{1,2}-\d{3,4}-\d{4}|\(0\d{1,2}\)\s{0,1}\d{3,4}-\d{4}|\(0\d{1,2}\)\s{0,1}\d{7,8}|（0\d{1,2}）\s{0,1}\d{3,4}-\d{4}|（0\d{1,2}）\s{0,1}\d{7,8}/) do |telephone_number|
        # telephone_number.tr!('（(','').tr!('）)','-')
        telephone_number.tr!('（(','')
        telephone_number.tr!('）)','-')
        telephone.push telephone_number
      end
      telephone
    end

    def pixnet_regular(url)
      key_word = {address: '地址', telephone: '電話'}

      doc = Nokogiri::HTML(open(url))
      @title  = doc.css('.article-head h2 a').text
      @name  = doc.css('.article-head h2 a').text
      @img    = doc.css('.article-content-inner img')
      article = doc.css('.article-content-inner p').map(&:text)
      address = telephone = []

      article.each do |ptag|
        key_word.each do |key, kw|
          if ptag.index(kw)
            case key
            when :address
              @address = get_address(ptag)
            when :telephone
              @telephone = get_telephone(ptag)
            end
          end
        end
      end

      return {name: @name, address: @address, telephone: @telephone, img: @img}
    end

end
