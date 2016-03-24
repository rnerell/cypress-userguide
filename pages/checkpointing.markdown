---
layout: checkpointing
title: "Palmetto Software Guide"
---

{% for section in site.data.checkpointing.navigation %}

  <div class="bs-docs-section">
  <h1 id="{{section.id}}" class="page-header">{{section.mainTitle}}</h1>
  {% include {{section.path}} %}

  <a class="back-to-top" href="#top">Back to top</a>
  </div>

{% endfor %}

