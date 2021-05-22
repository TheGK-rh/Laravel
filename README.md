# Laravel + Docker 環境

## 環境構築方法
**Laravelプロジェクト作成**

* DBの選択  
デフォルトではMySQLの使用を前提にしています。  
PostgreSQLを使用する場合は`docker-compose.yml`の`#MYSQL`をコメントアウトし、`#POSTGRESQL`のコメントアウトを外してください。
LaravelのDB設定は`MySQL`のため、PostgreSQLを使用する場合は設定を変更してください。

**M1 Macユーザーの方へ**  
2021.05.22時点  
Resettaをインストールしていない場合（インストールしない方がいいですが）、MySQLのDocker imageがエラーで使用できません。  
`docker-compose.yml`に記載している、`platform`のコメントアウトを外して使用してください。  
https://github.com/TheGK-rh/laravel/blob/166918b8114b4c459ab6ced7fc600f45a8dff11c/docker/docker-compose.yml#L27
```
platform: linux/x86_64　と指定することで、使用できます。
```

### 環境構築手順

1. .env.exampleの編集（必要に応じて変更してください。変更なしでも実行可能です。）
```
COMPOSE_PROJECT_NAME=プロジェクト名：任意のプロジェクト名に変更してください。
HTTP_PORT_HOST=HTTPアクセスのポート番号：他プロジェクトを重複するとエラーとなります。（デフォルトは9000を指定）

MySQLを使用する場合
MYSQL_DB_PORT=外部アクセスポート：他プロジェクトを重複するとエラーとなります。（デフォルトは13306を指定）
MYSQL_DATABASE=データベース名：任意のデータベース名に変更してください。
MYSQL_USER=ユーザー名：任意のユーザー名に変更してください。
MYSQL_PASSWORD=パスワード：任意のパスワードの変更してください。

PostgreSQLを使用する場合
POSTGRES_DB_PORT=外部アクセスポート：他プロジェクトを重複するとエラーとなります。（デフォルトは5432を指定）
POSTGRES_PASSWORD=パスワード：任意のパスワードの変更してください。
POSTGRES_DB=データベース名：任意のデータベース名に変更してください。
POSTGRES_USER=ユーザー名：任意のユーザー名に変更してください。
```

2. 下記コマンドを実行  
**必要なコマンドは下記コマンドが実行します。**
```
make create-project
```
コマンド実行完了後、http://localhost:${HTTP_PORT_HOST} にアクセスしてLaravelのデフォルトウェルカムページが表示されるか確認してください。  
デフォルトでは http://localhost:9000
