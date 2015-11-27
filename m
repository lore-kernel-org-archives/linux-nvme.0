From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Fri, 27 Nov 2015 12:09:41 +0800
Subject: [PATCH v2 0/3] fixes for LightNVM
Message-ID: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>

Hi Matias
A couple of fixes based on 4.4rc2

Patch 1: the locking issue

move codes 'register with device with a supported manager'
into a funtion.
But I think iterate over a list to register nvm device
with a manger is not a good idea, since we can blocked
in manager's register_mgr function while holding nvm_lock.

Patch 2: handle targerts when underlying devices were removed

free dev when exited

call target type's exit function when target creation was aborted
due to nvm device exit.

Patch 3: change the interface between nvme and lightnvm

remove the unnecessary nvme_ns->type set to zero

Wenwei Tao (3):
  lightnvm: missing nvm_lock acquire
  lightnvm: handle targets when corresponding nvm device exit
  nvme: change the interface between nvme and lightnvm

 drivers/lightnvm/core.c      | 197 ++++++++++++++++++++++++++-----------------
 drivers/nvme/host/lightnvm.c |  17 +++-
 drivers/nvme/host/nvme.h     |   1 +
 drivers/nvme/host/pci.c      |   7 +-
 include/linux/lightnvm.h     |   3 +
 5 files changed, 143 insertions(+), 82 deletions(-)

-- 
1.8.3.1
