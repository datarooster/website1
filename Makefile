build:
	docker build -t jekyl .
run:
	docker run -p4000:4000 --rm -v "$(pwd):/site" -ti jekyl