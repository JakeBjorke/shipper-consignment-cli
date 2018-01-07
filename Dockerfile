# consignment-cli

FROM golang:1.9.2 as builder
WORKDIR /go/src/github.com/jakebjorke/shipper-consignment-cli
COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -o consignment-cli -a -installsuffix cgo . 

FROM alpine:latest

RUN apk --no-cache add ca-certificates
RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/jakebjorke/shipper-consignment-cli/consignment-cli .
COPY --from=builder /go/src/github.com/jakebjorke/shipper-consignment-cli/consignment.json .

CMD [ "./consignment-cli" ]