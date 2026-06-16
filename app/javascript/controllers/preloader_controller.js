import { Controller } from "@hotwired/stimulus"

// Full-screen splash shown once per session on the first page load, then faded
// out. On later Turbo navigations the body re-renders, so we use a window flag
// to hide it instantly (no flash) instead of replaying the splash every time.
export default class extends Controller {
  connect() {
    if (window.__preloaderDone) {
      this.element.remove()
      return
    }

    const dismiss = () => {
      window.__preloaderDone = true
      this.element.classList.add("preloader-hidden")
      setTimeout(() => this.element.remove(), 600)
    }

    if (document.readyState === "complete") {
      // Brief beat so the splash is perceptible, then fade.
      setTimeout(dismiss, 300)
    } else {
      window.addEventListener("load", () => setTimeout(dismiss, 300), { once: true })
      // Safety net in case `load` never fires (e.g. a stalled asset).
      setTimeout(dismiss, 4000)
    }
  }
}
