#!/bin/bash

# Create empty file if it doesn't exist so mubeng doesn't crash
touch /app/out/proxies.txt
chmod 666 /app/out/proxies.txt

while true; do
    echo "Starting proxy scraper..."
    /app/proxy-scraper-checker
    echo "Scraping finished. Combining files..."
    
    # Determine where the scraper saved the files
    SOURCE_DIR="/app/out"
    if [ -d "/root/.local/share/proxy_scraper_checker" ]; then
        SOURCE_DIR="/root/.local/share/proxy_scraper_checker"
    fi
    
    echo "Found proxy files in: $SOURCE_DIR"
    echo "Listing files in $SOURCE_DIR:"
    ls -R "$SOURCE_DIR"
    
    # Combine all txt files into one using wildcard
    # We filter out proxies.txt just in case it's in the same dir (though it shouldn't be)
    find "$SOURCE_DIR" -name "*.txt" -not -name "proxies.txt" -exec cat {} + > /app/out/proxies.txt 2>/dev/null
    
    # Verify if we actually got anything
    if [ -s /app/out/proxies.txt ]; then
        echo "Success! Combined proxies into /app/out/proxies.txt"
        echo "First 5 lines of proxies.txt:"
        head -n 5 /app/out/proxies.txt
    else
        echo "Warning: proxies.txt is empty. The scraper might not have found any working proxies."
    fi
    echo "Sleeping for 1 hour..."
    sleep 3600
done
