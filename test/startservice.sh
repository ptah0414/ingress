#!/bin/bash

a=nginx
b=1
# 시작하기 전에 ingress controller 배포해야함.


# nginx/http 배포
if [ $number -eq $b ] ;
then
        if [ "$webservice" == "$a" ];
        then
                mkdir default
                cd default
                #원래는 사용자에게 페이지 내용 받아야함
                echo "default page-nginx" > index.html
                kubectl create cm defaultcm --from-file index.html
                kubectl apply -f ~/test/nfs-nginx.yml

        else
                mkdir default
                cd default
                #원래는 사용자에게 페이지 내용 받아야함
                echo "default page-httpd" > index.html
                kubectl create cm defaultcm --from-file index.html
                kubectl apply -f ~/test/nfs-httpd.yml
        fi
else if [ "$webservice" = "$a" ];
        then
                mkdir ${pagename}
                cd ${pagename}
                #원래는 사용자에게 페이지 내용 받아야함
                echo "${pagename} page-nginx" > index.html
                kubectl create cm ${pagename}cm --from-file index.html
                ~/test/nginxmade.sh
                #ingress 파일에 추가
                echo "
        - path: /${pagename}
          pathType: Prefix
          backend:
            service:
              name: ${pagename}
              port:
                number: 80" >> ~/test/ingress-config.yml
        else
                mkdir ${pagename}
                cd ${pagename}
                echo "${pagename} page-http" > index.html
                kubectl create cm ${pagename}cm --from-file index.html
                ~/test/httpmade.sh #ingress 파일에 추가
                echo "
        - path: /${pagename}
          pathType: Prefix
          backend:
            service:
              name: ${pagename}
              port:
                number: 80" >> ~/test/ingress-config.yml
        fi
fi

kubectl apply -f ~/test/ingress-config.yml