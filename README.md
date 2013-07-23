js-tagger
=========

Small pure javascript to transform a input field into a tag field


include the javascript:

    <script src=js/js-tagger.js></script>
    
have and input:

    <input id="my_tag_field" value="test, test2" />
    
Activate the plugin:

    <script>
        tagger = new JSTagger("my_tag_field");
    </script>
    
Now your your input should be a tag field with each tags in a box:

<exemple.png>
![Exemple of the render](exemple.png)


CSS given with this package should be rewriten to match your website style
