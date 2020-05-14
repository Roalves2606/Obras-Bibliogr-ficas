# Desafio
## Obras Bibliográficas



Quando se lista o nome de autores de livros, artigos e outras publicações é comum que se apresente o nome do autor ou dos autores da seguinte forma: sobrenome do autor em letras maiúsculas, seguido de uma vírgula e da primeira parte do nome apenas com as iniciais maiúsculas.

Por exemplo:
* SILVA, Joao
* COELHO, Paulo
* ARAUJO, Celso de

Seu desafio é fazer um programa que leia um número inteiro correspondendo ao número de nomes que será fornecido, e, a seguir, leia estes nomes (que podem estar em qualquer tipo de letra) e imprima a versão formatada no estilo exemplificado acima.

As seguintes regras devem ser seguidas nesta formatação:
* o sobrenome será igual a última parte do nome e deve ser apresentado em letras maiúsculas;
* se houver apenas uma parte no nome, ela deve ser apresentada em letras maiúsculas (sem vírgula): se a entrada for “ Guimaraes” , a saída deve ser “ GUIMARAES”;
* se a última parte do nome for igual a "FILHO", "FILHA", "NETO", "NETA", "SOBRINHO", "SOBRINHA" ou "JUNIOR" e houver duas ou mais partes antes, a penúltima parte fará parte do sobrenome. Assim: se a entrada for "Joao Silva Neto", a saída deve ser "SILVA NETO, Joao" ; se a entrada for "Joao Neto" , a saída deve ser "NETO, Joao";
* as partes do nome que não fazem parte do sobrenome devem ser impressas com a inicial maiúscula e com as demais letras minúsculas;
* "da", "de", "do", "das", "dos" não fazem parte do sobrenome e não iniciam por letra maiúscula.

# Resolution

## Prerequisites

* Ruby 2.6.5
* Rails 6.0.1
* Postgresql database

## Installing

Clone the repository

- with ssh
```shell
git clone git@github.com:Roalves2606/Obras-Bibliogr-ficas.git
```
- with https
```shell
git clone https://github.com/Roalves2606/Obras-Bibliogr-ficas.git
```

Copy the environment variables
```shell
cd Obras-Bibliogr-ficas
cp .env.sample .env
```

#### Using Docker

Setup the project using docker-compose
```shell
docker-compose build
docker-compose up -d
```

Enter the project shell
```shell
docker exec -it author-list-challenge /bin/bash
```


Setup the project database (inside docker)
```shell
bundle exec rails db:setup
```

Start the application

```shell
bundle exec rails s -p 3000 -b 0.0.0.0
```

#### Without Docker

Assuming that you have installed RoR environment (you can do it following this [link](https://gorails.com/setup/ubuntu/19.10))

Install all dependencies

```shell
bundle install
```

Start the application

```shell
bundle exec rails s -p 30000 -b 0.0.0.0
```

## Running Application
The best way to use this application is with [Postman](https://www.postman.com/downloads/)
![full postiman](/public/images/full_postiman.png)

####  First step
Set the correct method and and url for your request
 - method: POST
 - URl: http://localhost:3000/api/v1/author_list

![postman_request_url](/public/images/postman_request_url.png)

####  Second step
Pass the appliction/json Content-Type in the headers
 - key: Content-Type
 - value: application/json

![set_postman_header](/public/images/set_postman_header.png)

### Third step
Now, in the `Body` tab, select the `raw` option and anter your author list in this format
```json
{
	"author_list":
		{
			"records": **records_number**,
			"original_list":
				[**author_name_array**]
		}
}
```
You can use this sample if you like
```json
{
	"author_list":
		{
			"records": "6",
			"original_list":
				[
					"Rodrigo Nunes",
					"Mariana da Silva",
					"Roberta Andrade Filha",
					"Maria",
					"Carlos dos Santos Junior",
					"José Neto"
				]
		}
}
```
Now click `Send`. You can see the response on the bottom in the `Body` option.

![request_image](/public/images/request_image.png)

## Running tests
```shell
docker exec -it author-list-challenge bundle exec rspec
```
or

```shell
docker exec -it author-list-challenge /bin/bash
```

```shell
bundle install
```
```shell
bundle exec rspec
```

### Gems used
- **pg** => PostgreSQl is the database that i am most used to, and have the most experience.
- **pry** => I prefer pry over byebug, for cleaner debugging and with more options.
- **rubocop-performance** => Used to enforce best practices, performance wise, when coding.
- **rubocop-rails** => Used for enforce Rails best practices.
- **rubocop-rspec** => Used for enforce RSpec best practices.
- **rspec-rails** => Testing framework for rails
- **factory_bot_rails** => Used to automate object creation for tests.
- **faker** => Used to generate random data.
- **shoulda-matchers** => Used to simplify creation of some tests

- *All other gems were added by default*
### Thanks!
