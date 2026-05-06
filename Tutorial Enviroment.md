# Reproducible Environment Setup with Docker

This guide describes how to build and run the containerized environment used in this research. The setup is based on Docker and is intended to ensure full reproducibility of the experimental results presented in the associated paper.

---

## Prerequisites

Before proceeding, ensure the following software is installed on your system:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows / macOS / Linux)
- A terminal or command prompt with access to the directory containing the project files

---

## Repository Structure

The root directory of this repository must contain the following files:

```
/
├── Dockerfile
├── .dockerignore
├── requirements.txt
└── main_cicids.ipynb
```

> **Note:** Any dataset files required for execution should also be placed in this directory before building the image.

---

## Step 1 — Build the Docker Image

Open a terminal and navigate to the project's root directory:

```bash
cd /path/to/your/project
```

Then, build the Docker image using the following command:

```bash
docker build -t tutorial-cicids .
```

This command will:

1. Pull the base Python 3.11 slim image
2. Install the required system-level dependencies
3. Install all Python packages listed in `requirements.txt`
4. Copy the project files into the container image

> The build process may take several minutes on the first execution, as it downloads and installs all dependencies. Subsequent builds will be significantly faster due to Docker's layer caching mechanism.

---

## Step 2 — Run the Container (via Docker Desktop)

After the build completes, the image `tutorial-cicids` will be listed under the **Images** tab in Docker Desktop.

1. Click the **Run** button (▶) next to the image
2. Click **Optional settings** to expand the configuration panel
3. Fill in the fields as follows:

**Container name:**
```
tutorial-cicids
```

**Ports:**

| Host Port | Container Port |
|-----------|---------------|
| `8888`    | `8888/tcp`    |

**Volumes:**

| Host Path | Container Path |
|-----------|---------------|
| `/path/to/your/project` | `/app` |

> For **Host path**, click the three-dot menu (`···`) and select the folder containing your project files (i.e., the same directory with `Dockerfile`, `requirements.txt`, `main_cicids.ipynb`, and the dataset).

4. Click **Run** to start the container

---

## Step 3 — Access the Jupyter Notebook

Once the container is running:

1. In Docker Desktop, open the container's **Logs** tab
2. Locate a URL beginning with `http://127.0.0.1:8888/` and click it, or copy and paste it into your browser

The Jupyter Notebook interface will open in your browser, displaying the project files mounted from your local directory.

3. Open `main_cicids.ipynb` by double-clicking on it

---

## Dependency Overview

The following Python libraries are used in this project and are automatically installed inside the container:

| Package | Version | Purpose |
|---------|---------|---------|
| `pandas` | 2.2.2 | Data manipulation and preprocessing |
| `numpy` | 1.26.4 | Numerical computation |
| `scikit-learn` | 1.5.0 | Machine learning algorithms |
| `scipy` | 1.13.1 | Scientific computing utilities |
| `matplotlib` | 3.9.0 | Data visualization |
| `seaborn` | 0.13.2 | Statistical visualization |
| `joblib` | 1.4.2 | Parallel processing and model persistence |
| `notebook` | 7.1.2 | Jupyter Notebook server |

---

## Notes on Reproducibility

- All library versions are pinned in `requirements.txt` to guarantee consistent behavior across different host machines and operating systems.
- The volume mount (`/app`) ensures that any modifications made to the notebook inside the container are directly reflected in the host filesystem, preventing data loss when the container is stopped.
- The Jupyter server is configured without authentication token (`--NotebookApp.token=''`) for ease of access in a local research environment. This setting should **not** be used in production or publicly exposed deployments.

---

## Stopping the Container

To stop the running container, either:

- Click the **Stop** button (■) in Docker Desktop, or
- Run the following command in the terminal:

```bash
docker stop tutorial-cicids
```

---

## Citation

If you use this environment in your research, please cite the associated paper accordingly.
