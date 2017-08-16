module Proxy
  class GetHaoProxy
    def self.main 
      n = 0
      url = "http://www.kuaidaili.com/free/inha/"
      while true
        n+=1
        parse_ip(url+n.to_s+'/')
        if n ==4
          n=0
        end
      end 
    end
    def self.parse_ip(url)
      html = Common.html(url)
      while !html
        ip_post = Common.random_proxy("秘密代理").split(":")
        html = Common.html(url,true,ip_post[0],ip_post[1].to_i)
      end
      html.xpath('//table[@class = "table table-bordered table-striped"]/tbody/tr').each do |tr|
        i  = 0
        ip = ''
        post = ''
        tr.xpath('td').each do |td| 
          i+=1
          str  =  td.content
          case i
          when 1
            ip = str
          when 2
            post = str.to_i
          else
            next
          end
        end 
        #将能用的代理存入数组
        now_time = Time.new
        if Common.time_out?(ip,post)
          time_consuming = Time.new - now_time
          source = "好代理"
          Common.save(ip,post,source,time_consuming)
        end
      end
    end 
  end
end