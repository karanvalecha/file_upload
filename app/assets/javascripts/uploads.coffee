# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ->


	$("#fileUpload").fileupload
		dataType: "script"

		add: (e, data) ->
			types = /(\.|\/)(txt)$/i
			file = data.files[0]
			if types.test(file.type) || types.test(file.name)
				data.context = $('<p/>').text("Uploading #{data.files[0].name} ∞").appendTo(document.body)
				data.submit()
			else
				alert "#{file.name} is not a text file"
		done: (e, data) ->
			data.context.text "Uploaded #{data.files[0].name} ✓"
		fail: (e, data) ->
			data.context.text "Failed #{data.files[0].name} ✗"
			$("#progress > .bar").width(0)

		progress: (e, data) -> 
	    progress = parseInt(data.loaded / data.total * 100, 10)
	    $('#progress .bar').css('width', progress + '%')

  
	$(document).bind 'dragover', (e) ->
	  dropZone = $('#dropzone')
	  timeout = window.dropZoneTimeout
	  if !timeout
	    dropZone.addClass 'in'
	  else
	    clearTimeout timeout
	  found = false
	  node = e.target
	  loop
	    if node == dropZone[0]
	      found = true
	      break
	    node = node.parentNode
	    unless node != null
	      break
	  if found
	    dropZone.addClass 'hover'
	  else
	    dropZone.removeClass 'hover'
	  window.dropZoneTimeout = setTimeout((->
	    window.dropZoneTimeout = null
	    dropZone.removeClass 'in hover'
	    return
	  ), 100)
	  return
$(document).bind 'drop dragover', (e) ->
  e.preventDefault()