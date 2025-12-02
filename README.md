# Proxy Scraper & Mubeng Integration

This project integrates [proxy-scraper-checker](https://github.com/monosans/proxy-scraper-checker) and [mubeng](https://github.com/mubeng/mubeng) using Docker.

## Structure

- **scraper**: Runs `proxy-scraper-checker` in a loop (every hour). It scrapes proxies, checks them, and combines the results into `proxies.txt`.
- **mubeng**: Runs `mubeng` as a proxy server on port `8080`. It watches `proxies.txt` for changes and rotates IP addresses.

## Usage

1.  **Build and Start**:
    ```bash
    docker compose up --build -d
    ```

2.  **Check Logs**:
    ```bash
    docker compose logs -f
    ```

3.  **Use the Proxy**:
    The proxy server is available at `localhost:8080`.
    You can test it with curl:
    ```bash
    curl -x http://localhost:8080 https://httpbin.org/ip
    ```

## Configuration

- **Scraper**: Edit `scraper/config.toml` to change proxy sources, timeouts, etc.
- **Mubeng**: Edit `docker-compose.yml` to change mubeng arguments (e.g., rotation interval `-r`).
