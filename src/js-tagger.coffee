class JSTagger
    constructor: (@fieldId) ->
        @setupField()

    getFieldById: ->
        @tagField = document.getElementById(@fieldId)

    fieldAddListener: ->
        if @fakeInput.addEventListener
            self = @
            @fakeInput.addEventListener('keypress', (e) ->
                self.fakeInputKeyPressed(e)
            , false);
        else if @fakeInput.attachEvent
            @fakeInput.attachEvent('keypress', () -> @fakeInputKeyPressed);

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

    createFakeInput: ->
        @fakeInput = document.createElement('input')
        @fakeInput.id = @fieldId+"_fake_input"
        @fakeInput.className = "jstagger_fake_input"
        @wrapper.insertBefore(@fakeInput, @tagField)

    setupField: ->
        @getFieldById()
        @fieldWrap()
        @createTagArea()
        @createFakeInput()
        @fieldAddListener()
        @tagField.style.display = "none"

    trimTag: (str)->
        str.replace /^\s+|\s+$/g, ''


    #Events
    fakeInputKeyPressed: (e) ->
        if e.keyCode == 44
            e.stopPropagation()
            e.preventDefault()
            tagStr = @trimTag @fakeInput.value
            @fakeInput.value = ""
            tagSpan = document.createElement 'span'
            tagSpan.className = "jstagger_tag"
            tagSpan.innerHTML = tagStr
            @wrapper.insertBefore tagSpan, @fakeInput
            @tagField.value += (if @tagField.value == "" then "" else ", ") + tagStr
            @fakeInput.focus()
            console.log @wrapper






