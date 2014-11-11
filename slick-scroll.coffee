# My Very Own Class for navigation scrolling.
# Depends on JQuery for the time being.

# Initialize with a parent containing some children containing some links
# i.e. a ul with some <li>s with some <a href="#something">s
# make sure you've got a <tag id="something"> somewhere on the page

class SlickScroll

  constructor: (containing_list, offset = 200) ->
    offset = parseInt(offset, 10)
    menu_items = containing_list.children()
    anchors = assign_anchors(menu_items)
    add_click_handlers(anchors, offset)
  
  to_the_top:  ->
    animate_page 0
    return false  
    
  assign_anchors = (list_items) ->
    hrefs = {}
    for item in list_items
      full_href = $(item).children()[0]['href']
      anchor = full_href.match(/#.*/)[0]
      hrefs[anchor] = $(item).children()[0]
    hrefs

  add_click_handlers = (anchors, offset) ->
    console.log anchors
    for k, v of anchors
      do (k, v) ->
        a = $(v)
        a.on 'click', ->
          animate_page $(k).offset().top - offset
          
  animate_page = (position, speed = 200) ->
    if $('#header').hasClass('stuck') == true
      position += 90 
    $('html, body').animate({
      scrollTop: position
      }, speed)
    return false
