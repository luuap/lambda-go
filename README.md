# lambda-go

Testing out Lambda functions as a container image.

## Recreating a project like this

1. Create a go module with module path

   `go mod init github.com/luuap`

2. Add github.com/aws/aws-lambda-go as a dependency in go.mod

3. Write handler in main.go, import github.com/aws/aws-lambda-go/lambda

4. Create Dockerfile and docker-compose.yml

5. Create go.sum

   `go mod tidy`

## Running

`docker compose up`

`curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{ "message": "Hello" }'`

> `{"echo":"Hello"}`

## References

https://docs.aws.amazon.com/lambda/latest/dg/go-image.html

https://docs.aws.amazon.com/lambda/latest/dg/images-test.html