document.addEventListener("turbolinks:load", function() {
  var toggle = document.getElementById("theme-toggle");
  if (!toggle) return;

  toggle.addEventListener("click", function(e) {
    e.preventDefault();
    var body = document.body;
    var currentTheme = body.getAttribute("data-theme");
    var newTheme = currentTheme === "dark" ? "light" : "dark";
    var icon = document.getElementById("theme-icon");

    body.setAttribute("data-theme", newTheme);
    if (icon) {
      icon.textContent = newTheme === "dark" ? "\u2600" : "\u263E";
    }

    var csrfToken = document.querySelector('meta[name="csrf-token"]');
    var token = csrfToken ? csrfToken.getAttribute("content") : "";

    var xhr = new XMLHttpRequest();
    xhr.open("PUT", "/theme", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("X-CSRF-Token", token);
    xhr.setRequestHeader("Accept", "text/javascript");
    xhr.send("theme=" + newTheme);
  });
});
