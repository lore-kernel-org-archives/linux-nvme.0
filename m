From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jun 2013 14:30:54 -0600
Subject: [PATCHv3 0/5] NVMe: Power management patch set 
Message-ID: <1372105859-27850-1-git-send-email-keith.busch@intel.com>

This adds power management to the NVMe devices.

I ran this on some real devices and found some errors from the previous
patch that could occur if the resume fails, but not many changes from
the previous set.

v2->v3:

Hand merge to latest head.

Additional checks when releasing the pci resources in case it happens
twice. This could occur if the module is unloaded after the device
failed to initialize on resume.

If the resume fails, free all the queues and check for a null queue
before issuing IO so that IO can not be sent to the block device if the
controller failed to re-initialize. I tried deleting the gendisks too,
but resume never completed when an error was forced with that code. Not
entirely sure why that happened.

Additional error checking on ioremap.

Use SIMPLE_DEV_PM_OPS instead of UNIVERSAL_DEV_PM_OPS. I don't think we
want to use these for runtime suspend/resume on an NVMe device.

Keith Busch (5):
  NVMe: Group pci related actions in functions
  NVMe: Separate queue alloc/free from create/delete
  NVMe: Separate controller init from disk discovery
  NVMe: Use normal shutdown
  NVMe: Add pci suspend/resume driver callbacks

 drivers/block/nvme-core.c |  408 +++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h      |    2 +
 2 files changed, 287 insertions(+), 123 deletions(-)
