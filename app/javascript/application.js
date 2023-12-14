// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "jquery"
import "@rails/request.js"
Turbo.setConfirmMethod(()=>{
  let dialog = document.getElementById("turbo-confirm")
  dialog.showModal()

  return new Promise((resolve, reject) => {
    dialog.addEventListener("close", ()=> {
      resolve(dialog.returnValue == "confirm")
    }, { once: true })
  })
})

const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
