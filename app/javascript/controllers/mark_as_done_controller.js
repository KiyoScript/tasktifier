import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  updateTask(event) {
    const checkbox = event.target;
    const taskId = checkbox.value;

    if (checkbox.checked) {
      this.myMethod(taskId);
    }
  }

  async myMethod(taskId) {
    const request = new FetchRequest('patch',`/mark_as_done${taskId}`, { body: JSON.stringify({ name: 'Request.JS' }) });
    const response = await request.perform();

    if (response.ok) {
      const body = await response.json();
      console.log(body)
    }
  }
}
