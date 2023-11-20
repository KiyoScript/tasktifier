// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "flatpicker"

flatpickr("#dateTimePicker", {
  "dateFormat":"n/j/Y H:i",
  "enableTime":true,
  "allowInput":true
})
