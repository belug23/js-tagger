class JSTagger
    constructor: (@fieldId) ->
        @setupField()

    getFieldById: ->
        @tagField = document.getElementById(@fieldId)

    fieldAddListener: ->
        self = @
        if @tempInput.addEventListener
            @tempInput.addEventListener('keypress', (e) ->
                self.tempInputKeyPressed(e)
            , false);
            @tempInput.addEventListener('blur', (e) ->
                self.addTag()
            , false);
            @wrapper.addEventListener('click', (e) ->
                self.wrapperClicked(e)
            , false);
        else if @tempInput.attachEvent
            @tempInput.attachEvent('keypress', (e) ->
                self.tempInputKeyPressed(e)
            );
            @tempInput.attachEvent('blur', (e) ->
                self.addTag()
            );
            @tempInput.attachEvent('click', (e) ->
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

    createtempInput: ->
        @tempInput = document.createElement('input')
        @tempInput.id = @fieldId+"_temp_input"
        @tempInput.className = "jstagger_temp_input"
        @wrapper.insertBefore(@tempInput, @tagField)

    setupField: ->
        @getFieldById()
        @fieldWrap()
        @createTagArea()
        @createCloseBtn()
        @createtempInput()
        @fieldAddListener()
        @tagField.style.display = "none"

    trimTag: (str)->
        str.replace /^\s+|\s+$/g, ''

    populateTagField: ->
        tagNames = []
        for tag in @tagArea.children
            tagNames.push(tag.innerText)

        @tagField.value = tagNames.join(", ")

    measureText: (text) ->
        sizeDiv = document.createElement 'div'
        document.body.appendChild(sizeDiv);
        if window.getComputedStyle
            sizeDiv.style = window.getComputedStyle(@tempInput)
        else
            sizeDiv.style = @tempInput.style

        sizeDiv.style.position = "absolute"
        sizeDiv.style.left = -1000
        sizeDiv.style.top = -1000

        sizeDiv.innerHTML = text
        width = sizeDiv.clientWidth

        document.body.removeChild(sizeDiv)
        sizeDiv = null

        return width+1

    resizeInput: (charCode = null) ->
        text = @tempInput.value
        if charCode
            text += String.fromCharCode(charCode)
        text = text.replace(/\W/g,"_")
        @tempInput.style.width = @measureText(text)+"px"

    addTag: ->
        if @tempInput.value != ""
            tagStr = @trimTag @tempInput.value
            @tempInput.value = ""
            tagSpan = document.createElement 'span'
            tagSpan.className = "jstagger_tag"
            tagSpan.innerText = tagStr
            tagSpan.appendChild @closeBtn.cloneNode()
            @tagArea.appendChild tagSpan
            @populateTagField()
            @tempInput.focus()


    #Events
    tempInputKeyPressed: (e) ->
        if e.keyCode == 44
            e.stopPropagation()
            e.preventDefault()
            @addTag
        @resizeInput(e.charCode)


    wrapperClicked: (e) ->
        e.stopPropagation()
        e.preventDefault()
        if e.target.tagName == "SPAN" && e.target.className.indexOf("jstagger_tag") >= 0
            @tempInput.value = e.target.innerText
            e.target.remove()

        if e.target.tagName == "IMG" && e.target.className.indexOf("jstagger_close_btn") >= 0
            console.log('span clicked')
            e.target.parentNode.remove()

        @populateTagField()
        @resizeInput()
        @tempInput.focus()







