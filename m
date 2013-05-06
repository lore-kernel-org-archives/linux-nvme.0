From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 May 2013 17:03:30 -0600
Subject: [PATCH 0/5] NVMe: Power management set
Message-ID: <1367881415-7978-1-git-send-email-keith.busch@intel.com>

This set adds pci suspend/resume. The initial patches in this set are
just moving around some of the initialization functions so they can be
reused from a suspend/resume context as well as probe/remove.

Keith Busch (5):
  NVMe: Group pci related actions in functions
  NVMe: Separate queue alloc/free from create/delete
  NVMe: Separate controller init from disk discovery
  NVMe: Use normal shutdown
  NVMe: Add pci suspend/resume driver callbacks

 drivers/block/nvme-core.c |  362 ++++++++++++++++++++++++++++++++-------------
 include/linux/nvme.h      |    2 +
 2 files changed, 261 insertions(+), 103 deletions(-)
