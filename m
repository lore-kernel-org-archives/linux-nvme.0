From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Wed, 25 Nov 2015 20:42:53 +0800
Subject: [PATCH 0/3] fixes fo LightNVM 
Message-ID: <1448455376-5020-1-git-send-email-ww.tao0320@gmail.com>

Hi

A couple of fixes.

Patch 1 add the missing lock aquire
Patch 2-3 handle the targets when corresponding underlying devices were removed


Wenwei Tao (3):
  lightnvm: missing nvm_lock acquire
  lightnvm: handle targets when corresponding nvm device exit
  nvme: change the interface between nvme and lightnvm

 drivers/lightnvm/core.c      | 140 ++++++++++++++++++++++++++++---------------
 drivers/nvme/host/lightnvm.c |  17 +++++-
 drivers/nvme/host/nvme.h     |   1 +
 drivers/nvme/host/pci.c      |  10 ++--
 include/linux/lightnvm.h     |   3 +
 5 files changed, 118 insertions(+), 53 deletions(-)

-- 
1.8.3.1
