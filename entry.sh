#!/bin/sh

# Check presence of the runtime API (host and port), if not, then use the Runtime Interface Emulator (RIE)
# else just run it directly since Go runtime does not need Runtime Interface Client (RIC)
# Notes: - -z is negation
#        - $@ is all of the parameters passed to the script
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
  exec /usr/bin/aws-lambda-rie "$@"
else
  exec "$@"
fi  