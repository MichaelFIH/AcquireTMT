import { Controller } from "@hotwired/stimulus"

// Reveals an element with a fade-up as it scrolls into view (premium feel).
// Adds the hidden state itself so no-JS users still see the content.
export default class extends Controller {
  static values = { delay: Number }

  connect() {
    if (!("IntersectionObserver" in window)) return

    this.element.classList.add("reveal-init")
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return
          setTimeout(() => entry.target.classList.add("reveal-in"), this.delayValue || 0)
          this.observer.unobserve(entry.target)
        })
      },
      { threshold: 0.15 }
    )
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
