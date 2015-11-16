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
			$('#progress .bar').css('width', '0')

		fail: (e, data) ->
			data.context.text "Failed #{data.files[0].name} ✗"
			$('#progress .bar').css('width', '0')

		progress: (e, data) ->
	    progress = parseInt(data.loaded / data.total * 100, 10)
	    $('#progress .bar').css('width', progress + '%')

	@element = $('#result')
	@element.css('background-size', '100% 100%')
	@element.css('background-repeat', 'no-repeat')

	$('.main').on 'dragover', (e) =>
		@element.css('background-image', 'url("http://uxrepo.com/static/icon-sets/typicons/svg/upload-cloud.svg")')
	$('.main').on 'dragleave drop', (e) =>
		@element.css("background-image", "none")

	$('#commandRow > input').on 'keyup', (e) ->
		if(e.which == 13)
			@command = e.target.value
			if @command != '' || undefined
				$('#result').empty()
			id = $('#fileItems > li.active').attr('id')
			$.ajax(
        type: 'POST'
        url: "/uploads/#{id}"
        dataType: "script"
        data: (_method:'PATCH', command: @command)).error () ->
          $('#result').html("ERROR")

