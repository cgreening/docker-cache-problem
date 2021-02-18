This project recreates the issues with layers disappearing from images when using the `cache-from` argument.

To recreate run the following steps:

```
DOCKER_BUILDKIT=1 docker build -t cgreening/cache_problem:1 .  --build-arg BUILDKIT_INLINE_CACHE=1
docker push cgreening/cache_problem:1
docker run -it --entrypoint /bin/bash cgreening/cache_problem:1
root@f3b83bd929e6:/app# ls
Dockerfile  README.md  index.js  node_modules  package.json  yarn.lock
```

Clean up just like on the build machine:

```
docker system prune -a
```

Build again

```
DOCKER_BUILDKIT=1 docker build -t cgreening/cache_problem:2 .  --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from cgreening/cache_problem:1
docker push cgreening/cache_problem:2
docker run -it --entrypoint /bin/bash cgreening/cache_problem:2
root@f3b83bd929e6:/app# ls
Dockerfile  README.md  index.js  node_modules  package.json  yarn.lock
```

Clean up again:

```
docker system prune -a
```

Build again

```
DOCKER_BUILDKIT=1 docker build -t cgreening/cache_problem:3 .  --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from cgreening/cache_problem:2
docker push cgreening/cache_problem:3
docker run -it --entrypoint /bin/bash cgreening/cache_problem:3
root@462e81ea94e4:/app# ls
Dockerfile  README.md  index.js  package.json
```

You will see that there is no `node_modules` folder. This folder should have been created by the step:

```
RUN yarn
```
