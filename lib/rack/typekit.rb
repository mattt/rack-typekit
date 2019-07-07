module Rack #:nodoc:
  class Typekit

    VERSION = "0.3.0"

    def initialize(app, options = {})
      raise ArgumentError, "Typekit Kit ID Required" unless options[:kit] &&
        !options[:kit].empty?
      @app, @options = app, options
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
      return [@status, @headers, @response] unless html?
      response = Rack::Response.new([], @status, @headers)
      if @response.respond_to?(:to_ary)
        @response.each { |fragment| response.write inject_typekit(fragment) }
      end
      response.finish
    end

    private

    def html?; @headers["Content-Type"] =~ /html/; end

    def inject_typekit(response)
      script = <<-EOF
<script src="//use.typekit.com/#{@options[:kit]}.js"></script>
<script>try{Typekit.load();}catch(e){}</script>
      EOF

      response.gsub(%r{</head>}, script + "</head>")
    end
  end
end
