# ICD-11 container with configurable API URL

This is image extends the World Health Organization's ICD-11 image 
[whoicd/icd11_sw_1904_mms_en](https://hub.docker.com/r/whoicd/icd11_sw_1904_mms_en)

It introduces an new environment variable which allows a user of the image to set the API endpoint that the 
included embedded coding tool will 'point' at.

It also includes a docker-compose project that provides an icd-11 api instance for use in production.
This is specifically used in our Tryton ICD-11 project.

Take a look at https://github.com/alteroo/trytond_health_icd11

## Usage

- Make sure you have docker and docker-compose installed.
- In the icd11.env set the API_BASE_URL to a URL on which your API can called.


### Stopping and Starting
#### Starting
```
docker-compose up -d
```
#### monitoring
To see running processes inside the container, use `docker-compose top`
```
docker-compose top
```
You know it is running when elastic search has started, you'll see output like this:
```
3145   1000   0:56   /usr/bin/java -Xms256m -Xmx1g -Djava.awt.headless=true -XX:+UseParNewGC                
                     -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75                          
                     -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError                     
                     -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 -Djna.nosys=true -Xms2g -Xmx2g            
                     -Des.path.home=/usr/share/elasticsearch -cp                                            
                     /usr/share/elasticsearch/lib/elasticsearch-2.4.4.jar:/usr/share/elasticsearch/lib/*    
                     org.elasticsearch.bootstrap.Elasticsearch start  
```
#### Stopping
```
docker-compose down
```

# Test it
To test the API, use this curl command:
```
curl --location --request GET 'http://localhost:7654/icd/release/11/2019-04/mms/375810888' \
--header 'Accept: application/json' \
--header 'api-version: v2' \
--header 'accept-language: en' \
--header 'releaseId: 2019-04'
```

The expected output will look something like this:
```
{"@context":"http://id.who.int/icd/contexts/contextForLinearizationEntity.json","@id":"http://id.who.int/icd/release/11/2019-04/mms/375810888","parent":["http://id.who.int/icd/release/11/2019-04/mms/1215034670"],"child":["http://id.who.int/icd/release/11/2019-04/mms/1773711561","http://id.who.int/icd/release/11/2019-04/mms/375810888/other","http://id.who.int/icd/release/11/2019-04/mms/375810888/unspecified"],"browserUrl":"https://icd.who.int/browse11-2018/l-m/en#/http%3a%2f%2fid.who.int%2ficd%2fentity%2f375810888","code":"MG50.3","source":"http://id.who.int/icd/entity/375810888","classKind":"category","postcoordinationScale":[{"@id":"http://id.who.int/icd/release/11/2019-04/mms/375810888/postcoordinationScale/hasCausingCondition","axisName":"http://id.who.int/icd/schema/hasCausingCondition","requiredPostcoordination":"true","allowMultipleValues":"AllowAlways","scaleEntity":["http://id.who.int/icd/release/11/2019-04/mms/1435254666","http://id.who.int/icd/release/11/2019-04/mms/1630407678","http://id.who.int/icd/release/11/2019-04/mms/1766440644","http://id.who.int/icd/release/11/2019-04/mms/1954798891","http://id.who.int/icd/release/11/2019-04/mms/21500692","http://id.who.int/icd/release/11/2019-04/mms/334423054","http://id.who.int/icd/release/11/2019-04/mms/274880002","http://id.who.int/icd/release/11/2019-04/mms/1296093776","http://id.who.int/icd/release/11/2019-04/mms/868865918","http://id.who.int/icd/release/11/2019-04/mms/1218729044","http://id.who.int/icd/release/11/2019-04/mms/426429380","http://id.who.int/icd/release/11/2019-04/mms/197934298","http://id.who.int/icd/release/11/2019-04/mms/1256772020","http://id.who.int/icd/release/11/2019-04/mms/1639304259","http://id.who.int/icd/release/11/2019-04/mms/1473673350","http://id.who.int/icd/release/11/2019-04/mms/30659757","http://id.who.int/icd/release/11/2019-04/mms/577470983","http://id.who.int/icd/release/11/2019-04/mms/714000734","http://id.who.int/icd/release/11/2019-04/mms/1306203631","http://id.who.int/icd/release/11/2019-04/mms/223744320","http://id.who.int/icd/release/11/2019-04/mms/1843895818","http://id.who.int/icd/release/11/2019-04/mms/435227771","http://id.who.int/icd/release/11/2019-04/mms/850137482","http://id.who.int/icd/release/11/2019-04/mms/1249056269","http://id.who.int/icd/release/11/2019-04/mms/1596590595"]}],"title":{"@language":"en","@value":"Antibiotic resistant Haemophilus influenzae"},"codingNote":{"@language":"en","@value":"In case of multiple resistances, code each one separately if listed below."}}
```

If you see this output, the api is not running yet
```
<html>
<head><title>502 Bad Gateway</title></head>
<body bgcolor="white">
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.14.2</center>
</body>
</html>
```
