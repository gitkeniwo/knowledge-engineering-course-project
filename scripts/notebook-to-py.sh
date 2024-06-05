#!/bin/bash

!pip install -q nbconvert

jupyter nbconvert --to script --output-dir ./src/ ./notebooks/*.ipynb

