docker run -it --env-file=/opt/pi/webadmin/.env -e "CONFIG=$(cat /opt/pi/webadmin/config.json | jq -r tostring)" algolia/docsearch-scraper
