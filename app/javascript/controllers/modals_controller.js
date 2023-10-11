import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {}

  close(e) {
    //prevent default action
    e.preventDefault();
    //Remove from parent
    const modal = document.getElementById("modal");
    modal.innerHTML = "";

    //Remove the src attribute from the modal
    modal.removeAttribute ("src");
p
    // Reomove comlete attribute
    modal.removeAttribute("complete")
  }
}
