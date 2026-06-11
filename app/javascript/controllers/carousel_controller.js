import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track"]

  scrollLeft(event) {
    event.preventDefault()

    this.trackTarget.scrollBy({
      left: -this.cardWidth(),
      behavior: "smooth"
    })
  }

  scrollRight(event) {
    event.preventDefault()

    this.trackTarget.scrollBy({
      left: this.cardWidth(),
      behavior: "smooth"
    })
  }

  cardWidth() {
    const card = this.trackTarget.querySelector("[data-carousel-card]")
    return card ? card.getBoundingClientRect().width + 24 : 380
  }
}
