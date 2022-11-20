# ffuf-generic
Oneliner to run ffuf scan against target URL using a good wordlist

This is akin to simply running `ffuf` at the command line - without having to actually install ffuf.  
All options need to be provided as arguments:
- `-u <target URL>`
- `-w <wordlist>`
- ... any other required arguments


## Running
Switch to the wordlist directory and run the container:
```
cd <wordlist directory>
docker run -v $(pwd):/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> <any other ffuf arguments>
```
Alternatively, run from any location, but specify the full or relative path of the wordlist directory on the host filesystem:
- full:
    ```
    docker run -v /usr/share/wordlists/SecLists/Discovery/Web-Content:/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> <any other ffuf arguments>
    ```
- relative (e.g. assumes already in `/usr/share/wordlists`):
    ```
    docker run -v $(pwd)/SecLists/Discovery/Web-Content:/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> <any other ffuf arguments>
    ```
  
### Running with report output
Switch to the wordlist directory and run the container as above, but provide a volume for the report output as well:
```
cd <wordlist directory>
docker run -v ~/reports:/var/reports -v $(pwd):/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> <any other ffuf arguments>
```

## Building
```
git clone git@github.com:sttuartt/ffuf-docker.git
cd ffuf-generic
docker build -t ffuf-generic .
```

## Change wordlist
- The wordlist is **not** built into the image - this must be provided as part of the arguments - see [Running](#running) above

## Additional arguments
- Add to end of command as follows:   
`docker run -v ~/reports:/var/reports -v $(pwd):/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> -mc 200 -fw 70 -fs 351`

## Headers
- There are no headers included by default - these must be provided as part of the arguments:  
`docker run -v ~/reports:/var/reports -v $(pwd):/opt/ffuf/wordlists sttuartt/ffuf-generic -u https://example.org -w wordlists/<list name> -mc 200 -fw 70 -fs 351 -H "X-Scanner: FFUF" -H "User-Agent: ..."`

## Outputs
Outputs will be saved in the location specified in the `volume` argument provided - e.g. `~/reports`
  
| Report | Description |
|---|---|
| ffuf_scan_\<timestamp\>.csv | Full ffuf report in csv |
| fuff_vulnerabilities_\<timestamp\>.json | JSON report for with Generic JSON warnings |
