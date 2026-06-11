import { Controller } from "@hotwired/stimulus"

// Buyer-activity US map. Hovering a buyer row highlights that buyer's dots;
// clicking opens a detail panel (and keeps the dots focused) with a back arrow.
export default class extends Controller {
  static targets = ["group", "list", "detail"]

  hover(event) {
    if (this.element.dataset.active) return
    this.highlight(event.currentTarget.dataset.buyer)
  }

  unhover() {
    if (this.element.dataset.active) return
    this.resetDots()
  }

  select(event) {
    const id = event.currentTarget.dataset.buyer
    this.element.dataset.active = id
    this.highlight(id)
    this.listTarget.classList.add("hidden")
    this.detailTargets.forEach((panel) => panel.classList.toggle("hidden", panel.dataset.buyer !== id))
  }

  back() {
    delete this.element.dataset.active
    this.resetDots()
    this.listTarget.classList.remove("hidden")
    this.detailTargets.forEach((panel) => panel.classList.add("hidden"))
  }

  highlight(id) {
    this.groupTargets.forEach((group) => {
      group.style.opacity = group.dataset.buyer === id ? "1" : "0.1"
    })
  }

  resetDots() {
    this.groupTargets.forEach((group) => { group.style.opacity = "1" })
  }
}
