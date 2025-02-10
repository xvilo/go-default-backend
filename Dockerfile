# Multi-stage build
FROM --platform=$BUILDPLATFORM golang:1.22 AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /app

COPY . .

RUN go mod download

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -ldflags="-s -w" -o /default-backend .

FROM gcr.io/distroless/base-debian12

WORKDIR /
COPY --from=builder /default-backend /default-backend

EXPOSE 8080
CMD ["/default-backend"]
