import { Controller } from "@hotwired/stimulus"

// "Get Started" modal: choose Seller (lead form -> thank you) or Buyer (signup),
// mirroring OffDeal's entry flow.
export default class extends Controller {
  static targets = ["modal", "choice", "sellerForm", "thanks", "error"]

  open(event) {
    event?.preventDefault()
    this.step("choice")
    this.modalTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
  }

  close(event) {
    event?.preventDefault()
    this.modalTarget.classList.add("hidden")
    document.body.style.overflow = ""
  }

  backdrop(event) {
    if (event.target === this.modalTarget) this.close()
  }

  chooseSeller(event) {
    event.preventDefault()
    this.step("sellerForm")
  }

  step(name) {
    this.choiceTarget.classList.toggle("hidden", name !== "choice")
    this.sellerFormTarget.classList.toggle("hidden", name !== "sellerForm")
    this.thanksTarget.classList.toggle("hidden", name !== "thanks")
    if (this.hasErrorTarget) this.errorTarget.classList.add("hidden")
  }

  async submit(event) {
    event.preventDefault()
    const form = event.currentTarget
    const token = document.querySelector('meta[name="csrf-token"]')?.content
    try {
      const response = await fetch("/leads", {
        method: "POST",
        headers: { "Accept": "application/json", "X-CSRF-Token": token || "" },
        body: new FormData(form)
      })
      const data = await response.json().catch(() => ({}))
      if (response.ok && data.ok) {
        this.step("thanks")
      } else {
        this.showError(data.error || "Please complete the required fields.")
      }
    } catch {
      this.showError("Something went wrong. Please try again.")
    }
  }

  showError(message) {
    if (!this.hasErrorTarget) return
    this.errorTarget.textContent = message
    this.errorTarget.classList.remove("hidden")
  }
}
