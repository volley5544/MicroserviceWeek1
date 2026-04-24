# ---------- Stage 1: Test ----------
FROM dart:3.10.4 AS tester

WORKDIR /app

COPY pubspec*.yaml ./
RUN dart pub get

COPY . .

RUN dart test

# ---------- Stage 2: Production ----------
FROM dart:3.10.4

WORKDIR /app

COPY pubspec*.yaml ./
RUN dart pub get

COPY . .

EXPOSE 6044

CMD ["dart", "run", "lib/main.dart"]