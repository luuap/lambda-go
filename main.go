package main

import (
  "context"
  // Note: The lambda Go runtime does not need a separate Runtime Interface Client (RIC),
  //       unlike in a NodeJS runtime, where you need to go through the client to send/recieve messages.
  //       This package includes implementation of the runtime interface.
  "github.com/aws/aws-lambda-go/lambda"
  "log"
)

type MyEvent struct {
  Message string `json:"message"`
}

type MyResponse struct {
  Echo string `json:"echo"`
}

func HandleRequest(ctx context.Context, event MyEvent) (MyResponse, error) {
  log.Printf("EVENT: %s", event)
  return MyResponse{Echo: event.Message}, nil
}

func main() {
  lambda.Start(HandleRequest)
}

