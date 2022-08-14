FROM ruby:3.1.2

ARG PROJECT_NAME
ARG USER_NAME=ruby
ENV RUBYGEMS_VERSION=3.3.17
ENV TZ=Asia/Tokyo

RUN adduser ${USER_NAME}

COPY --chown=${USER_NAME} Gemfile Gemfile.lock /${PROJECT_NAME}/
WORKDIR /${PROJECT_NAME}
RUN --mount=type=secret,id=github-pkg-cred,required \
    BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$(cat /run/secrets/github-pkg-cred) \
    export BUNDLE_RUBYGEMS__PKG__GITHUB__COM \
    && gem update --system ${RUBYGEMS_VERSION} \
    && bundle install \
    && chown -R ${USER_NAME} ${GEM_HOME}

COPY --chmod=755 /docker/api/entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]

USER ${USER_NAME}
RUN mkdir -p /${PROJECT_NAME}/tmp/sockets

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
