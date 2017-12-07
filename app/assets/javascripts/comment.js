// Needs to be fixed, keeps disappearing

function myComment() {
  var mainForm = document.getElementById("mainForm"),
    textBox = document.createElement("input");
    submitButton = document.createElement("input");

  textBox.id="tmpTextBox";
  textBox.type="form";
  submitButton.id="tmpSubmitButton";
  submitButton.type="button";

  document.getElementById("clickme").onclick = function () {
    mainForm.appendChild(submitButton);
  }

  document.getElementById("clickme").onclick = function () {
    mainForm.appendChild(textBox);
  }
}