
# ION-DTN Docker Environment
The container runs the BSL tests for the ION-DTN environment.

### Container

| Task | Command |
| :--- | :--- |
| **Build and Start** | `docker compose up --build -d` |
| **Stop and Remove** | `docker compose down` |
| **Check Status** | `docker compose ps` |
| **View Live Logs** | `docker compose logs -f` |

## ION Specific Commands
These commands are executed inside the running containers to manage the DTN stack.