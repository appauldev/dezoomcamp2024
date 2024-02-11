FROM mageai/mageai:latest

ARG USER_CODE_PATH=/home/src/${PROJECT_NAME}

# commenting poetry installation because I thought it would be relevant with Mage dependency management
# # Default to the latest version of Poetry
# ARG POETRY_VERSION=""

# ENV POETRY_VERSION=${POETRY_VERSION}
# ENV POETRY_HOME="/opt/poetry"
# ENV POETRY_VIRTUALENVS_IN_PROJECT=true
# ENV POETRY_NO_INTERACTION=1

# ENV PATH="$POETRY_HOME/bin:$PATH"

# RUN curl -sSL https://install.python-poetry.org | python3 -

# WORKDIR /home/src/${PROJECT_NAME}
# COPY poetry.lock pyproject.toml ./

# RUN poetry install --no-interaction --no-ansi

# Note: this overwrites the requirements.txt file in your new project on first run. 
# You can delete this line for the second run :) 
COPY requirements.txt ${USER_CODE_PATH}requirements.txt 

RUN pip3 install -r ${USER_CODE_PATH}requirements.txt