#!/bin/bash

# Просто собираем веб-версию книги, локально.

stack install

book rebuild

# После этого в корне репозитория смотрим в каталог _site.