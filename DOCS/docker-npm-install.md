With full path + size (recommended)
RUN find . -type d -name node_modules -exec du -sh {} \;

If you want to list only nested ones (for debugging broken workspace installs)
RUN find . -type d -name node_modules | grep -v '^./node_modules$'

Print only file names inside each .bin directory
find . -type d -path "*/node_modules/.bin" -exec sh -c "ls {}" \;
 
docker exec -it <container> sh -c \
'find . -type d -name ".bin" -path "*/node_modules/.bin" -exec sh -c "echo {} && ls -al {}" \;'
