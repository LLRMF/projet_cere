# syntax = docker/dockerfile:1

# Étape de base avec Ruby
ARG RUBY_VERSION=3.0.0
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

# Configuration d'environnement
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test

# Étape de build (plus lourde, mais jetable)
FROM base as build

# Dépendances système pour les gems & JS
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libvips \
    libffi-dev \
    libsqlite3-dev \
    node-gyp \
    pkg-config \
    python-is-python3 \
    ca-certificates

# Node.js & Yarn
ARG NODE_VERSION=21.1.0
ARG YARN_VERSION=1.22.19
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "$NODE_VERSION" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# Installer les gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf /usr/local/bundle/ruby/*/cache

# Installer les dépendances JS
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copier le reste de l'app
COPY . .

# Precompile bootsnap et les assets
RUN bundle exec bootsnap precompile --gemfile && \
    SECRET_KEY_BASE=placeholder ./bin/rails assets:precompile

# Étape finale = image légère
FROM base

# Installer les outils requis pour l'exécution
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# Copier l'app depuis l'image de build
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Utilisateur non-root pour sécurité
RUN useradd -m rails && \
    chown -R rails:rails /rails
USER rails

# Entrée de conteneur
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server"]
