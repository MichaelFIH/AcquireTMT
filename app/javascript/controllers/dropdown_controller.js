import { Controller } from "@hotwired/stimulus"

// Nav dropdown that opens on hover AND click. It toggles the `hidden` class on
// the menu target — a class that's always present in the compiled CSS — rather
// than relying on group-hover/invisible utility combos, so it can't break if
// the Tailwind build is stale. Closes on outside click and Escape.
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.onDocClick = (event) => {
      if (!this.element.contains(event.target)) this.close()
    }
    this.onKeydown = (event) => {
      if (event.key === "Escape") this.close()
    }
  }

  disconnect() {
    this.teardown()
  }

  open() {
    if (!this.hasMenuTarget) return
    this.menuTarget.classList.remove("hidden")
    this.element.classList.add("is-open")
    document.addEventListener("click", this.onDocClick)
    document.addEventListener("keydown", this.onKeydown)
  }

  close() {
    if (!this.hasMenuTarget) return
    this.menuTarget.classList.add("hidden")
    this.element.classList.remove("is-open")
    this.teardown()
  }

  toggle(event) {
    event.preventDefault()
    this.menuTarget.classList.contains("hidden") ? this.open() : this.close()
  }

  teardown() {
    document.removeEventListener("click", this.onDocClick)
    document.removeEventListener("keydown", this.onKeydown)
  }
}
