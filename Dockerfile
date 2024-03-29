# mariadb with patches

FROM enclaive/gramine-os:jammy-7e9d6925

RUN apt-get update \
    && apt-get install -y  wget build-essential python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY ./app /app/
COPY ./app.manifest.template ./entrypoint.sh /app/

RUN apt update
RUN apt install -y python3-pip
RUN pip3 install -r requirements.txt
RUN pip3 show flask

RUN gramine-argv-serializer "/usr/bin/python3" "/app/main.py" > args.txt &&\
    gramine-manifest -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest &&\
    gramine-sgx-sign --key "$SGX_SIGNER_KEY" --manifest app.manifest --output app.manifest.sgx

EXPOSE 5000/tcp

ENTRYPOINT [ "/app/entrypoint.sh" ]

