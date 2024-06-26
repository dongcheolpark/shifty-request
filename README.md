# shifty-request
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://github.com/Shopify/ruby-style-guide)

비 공식적인 시프티 출퇴근 기록 수정 요청 도구입니다.

유연 출퇴근제로 인하여 공식적인 회사 출퇴근 시각과 다르게 저장되어 있는 기록들에 대해 한번에 수정 요청을 보낼 수 있습니다.

## 설치법

`Ruby 3.1.2`, `Bundler`가 필요합니다. RVM을 사용하고 있다면 다음 명령어를 터미널에 입력하세요.

```shell
rvm use
```

`Bundler`는 `Ruby`를 설치하면 같이 설치됩니다. 의존성 패키지(Gem)을 설치하기 위해 다음 명령어를 입력하세요. 

```shell
bundle install
```

## 실행법

실행하기 전에 `.env` 파일이 제대로 입력되어 있는지 확인하세요. 만약 `.env` 파일이 없다면 `.env.example` 파일을 복사해 새로 만듭니다.

`COOKIE` 값을 채우기 위해 [시프티 홈페이지에](https://shiftee.io) 로그인 한 후 개발자 도구를 통해 쿠키 값을 가져옵니다. 
본인 계정의 권한 체크를 위해 필요합니다. `.env` 파일에 채워넣습니다.

출퇴근 기록 수정 요청을 웹에서 한번 보내보고 요청의 Payload를 확인하여 승인권자의 ID와 자신의 ID를 가져옵니다. 마찬가지로 `.env` 파일에 채워넣습니다.

도구를 실행하려면 다음 명령어를 입력하세요.

```shell
rake run
```

## Contributing

여러분의 기여를 기다립니다. 자유롭게 Issue 및 PR을 오픈해주세요.
