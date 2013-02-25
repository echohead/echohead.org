audio = null

$(document).ready ->
  audio = $ 'audio'
  console.log audio
  playlist = $('#playlist')
  console.log playlist
  tracks = playlist.find 'li a'
  len = tracks.length - 1
  audio[0].volume = 0.5

  play = (link, player) ->
    player.src = link.attr 'href'
    link.parent().addClass('active').siblings().removeClass('active')
    audio[0].load()
    audio[0].play()

  playlist.find('a').click (e) ->
    e.preventDefault()
    link = $(this)
    current = link.parent().index()
    play link, audio[0]

  audio[0].addEventListener 'ended', (e) ->
    current++
    if current == len
      current = 0
      link = playlist.find('a')[0]
    else
      link = playlist.find('a')[current]
    play $(link), audio[0]

