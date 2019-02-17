init: clean
	docker-compose up -d db
	docker-compose run --rm db bash -c "false; while (($? > 0)); do sleep 1; psql -U pleroma -c 'CREATE EXTENSION IF NOT EXISTS citext;' 2> /dev/null; done"
	docker-compose run --rm pleroma mix pleroma.instance gen
	docker-compose run --rm pleroma mix ecto.migrate
	docker-compose down

clean:
	docker-compose kill
	docker-compose rm -f
