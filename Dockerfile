FROM alpine:3.14 AS build

# Tutorial: https://docs.aws.amazon.com/lambda/latest/dg/go-image.html

# install build tools
RUN apk add go git
# download modules directly 
RUN go env -w GOPROXY=direct

# cache dependencies
COPY go.mod go.sum ./
RUN go mod download 

# build
COPY . .
RUN go build -o /main

# copy artifacts to a clean image
FROM alpine:3.14 AS prod
COPY --from=build /main /main
ENTRYPOINT [ "/main" ]  

# (Optional) Add Lambda Runtime Interface Emulator and use a script in the ENTRYPOINT for simpler local runs
FROM alpine:3.14 AS dev
COPY --from=build /main /main
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie
COPY entry.sh /
RUN chmod 755 /entry.sh
ENTRYPOINT [ "/entry.sh" ]

# specify the handler
CMD [ "/main" ]