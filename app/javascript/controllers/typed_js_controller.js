import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Proposez vos Lego.", "Louez-en d'autres.", "N'arrêtez jamais de créer."],
      typeSpeed: 50,
      loop: true
    })
  }
}
