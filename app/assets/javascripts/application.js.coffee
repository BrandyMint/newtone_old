#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require jquery-fileupload/basic

$ ->
  jqXHR = null
  $('[rel*="tooltip"]').tooltip()

  $('#cancel_processing').click ->
    jqXHR.abort()
    screenState('welcome')

  $('.j-record-button').on 'click', (e) ->
    e.preventDefault()
    $('.j-record-button').toggleClass('hide')

  $("#sample_upload").fileupload
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i ,
    add:(e, data)->
      data.context = $("#upload a.record-button").removeClass("disabled").click ->
        screenState('processing')
        jqXHR = data.submit()
          .success (result, textStatus, jqXHR) ->
            if result != null
              state = if result.status == 1 then "good" else "bad"
              newtoneFace(state)
              resultsOutput( result.artist, result.track)
              screenState('results')
            else
              resultsOutput("Oops&hellip;","I don't know anything similar.")
              screenState('results')
              newtoneFace('bad')
            $("#upload a.record-button").unbind('click')
          .error (jqXHR, textStatus, errorThrown) ->
            if (errorThrown != 'abort')
              screenState('error')
            $("#upload a.record-button").unbind('click')

    always: (e, date)->
      $("#upload a.record-button").addClass("disabled")

@newtoneFace = (state) ->
  $('.j.newtone-face').removeClass('visible').addClass('hidden')
  $('.j.newtone-face.newtone-' + state).removeClass('hidden').addClass('visible')

@screenState = (screen) ->
  screens= ['.j-welcome-screen', '.j-processing-screen', '.j-results-screen', '.j-error-screen' ]
  $(screens.join(", ")).each ->
    if not $(@).hasClass('hide')
      $(@).addClass('hide')
  $('.j-'+screen+'-screen').removeClass('hide')

@resultsOutput = (artist=null, title=null)->
  $('.j-artist').html(artist)
  $('.j-title').html(title)