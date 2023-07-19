#!/usr/bin/env bash

sites=$(wp --skip-plugins --skip-themes --quiet site list --field=url 2> /dev/null)
plugins=$(wp --skip-plugins --skip-themes  --quiet plugin list --field=name 2> /dev/null)
for plugin in $plugins; do
  echo -n "${plugin},"

  for url in $sites; do
     wp --skip-plugins --skip-themes --quiet plugin is-active "${plugin}" --url="${url}" 2> /dev/null
     if [[ $? -eq 0 ]]; then

        echo -n "${url} | "

     fi
  done

  echo -ne "\n"

done
