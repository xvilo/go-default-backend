# Multi-stage build
FROM golang:1.22 AS builder

# Set target architecture (default to amd64)
ARG TARGETARCH=amd64

WORKDIR /app

# Copy source code
COPY . .

# Build the binary
RUN GOOS=linux GOARCH=$TARGETARCH go build -ldflags="-s -w" -o /default-backend .

# Minimal runtime image
FROM gcr.io/distroless/base-debian12

WORKDIR /

# Set target architecture (default to amd64)
ARG TARGETARCH=amd64

# Copy binary from builder stage
COPY --from=builder /default-backend /default-backend

# Expose port
EXPOSE 8080

# Run the application
CMD ["/default-backend"]
