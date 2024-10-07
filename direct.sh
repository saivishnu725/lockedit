#!/bin/bash

sudo chattr -i ~/.zshrc
/usr/bin/nvim ~/.zshrc
sudo chattr +i ~/.zshrc
