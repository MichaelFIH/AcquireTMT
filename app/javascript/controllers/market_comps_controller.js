import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "websiteStep",
    "financialStep",
    "loadingStep",
    "reportStep",
    "websiteInput",
    "companyName",
    "revenueInput",
    "profitInput",
    "salaryInput",
    "progressBar",
    "progressText",
    "loadingTitle",
    "loadingDescription",
    "stepList",
    "previewIntro",
  "previewProducts",
  "previewMarkets"
  ]

  connect() {
    this.messages = [
      ["Analyzing website data", "Reviewing business model and company signals."],
      ["Identifying industry category", "Mapping your business to the closest TMT sector."],
      ["Evaluating business model", "Checking recurring revenue, services mix, and market positioning."],
      ["Finding comparable listings", "Searching similar businesses and recent market activity."],
      ["Analyzing financial metrics", "Comparing revenue, profit, cash flow, and pricing signals."],
      ["Benchmarking performance", "Preparing a market comps snapshot for your business."]
    ]
  }

  showFinancials(event) {
    event.preventDefault()

    const website = this.websiteInputTarget.value.trim()

    if (!website) {
      alert("Please enter your company website.")
      return
    }

    this.companyNameTargets.forEach((target) => {
      target.textContent = this.extractCompanyName(website)
    })

    this.websiteStepTarget.classList.add("hidden")
    this.financialStepTarget.classList.remove("hidden")
  }

  startReport(event) {
    event.preventDefault()

    const revenue = Number(this.revenueInputTarget.value)
    const profit = Number(this.profitInputTarget.value)

    if (!revenue || !profit) {
      alert("Please enter your revenue and pre-tax profit.")
      return
    }

    if (profit > revenue) {
      alert("Pre-tax profit cannot be greater than annual revenue.")
      return
    }

    this.financialStepTarget.classList.add("hidden")
    this.loadingStepTarget.classList.remove("hidden")

    let progress = 0
    let messageIndex = -1

    this.stepListTarget.innerHTML = ""
    this.progressBarTarget.style.width = "0%"
    this.progressTextTarget.textContent = "0%"
    this.previewIntroTarget.classList.add("hidden")
this.previewProductsTarget.classList.add("hidden")
this.previewMarketsTarget.classList.add("hidden")

    const interval = setInterval(() => {
      progress += Math.floor(Math.random() * 8) + 5
      if (progress >= 100) progress = 100

      this.progressBarTarget.style.width = `${progress}%`
      this.progressTextTarget.textContent = `${progress}%`
      if (progress >= 45) {
  this.previewIntroTarget.classList.remove("hidden")
}

if (progress >= 65) {
  this.previewProductsTarget.classList.remove("hidden")
}

if (progress >= 80) {
  this.previewMarketsTarget.classList.remove("hidden")
}

      const nextIndex = Math.min(
        Math.floor((progress / 100) * this.messages.length),
        this.messages.length - 1
      )

      if (nextIndex !== messageIndex) {
        messageIndex = nextIndex
        const [title, description] = this.messages[messageIndex]

        this.loadingTitleTarget.textContent = title
        this.loadingDescriptionTarget.textContent = description
        this.addProcessingStep(title, description)
      }

      if (progress === 100) {
        clearInterval(interval)

        setTimeout(() => {
          this.loadingStepTarget.classList.add("hidden")
          this.reportStepTarget.classList.remove("hidden")
        }, 900)
      }
    }, 500)
  }

  addProcessingStep(title, description) {
    const item = document.createElement("div")

    item.className =
      "flex gap-3 rounded-sm border border-brand-100 bg-white p-4 shadow-soft animate-fade-up"

    item.innerHTML = `
      <div class="mt-1 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-brand-300 text-brand-900">
        ✓
      </div>

      <div>
        <p class="text-sm font-bold text-brand-900">${title}</p>
        <p class="mt-1 text-xs leading-5 text-slate-600">${description}</p>
      </div>
    `

    this.stepListTarget.prepend(item)
  }

  backToWebsite(event) {
    event.preventDefault()

    this.financialStepTarget.classList.add("hidden")
    this.websiteStepTarget.classList.remove("hidden")
  }

  extractCompanyName(url) {
    try {
      const parsedUrl = new URL(url.startsWith("http") ? url : `https://${url}`)
      return parsedUrl.hostname.replace("www.", "").split(".")[0]
    } catch {
      return "Your Business"
    }
  }
}