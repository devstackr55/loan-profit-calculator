FROM ruby:3.3.3-alpine AS ruby-base

FROM surnet/alpine-wkhtmltopdf:3.20.0-0.12.6-full AS wkhtmltopdf

FROM ruby:3.3.3-alpine

RUN apk add --no-cache \
    git \
    build-base \
    bash \
    bash-completion \
    libffi-dev \
    tzdata \
    postgresql-client \
    postgresql-dev \
    nodejs \
    npm \
    yarn \
    less \
    libxrender \
    fontconfig \
    freetype \
    libx11 \
    ttf-dejavu

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
COPY --from=wkhtmltopdf /bin/libwkhtmltox.so /usr/local/lib/libwkhtmltox.so

WORKDIR /app

RUN gem install rails -v 7.1.3.4

COPY Gemfile* ./

RUN bundle install

COPY . .

RUN bundle binstubs --all

RUN { \
    echo "alias ll='ls -alF'"; \
    echo "alias la='ls -A'"; \
    echo "alias l='ls -CF'"; \
    echo "alias q='exit'"; \
    echo "alias c='clear'"; \
} >> $HOME/.bashrc

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
