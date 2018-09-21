From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 21 Sep 2018 10:53:21 -0600
Subject: linux-nvme: driver removal deadlock when device hot-removed
In-Reply-To: <MWHPR08MB2671C87514045AC3D85AAA5BC9120@MWHPR08MB2671.namprd08.prod.outlook.com>
References: <MWHPR08MB2671C87514045AC3D85AAA5BC9120@MWHPR08MB2671.namprd08.prod.outlook.com>
Message-ID: <20180921165321.GA1405@localhost.localdomain>

On Fri, Sep 21, 2018@04:32:19PM +0000, Michael Schoberg (mschoberg) wrote:
> I'm not sure if this is the correct forum, but hopefully someone can
> help instruct me on how to proceed towards resolving this issue.
> 
> I'm working on a problem that occurs when a nvme device is hot-removed
> while IO is occurring.? I see a driver deadlock during recovery or
> more precisely, the removal of the driver instance during the recovery
> attempt.? What seems to be happening is when the system calls the nvme
> timeout routine, it eventually calls outside the driver and runs into
> a mutex deadlock.? I'm running with a 4.18.8 kernel:
> 
> The code path appears as follows (note - the device has been removed
> so there is no possibility of it being recovered):
> 
> 	nvme_timeout --> nvme_warn_reset

We shouldn't get to nvme_timeout on a surprise removal. If you have
native pcie hotplug capable slots, the path ought to be:

  pciehp_isr
   remove_board
    pciehp_unconfigure_device
     pci_remove_bus_device
      device_release_driver
       nvme_remove
        nvme_disable

And that should immediately clear outstanding IO and prevent new IO from
entering the driver.

Given what you're observing, I think your situation must be one of the
following:

 1. You don't have pcie hotplug capable hardware
 2. You don't have a pcie hotplug capable kernel 
 3. You are not using native PCIe hotplug with your platform
 
> 	nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> 
> *The pci_read_config_word() returns PCIBIOS_SUCCESSFUL when the
> returned values show the device is detached.? I'm not quite sure how
> the configuration read works with a detached device, but it's pretty
> clear the returned values are not valid.

Since you're seeing PCIBIOS_SUCCESSFUL, the host is actually dispatching
the config request to a non-existent device. The reply will be a PCIe
Unsupported Request since there is nothing backing the address you're
trying to read, and you will see this as an "all 1's completion" with
no other indication of failure.

> Within nvme_timeout(), it begins the process to reset the controller:
> 
> 	nvme_reset_ctrl --> nvme_reset_work --> nvme_remove_dead_ctrl --> nvme_kill_queues --> nvme_set_queue_dying --> revalidate_disk
> 
> The thread hits a mutex deadlock after returning back to fs/block_dev.c::revalidate_disk():? mutex_lock(&bdev->bd_mutex)
> 
> This is the point where the driver appears completely stuck and never
> recovers.? A power cycle or system reset is required to restore
> operation (reboot or shutdown hangs).? I'm not sure what within
> block_dev.c is holding bd_mutex that would cause the deadlock and
> therefore it's very possible there is a cleaner solution than what I
> am using.

I'm not sure what could be holding it either. Maybe it's a task waiting
for an entered request to complete, in which case we should have the
nvme driver drain entered requests to failure in this path. The following
should be safe:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 800ee9b345f3..7c1330986a6c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2233,7 +2233,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
 
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, true);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
--
