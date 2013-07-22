class JSTagger
    constructor: (@fieldId) ->
        @setupField()

    getFieldById: ->
        @tagField = document.getElementById(@fieldId)

    fieldAddListener: ->
        self = @
        if @fakeInput.addEventListener
            @fakeInput.addEventListener('keypress', (e) ->
                self.fakeInputKeyPressed(e)
            , false);
            @wrapper.addEventListener('click', (e) ->
                self.wrapperClicked(e)
            , false);
        else if @fakeInput.attachEvent
            @fakeInput.attachEvent('keypress', (e) ->
                self.fakeInputKeyPressed(e)
            );
            @fakeInput.attachEvent('click', (e) ->
                self.wrapperClicked(e)
            );

    fieldWrap: ->
        @createWrapper()
        @tagField.parentNode.insertBefore(@wrapper, @tagField)
        @tagField.parentNode.removeChild(@tagField)
        @wrapper.appendChild(@tagField)

    createWrapper: ->
        @wrapper = document.createElement('div')
        @wrapper.id = @fieldId+"_wrapper"
        @wrapper.className = "jstagger_wrapper"

    createTagArea: ->
        @tagArea = document.createElement('span')
        @tagArea.id = @fieldId+"_tag_area"
        @wrapper.insertBefore(@tagArea, @tagField)
    
    createCloseBtn: ->
        @closeBtn = document.createElement('img')
        @closeBtn.src = "img/blank.gif"
        @closeBtn.className = "jstagger_close_btn"

    createFakeInput: ->
        @fakeInput = document.createElement('input')
        @fakeInput.id = @fieldId+"_fake_input"
        @fakeInput.className = "jstagger_fake_input"
        @wrapper.insertBefore(@fakeInput, @tagField)

    setupField: ->
        @getFieldById()
        @fieldWrap()
        @createTagArea()
        @createCloseBtn()
        @createFakeInput()
        @fieldAddListener()
        @tagField.style.display = "none"

    trimTag: (str)->
        str.replace /^\s+|\s+$/g, ''
        
    populateTagField: ->
        tagNames = []
        for tag in @tagArea.children
            tagNames.push(tag.innerText)
            
        @tagField.value = tagNames.join(", ")


    #Events
    fakeInputKeyPressed: (e) ->
        if e.keyCode == 44
            e.stopPropagation()
            e.preventDefault()
            tagStr = @trimTag @fakeInput.value
            @fakeInput.value = ""
            tagSpan = document.createElement 'span'
            tagSpan.className = "jstagger_tag"
            tagSpan.innerText = tagStr
            tagSpan.appendChild @closeBtn.cloneNode()
            @tagArea.appendChild tagSpan
            @tagField.value += (if @tagField.value == "" then "" else ", ") + tagStr
            @fakeInput.focus()

    wrapperClicked: (e) ->
        e.stopPropagation()
        e.preventDefault()
        console.log(e.target)
        if e.target.tagName == "SPAN" && e.target.className.indexOf("jstagger_tag") >= 0
            console.log('span clicked')
            @fakeInput.value = e.target.innerText
            e.target.remove()
        
        if e.target.tagName == "IMG" && e.target.className.indexOf("jstagger_close_btn") >= 0
            console.log('span clicked')
            e.target.parentNode.remove()
        
        @populateTagField()
        @fakeInput.focus()
        






