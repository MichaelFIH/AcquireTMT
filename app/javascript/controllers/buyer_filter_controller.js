import { Controller } from "@hotwired/stimulus"

// Client-side filter tabs for the seller "Potential Buyers" list. Each tab has
// a data-category; rows carry data-category. "all" shows everything.
export default class extends Controller {
  static targets = ["row", "tab"]

  filter(event) {
    const category = event.currentTarget.dataset.category
    this.rowTargets.forEach((row) => {
      row.classList.toggle("hidden", category !== "all" && row.dataset.category !== category)
    })
    this.tabTargets.forEach((tab) => {
      const active = tab === event.currentTarget
      tab.classList.toggle("bg-brand-900", active)
      tab.classList.toggle("text-white", active)
      tab.classList.toggle("bg-brand-50", !active)
      tab.classList.toggle("text-brand-900", !active)
    })
  }
}
