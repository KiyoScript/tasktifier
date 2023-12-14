import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  async updateTask(event) {
    const checkbox = event.target;
    const taskId = checkbox.value;
    if (checkbox.checked) {
      const request = new FetchRequest('patch',`/mark_as_done/${taskId}`, { body: JSON.stringify({ name: 'Request.JS' }) })
      await request.perform()
      window.location.reload()
    }
  }
}

