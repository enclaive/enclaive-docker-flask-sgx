FROM gramineproject/gramine:latest

RUN echo "--install-python--" \
    && apt-get update \
    && apt-get install -y python3 python3-pip

WORKDIR /app/

COPY ./app /app/
COPY ./entrypoint.sh /app/
RUN mkdir data

RUN echo "--setup-flask--" \
    && pip3 install Flask

VOLUME /data/

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
