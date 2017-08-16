require 'mechanize'
module Proxy
  class Common
    def self.start_proxy_reptile
      t1 = Thread.new{GetHaoProxy.main}  
      t2 = Thread.new{GetXiciProxy.main} 
      t3 = Thread.new{GetMimiProxy.main} 
      t4 = Thread.new{GetsweiProxy.main}
      t1.join
      t2.join
      t3.join
      t4.join
    end

    def self.save(ip,post,source,time_consuming)
      ip_post = GetProxy.new(ip: ip,post: post,source:source ,time_consuming: time_consuming)
      ip_post.save
    end

    def self.html(url,flag = false,ip= nil,post =nil)
      begin
        agent = Mechanize.new
        # 设置超时
        if flag 
          agent.set_proxy ip,post
        end
        agent.open_timeout = 10
        agent.user_agent_alias = 'Mac Safari'
        html = agent.get(url)
        return html
      rescue Exception=> e
        return false
      end
    end

    #验证代理是否超时
    #可以用的true
    #不能用的false
    def self.time_out?(ip,post)
      puts "验证代理是否超时#{ip}:#{post}"
      begin
        agent = Mechanize.new
        agent.set_proxy ip,post
        agent.open_timeout = 3
        agent.get('https://www.baidu.com')
        return true
      rescue Exception => e
        return false
      end
    end

    def self.delete(ip,port)
      GetProxy.delete_all("ip = '#{ip}' and post = #{port}")
    end

    def self.proxy_queue(proxy_queue,number,key)
      key = key.to_sym
      @mutex = Mutex.new
      @mutex.lock
      data = GetProxy.order(key).limit(number)
      @mutex.unlock
      data.each do |proxy|
        ip = proxy.ip
        post = proxy.post
        ip_post = ip+":"+post.to_s
        @mutex.lock
        proxy_queue<<ip_post
        @mutex.unlock
      end
      return proxy_queue
    end

    ##根据验证时的耗时排序，取出前10个，随机返回
    def self.random_proxy(source)
      proxy_list = Array.new
      sql = ''
      if source
        sql = GetProxy.where.not(:source=>source ).order(:updated_at).limit(10)
      end
      sql.each do |proxy|
        ip = proxy.ip
        post = proxy.post
        ip_post = ip+":"+post.to_s
        proxy_list<<ip_post
      end
      n = rand(1...10)
      proxy_list[n]
    end

  end
end