# ffuf-docker
Oneliner to run ffuf scan against target URL using a good wordlist

## Running
```
docker run -v $(pwd)/reports:/var/reports onvio/ffuf-docker https://example.org
```
  
Example targets:
- https://ffuf.io.fi
- https://example.org

## Building
```
git clone git@github.com:onvio/ffuf-docker.git
cd ffuf-docker
docker build -t ffuf-docker .
docker run -v $(pwd)/reports:/var/reports ffuf-docker https://example.org
```

## Change wordlist
- Update Dockerfile to point to different wordlist and rebuild image

## Additional arguments
- Add to end of command as follows:   
`docker run -v $(pwd)/reports:/var/reports ffuf-docker https://example.org -mc 200 -fs 350`

## Headers
- The following headers are added in the `start.sh` script
    ```
    -H "X-Scanner: FFUF" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    ```
- Update, add, or delete headers as needed

## Outputs
Outputs will be saved in ./reports
  
| Report               | Description                                             |
|----------------------|---------------------------------------------------------|
| ffuf_scan.csv        | Full ffuf report in csv                                 |
| fuff.json            | JSON report for with Generic JSON warnings              |
