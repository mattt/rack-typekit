# rack-typekit

Rack middleware to automatically include your Typekit JavaScript files

## Example

```ruby
require "rack/typekit"
  
use Rack::Typekit, :kit => "lng5bpe"
```
  
Including this in the `config.ru` file of your Rack application will automatically inject the corresponding JavaScript into the `<head>` of your HTML:

```html
<script src="//use.typekit.com/lng5bpe.js"></script>
<script>try{Typekit.load();}catch(e){}</script>
```

## License

rack-typekit is available under the MIT license. See the LICENSE file for more info.