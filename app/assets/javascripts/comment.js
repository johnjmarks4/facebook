// Needs to be fixed, keeps disappearing

function myComment() {
  var mainForm = document.getElementById("mainForm"),
    textBox = document.createElement("input");

  textBox.id="tmpTextBox";
  textBox.type="text"

  document.getElementById("clickme").onclick = function () {
    mainForm.appendChild(textBox);
  }

  document.getElementById("submitme").onclick = function () {
    mainForm.removeChild(textBox);
  }
}