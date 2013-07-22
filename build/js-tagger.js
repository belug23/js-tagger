// Generated by CoffeeScript 1.6.3
var JSTagger;

JSTagger = (function() {
  function JSTagger(fieldId) {
    this.fieldId = fieldId;
    this.setupField();
  }

  JSTagger.prototype.getFieldById = function() {
    return this.tagField = document.getElementById(this.fieldId);
  };

  JSTagger.prototype.fieldAddListener = function() {
    var self;
    self = this;
    if (this.fakeInput.addEventListener) {
      this.fakeInput.addEventListener('keypress', function(e) {
        return self.fakeInputKeyPressed(e);
      }, false);
      return this.wrapper.addEventListener('click', function(e) {
        return self.wrapperClicked(e);
      }, false);
    } else if (this.fakeInput.attachEvent) {
      this.fakeInput.attachEvent('keypress', function(e) {
        return self.fakeInputKeyPressed(e);
      });
      return this.fakeInput.attachEvent('click', function(e) {
        return self.wrapperClicked(e);
      });
    }
  };

  JSTagger.prototype.fieldWrap = function() {
    this.createWrapper();
    this.tagField.parentNode.insertBefore(this.wrapper, this.tagField);
    this.tagField.parentNode.removeChild(this.tagField);
    return this.wrapper.appendChild(this.tagField);
  };

  JSTagger.prototype.createWrapper = function() {
    this.wrapper = document.createElement('div');
    this.wrapper.id = this.fieldId + "_wrapper";
    return this.wrapper.className = "jstagger_wrapper";
  };

  JSTagger.prototype.createTagArea = function() {
    this.tagArea = document.createElement('span');
    this.tagArea.id = this.fieldId + "_tag_area";
    return this.wrapper.insertBefore(this.tagArea, this.tagField);
  };

  JSTagger.prototype.createFakeInput = function() {
    this.fakeInput = document.createElement('input');
    this.fakeInput.id = this.fieldId + "_fake_input";
    this.fakeInput.className = "jstagger_fake_input";
    return this.wrapper.insertBefore(this.fakeInput, this.tagField);
  };

  JSTagger.prototype.setupField = function() {
    this.getFieldById();
    this.fieldWrap();
    this.createTagArea();
    this.createFakeInput();
    this.fieldAddListener();
    return this.tagField.style.display = "none";
  };

  JSTagger.prototype.trimTag = function(str) {
    return str.replace(/^\s+|\s+$/g, '');
  };

  JSTagger.prototype.fakeInputKeyPressed = function(e) {
    var tagSpan, tagStr;
    if (e.keyCode === 44) {
      e.stopPropagation();
      e.preventDefault();
      tagStr = this.trimTag(this.fakeInput.value);
      this.fakeInput.value = "";
      tagSpan = document.createElement('span');
      tagSpan.className = "jstagger_tag";
      tagSpan.innerHTML = tagStr;
      this.wrapper.insertBefore(tagSpan, this.fakeInput);
      this.tagField.value += (this.tagField.value === "" ? "" : ", ") + tagStr;
      return this.fakeInput.focus();
    }
  };

  JSTagger.prototype.wrapperClicked = function(e) {
    e.stopPropagation();
    e.preventDefault();
    console.log(e.target);
    if (e.target.tagName === "SPAN" && e.target.className.indexOf("jstagger_tag") >= 0) {
      console.log('span clicked');
      this.fakeInput.value = e.target.innerHTML;
      e.target.remove();
    }
    return this.fakeInput.focus();
  };

  return JSTagger;

})();
