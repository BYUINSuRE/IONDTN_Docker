
# ION-DTN Docker Environment
The container compiles the latest tagged release of ION-DTN, version `ion-open-source-4.2.0-a.1`. Currently, it compiles and runs the `amshello` example from the ION-DTN repository.

### Container
To build and run the demo, showing logs: `docker compose up`

| Task | Command |
| :--- | :--- |
| **Build and Start** | `docker compose up --build -d` |
| **Stop and Remove** | `docker compose down` |
| **Check Status** | `docker compose ps` |
| **View Live Logs** | `docker compose logs -f` |
