module Rack #:nodoc:
  class Typekit

    VERSION = "0.1.0"

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
        @response.each { |fragment| response.write inject(fragment) }
      end
      response.finish
    end

    private

    def html?; @headers["Content-Type"] =~ /html/; end

    def inject(response)
      script = <<-EOF
<script type="text/javascript" src="http://use.typekit.com/#{@options[:kit]}.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
      EOF

      response.gsub(%r{</head>}, script + "</head>")
    end
  end
end
