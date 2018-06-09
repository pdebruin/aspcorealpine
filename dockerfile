FROM microsoft/dotnet:2.1-sdk-alpine AS build
WORKDIR /app

COPY *.sln .
COPY aspcorealpine/*.csproj ./aspcorealpine/
RUN dotnet restore

COPY aspcorealpine/. ./aspcorealpine/
WORKDIR /app/aspcorealpine
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine AS runtime
WORKDIR /app
COPY --from=build /app/aspcorealpine/out ./
ENTRYPOINT ["dotnet", "aspcorealpine.dll"]
