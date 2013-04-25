---
layout: page
---
{% include JB/setup %}
<div class="posts">
  {% for post in site.posts limit:10 %}
  {% if forloop.index == 1 %}
  <div class="hero-unit">
    <h2><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></h2>
	<p>{{ post.date | date_to_string}}</p>
    <p>{{ post.content | strip_html | truncatewords:30 }}</p>
  </div>
  {% else %}
  <div>
    <h2><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a><small class="pull-right">{{ post.date | date_to_string}}</small></h2>
    {{ post.content | strip_html | truncatewords:30}}
  </div>
  {% endif %}
  {% endfor %}
</div>
