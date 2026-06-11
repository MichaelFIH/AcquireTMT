import { Controller } from "@hotwired/stimulus"

// Enables the "Sign NDA" button only once the agreement checkbox is ticked.
export default class extends Controller {
  static targets = ["agree", "submit"]

  toggle() {
    this.submitTarget.disabled = !this.agreeTarget.checked
  }
}
