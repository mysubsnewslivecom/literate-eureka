---
title: Setting up Nexus
---

### Reference 

* <https://www.youtube.com/watch?v=dpWxWr90MGI>

### Create data folder

```sh
mkdir /data/nexus-data && chown -R 200 /data/nexus-data
```

### Run docker image

```sh
export NEXUS_PORT=9010
export NEXUS_DATA=/data/nexus-data
docker volume create --name nexus-data
docker run -d -p ${NEXUS_PORT?}:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
export NEXUS_ADMIN_PASSWORD=$(docker exec nexus sh -c -l 'cat /nexus-data/admin.password')
```

### Write artifacts

```sh
export NEXUS_SERVER_IP_ADDRESS=127.0.0.1
export NEXUSCRED=$(echo -n 'admin:test1234' | base64)
export PORT_NUMBER=8081
export REPO_NAME=misc
export DIR_NAME=com/scripts/shell

```

### Code

#### Python

```python
import requests
from requests.auth import HTTPBasicAuth

url = "http://localhost:8081/service/rest/v1/components"

auth = HTTPBasicAuth(username="admin", password="test1234")

params = (
    ('repository', 'misc'),
)

payload = {
    'raw.directory': (None, 'com/scripts/shell'),  # folder structure you want in nexus
    'raw.asset1': ('git.sh', open('git.sh', 'rb')),
    'raw.asset1.filename': (None, 'git.sh'),  # this is the name you want to see in nexus
}

# response = requests.post(url, params=params, files=payload, auth=auth)

try:
    response = requests.post(url,
                             params=params,
                             files=payload,
                             auth=auth
                             )
    response.raise_for_status()

    if response.ok:
        print ("file uploaded")

except requests.exceptions.HTTPError as errh:
    raise ("Http Error:", errh)
    exit(1)
except requests.exceptions.ConnectionError as errc:
    print("Error Connecting:", errc)
    exit(1)
except requests.exceptions.Timeout as errt:
    print("Timeout Error:", errt)
    exit(1)
except requests.exceptions.RequestException as err:
    print("OOps: Something Else", err)
    exit(1)

```

#### Shell

```sh
curl -X 'POST' \
            'http://${SERVER_IP_ADDRESS}:${PORT_NUMBER}/service/rest/v1/componentsrepository=${REPO_NAME}' \
            -H 'accept: application/json' \
            -H 'Content-Type: multipart/form-data' \
            -H 'Authorization: Basic ${NEXUSCRED}' \
            -F 'raw.directory=${DIR_NAME}' \
            -F 'raw.asset1=@${FILE_NAME};type=application/x-zip-compressed' \
            -F 'raw.asset1.filename=${FILE_NAME}'
            
curl --fail -u user:password --upload-file file.zip 'https:/nexus-repository.claudiosteuernagel.com/repository/my-raw-repo/my-directory/file.zip'

export NEXUS_SERVER_IP_ADDRESS=127.0.0.1
export NEXUSCRED=$(echo -n 'linux:secret1234' | base64)
export PORT_NUMBER=9010
export REPO_NAME=com.scripts
export DIR_NAME=shell

for FILE_NAME in $(ls *.sh)
do
curl -fSsL -u $(echo $NEXUSCRED|base64 -d) --progress-bar \
--write-out "File: ${FILE_NAME} HTTPSTATUS: %{http_code}\n" \
--upload-file ${FILE_NAME} \
--url "http://${NEXUS_SERVER_IP_ADDRESS}:${PORT_NUMBER}/repository/${REPO_NAME}/${DIR_NAME}/${FILE_NAME}"
done

```
