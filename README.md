# FileHeron CLI

A simple file server

## Download

You can download the latest build from [Releases](https://github.com/horizech/fileheron/releases)

-   Note: Right now, builds are only available for Mac OSX. Windows and Linux versions coming soon.

## Usage

```
./fileheron -h localhost -p 8080 -r public -d true -l log.txt -s true -c server_chain.pem -k server_key.pem -u password

./fileheron --host localhost --port 8080 --root public --listDir true --logFile log.txt --ssl true --certificateChain server_chain.pem --serverKey server_key.pem --serverKeyPassword password
```

If the downloaded file does not show as executable, fix the permission like this:

```
chmod 755 ./fileheron
```

## Build

You can build the server yourself by using dart2native or dart compile which is part of [Dart SDK](https://dart.dev/get-dart).

-   Linux / MacOS

```
// Using dart2native
dart2native ./bin/main.dart -o ./build/fileheron

// Using dart compile
dart compile exe ./bin/main.dart -o ./build/fileheron
```

-   Windows

```
// Using dart2native
dart2native bin\main.dart -o build\fileheron.exe

// Using dart compile
dart compile exe bin\main.dart -o build\fileheron.exe
```

## Parameters

| Parameter              | Description               | Default Value | Possible Values |
| ---------------------- | ------------------------- | :-----------: | --------------- |
| host (-h)              | Hostname                  |   localhost   | valid address   |
| port (-p)              | Port                      |     8080      | valid port      |
| root (-r)              | Static folder             |    public     | valid folder    |
| listDir (-d)           | Show each call in console |     true      | true, false     |
| logFile (-l)           | Log file                  |     null      | log file name   |
| ssl (-s)               | SSL Mode                  |     false     | true, false     |
| certificateChain (-c)  | Certificate Chain         |     null      | valid file name |
| serverKey (-k)         | Server Key                |     null      | valid file name |
| serverKeyPassword (-u) | Server Key Password       |     null      | password        |
