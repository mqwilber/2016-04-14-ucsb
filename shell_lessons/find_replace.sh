## Update css and img paths on all html files
sed -i.bak -e "s#css/#../css/#g" *html
sed -i.bak -e "s#img/#../img/#g" *html