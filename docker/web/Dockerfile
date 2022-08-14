FROM nginx:1.23.1

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

RUN chown -R nginx /var/cache/nginx/ && \
    chown -R nginx /var/run/
USER nginx

# ビルド完了後にフォアグラウンドでNginxを起動。バックグラウンドで起動するとコンテナが終了する。
CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
