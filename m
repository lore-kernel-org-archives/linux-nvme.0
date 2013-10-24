From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Oct 2013 11:53:51 -0600
Subject: [PATCHv2 0/2] NVMe: Controller reset handling
Message-ID: <1382637233-26017-1-git-send-email-keith.busch@intel.com>

This obsoletes this set: 

http://merlin.infradead.org/pipermail/linux-nvme/2013-September/000392.html

I'm doing a lot less with this set than I previous attempts and can
worry about the other optimizations if these are okay.

Differences from previous version:

Now calling pci_stop_and_remove_bus_device in line with the work task
when the driver fails to reinitialize the controller instead of spawning
a new thread. This just required extra care to remove the device from
the dev_list the kthread loops over before queueing the work.

If the device enables but can't perform IO on a resume attempt, now
removes the IO queues and namespaces, but leaves the character device
up for management.

Keith Busch (2):
  NVMe: Reset failed controller
  NVMe: Abort timed out commands

 drivers/block/nvme-core.c |  138 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/nvme.h      |    3 +
 include/uapi/linux/nvme.h |   11 ++++
 3 files changed, 140 insertions(+), 12 deletions(-)

-- 
1.7.10.4
