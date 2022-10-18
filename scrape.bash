docker run -it --env-file=/home/james/docsearch/.env -e "CONFIG=$(cat /home/james/docsearch/config.json | jq -r tostring)" algolia/docsearch-scraper
