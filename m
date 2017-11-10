From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 10:58:21 +0100
Subject: [PATCH 0/2] Two small follow-up patches for nvme multipathing
Message-ID: <1510307903-3346-1-git-send-email-hare@suse.de>

Hi all,

here are some small follow-up patches for nvme multipathing.
Patches are relative to hchs nvme-mpath branch.

Hannes Reinecke (2):
  nvme: add Kconfig option 'NVME_MULTIPATH_DEFAULT'
  nvme: expose subsys attribute to sysfs

 drivers/nvme/host/Kconfig     | 11 ++++++++++
 drivers/nvme/host/core.c      | 47 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  8 +++++++-
 3 files changed, 65 insertions(+), 1 deletion(-)

-- 
1.8.5.6
