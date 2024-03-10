# Apply Docker best practice 

- [Container image built as root](https://github.com/p-cap/dockering/blob/main/rootful-or-not/rootful-dockerfile)
``` 
# without explicitly declaring the user, the user is ROOT
FROM alpine:3.12
COPY . app-files/
COPY app-files show-user.sh app-files/
WORKDIR /app-files
RUN chmod 500 show-user.sh
ENTRYPOINT ["/bin/sh","show-user.sh"]
```
- [Container image built as a non-root user](https://github.com/p-cap/dockering/blob/main/rootful-or-not/not-rootful-deockerfile)
```
FROM alpine:3.12
COPY . app-files/

# the user is added and taking ownership of app-files folder
RUN adduser -D pcap && chown -R pcap app-files/

# add USER to enable user context
USER pcap

COPY app-files show-user.sh app-files/
WORKDIR /app-files
RUN chmod 500 show-user.sh
ENTRYPOINT ["/bin/sh","show-user.sh"]
``` 

- [container not writable but executable](https://github.com/p-cap/dockering/blob/main/not-writable-executable/not-writable-exectubles-dockerfile)
```
FROM alpine:3.12
COPY app-files/ /app

# set the permission to that user can execute the script
# this ensures that the permssion is set in the container image
RUN chmod 755 /app/test.sh
RUN adduser -D app

USER app
ENTRYPOINT /app/test.sh
```
NOTE: remember, when copying the files from the host, you will carry-over the permissions originally set. 

REF:
Top 20 Dockerfile best practices \
https://sysdig.com/blog/dockerfile-best-practices/
