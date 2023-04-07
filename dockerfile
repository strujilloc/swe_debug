FROM python:3.9 as base
ENV PYTHONUNBUFFERED 0

WORKDIR /app

FROM base as build-phase

COPY requirements.txt .
COPY pyproject.toml .
COPY src src/

RUN pip install --upgrade pip
# RUN pip install keyrings.tmp.gcp_artifact_registry_auth
# ENV PIP_EXTRA_INDEX_URL https://asia-python.pkg.dev/recursive-research-core/recursive-common-pypi/simple/
RUN pip install --no-cache-dir -t packages .

FROM base as execution-phase

COPY --from=build-phase /app/packages packages
ENV PYTHONPATH packages
# Set the environment variable to run Flask in development mode
ENV FLASK_ENV=development

# Expose port 5000 for the Flask application to listen on
EXPOSE 3001

# Start the Flask application when the container is run
# CMD ["python", "app.py"]
CMD python -m recursiveai.app
# TODO: Install other runtime dependencies
# TODO: Copy aditionl files

# TODO: Replace with actual package
# CMD python -u -m template
