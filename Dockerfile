FROM gramineproject/gramine:latest

RUN echo "--install-python--" \
    && apt-get update \
    && apt-get install -y python3 python3-pip

WORKDIR /app/

COPY ./app /app/
#COPY ./flask.manifest.template ./entrypoint.sh /app/
RUN mkdir data

RUN echo "--setup-flask--" \
    && pip3 install Flask

#RUN gramine-sgx-gen-private-key \
#    && gramine-argv-serializer "/usr/bin/python3" "-m" "flask" "run" > args.txt \
#    && gramine-manifest -Darch_libdir=/lib/x86_64-linux-gnu flask.manifest.template flask.manifest \
#    && gramine-sgx-sign --manifest flask.manifest --output flask.manifest.sgx

VOLUME /data/

#RUN /bin/bash
ENTRYPOINT[ "python3", "-m", "flask", "run" ]
#RUN chmod +x /app/entrypoint.sh
#ENTRYPOINT ["/app/entrypoint.sh"]
