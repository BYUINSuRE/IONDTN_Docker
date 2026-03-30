
# ION-DTN Docker Environment


The container only works for two nodes for the ION implementation of AMS. These nodes (`node1` and `node2`) simulate the bundle protocol. 


### Container

| Task | Command |
| :--- | :--- |
| **Build and Start** | `sudo docker-compose up --build -d` |
| **Stop and Remove** | `sudo docker-compose down` |
| **Check Status** | `sudo docker-compose ps` |
| **View Live Logs** | `sudo docker-compose logs -f` |

---

## ION Specific Commands
These commands are executed inside the running containers to manage the DTN stack.

### Connectivity Testing

* **The `bping` Test** The primary way to verify the link between nodes.
  ```bash
  sudo docker exec -it node1 bping ipn:1.1 ipn:2.1