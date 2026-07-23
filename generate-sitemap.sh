#!/bin/bash

# Generate sitemap.xml for all HTML files
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  
  # Find all HTML files except index.html redirects
  find . -name "*.html" -type f ! -path "./.git/*" | sort | while read file; do
    # Convert to URL path
    url="https://tacticalseats.com/${file#./}"
    # Get modification time
    mtime=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1)
    
    echo "  <url><loc>${url}</loc><lastmod>${mtime}</lastmod><changefreq>monthly</changefreq><priority>0.8</priority></url>"
  done
  
  echo '</urlset>'
} > sitemap.xml

echo "Sitemap generated: $(wc -l < sitemap.xml) lines"
