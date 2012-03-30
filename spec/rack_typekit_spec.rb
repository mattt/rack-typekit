require "minitest/autorun"
require "minitest/pride"
require "rack"
require "rack/lint"
require "rack/mock"
require "rack/typekit"

describe Rack::Typekit do
  let(:html_file) do
    File.read(File.expand_path("../fixtures/test.html", __FILE__))
  end
  let(:html_app)     { proc{[200,{"Content-Type"=>"text/html"},[html_file]]} }
  let(:text_app)     { proc{[200,{"Content-Type"=>"text/plain"},["FOO"]]} }
  let(:typekit_html) { Rack::Typekit.new(html_app, :kit => "123") }
  let(:typekit_text) { Rack::Typekit.new(text_app, :kit => "123") }

  it { proc{ Rack::Typekit.new(nil) }.must_raise(ArgumentError) }

  it { typekit_html.must_be_kind_of(Rack::Typekit) }
  it { typekit_text.must_be_kind_of(Rack::Typekit) }

  describe "script injection" do
    describe "html" do
      let(:request)  { Rack::MockRequest.new(Rack::Lint.new(typekit_html)) }
      let(:response) { request.get("/") }

      it { response.status.must_equal 200 }
      it { response.body.must_match %(src="http://use.typekit.com/123.js") }
      it { response.body.must_match "try{Typekit.load();}catch(e){}" }
      it { response.body.must_match "<title>Rack::Typekit Test</title>" }
      it { response.body.must_match "<p>Test file.</p>" }
    end

    describe "text" do
      let(:request)  { Rack::MockRequest.new(Rack::Lint.new(typekit_text)) }
      let(:response) { request.get("/") }

      it { response.status.must_equal 200 }
      it { response.body.wont_match %(src="http://use.typekit.com/123.js") }
      it { response.body.wont_match "try{Typekit.load();}catch(e){}" }
      it { response.body.must_match "FOO" }
    end
  end
end
