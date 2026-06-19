FROM rust:1.96 AS builder

WORKDIR /app

RUN rustup target add x86_64-unknown-linux-musl

COPY Cargo.toml Cargo.lock ./
COPY .cargo ./.cargo
COPY src ./src

RUN cargo build --release


FROM ubuntu:latest

COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/rikuinit /rikuinit

ENTRYPOINT [ "/rikuinit" ]
