//= require_tree .
document.addEventListener('DOMContentLoaded', function(){
  origin = window.location.origin
  // get the styleguide sections
  sections = document.querySelectorAll('.styleguide-content')
  sectionLinks = document.querySelectorAll('.styleguide-category-sections li a')

  if(window.location.hash){
    selector = window.location.hash.substring(1)
    gotoSection("#"+selector)
  }else{
    gotoFirstSection()
  }


  Array.prototype.forEach.call(sectionLinks, function(link, i){
    link.addEventListener('click', function(e){
      e.preventDefault()
      hideAllSections()
      removeActiveLinks()
      link.classList.add('current')
      href = link.getAttribute('href')
      gotoSection(href)
    })
  })

  function removeActiveLinks(){
    Array.prototype.forEach.call(sectionLinks, function(link, i){
      link.classList.remove('current')
    })
  }

  function gotoFirstSection(){
    sections[0].classList.add('styleguide-content--visible')
    sectionLinks[0].classList.add('current')
    updateUrl(sections[0].id)
  }

  function hideAllSections(){
    Array.prototype.forEach.call(sections, function(section, i){
      section.classList.remove('styleguide-content--visible')
    })
  }

  function gotoSection(selector){
    window.scrollTo(0,0)
    section = document.getElementById(selector)
    if (section != null){
      updateUrl(selector)
      sectionLink = document.querySelector('.styleguide-category-sections li a[href="'+selector+'"]')
      sectionLink.classList.add('current')
      section.classList.add('styleguide-content--visible')
    }else{
      gotoFirstSection()
    }
  }

  function updateUrl(section){
    url = { title: section, url: section }
    history.pushState(url, url.title, url.url);
  }

});
