#!/bin/bash

# Kanata Configuration
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

sudo cp -r ./kanata.kbd /etc/kanata.kbd

sudo systemctl enable kanata.service   # enabling kanata service for starting up on bootup
sudo systemctl start kanata.service    # starting the service
sudo systemctl restart kanata.service  # optional: incase already running restarting for updating to new changes

