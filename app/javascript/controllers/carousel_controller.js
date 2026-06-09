import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track"]

  scrollLeft(event) {
    event.preventDefault()
    this.scroll(-1)
  }

  scrollRight(event) {
    event.preventDefault()
    this.scroll(1)
  }

  scroll(direction) {
    const firstCard = this.trackTarget.querySelector("[data-carousel-card]")

    const amount = firstCard
      ? firstCard.offsetWidth + 24
      : 380

    this.trackTarget.scrollBy({
      left: amount * direction,
      behavior: "smooth"
    })
  }
}