# syntax=docker/dockerfile:1
ARG RUBY_IMAGE_TAG
FROM ruby:${RUBY_IMAGE_TAG}

ARG PROJECT_NAME
ARG RUBYGEMS_VERSION
ARG USER_NAME=ruby
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

RUN adduser ${USER_NAME}

COPY --chown=${USER_NAME} Gemfile* /${PROJECT_NAME}/
WORKDIR /${PROJECT_NAME}
RUN --mount=type=secret,id=github-pkg-cred,required <<-EOF
	set -eu
	gem update --system ${RUBYGEMS_VERSION}
	export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$(cat /run/secrets/github-pkg-cred)
	bundle install
	chown -R ${USER_NAME} ${GEM_HOME}
EOF

RUN <<-EOF
	set -eu
	gem install solargraph-rails --pre
	solargraph download-core
	yard gems || exit 0
EOF

COPY --chmod=755 /.docker/api/entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]

USER ${USER_NAME}
RUN mkdir -p /${PROJECT_NAME}/tmp/sockets/

CMD ["bundle", "exec", "pumactl", "start"]
