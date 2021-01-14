FROM croservices/cro-http:0.8.4
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN zef install --deps-only . && perl6 -c -Ilib service.p6
ENV RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_PORT="10000" RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_HOST="0.0.0.0"
EXPOSE 10000
CMD perl6 -Ilib service.p6
