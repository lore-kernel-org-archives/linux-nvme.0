From: mschoberg@micron.com (Michael Schoberg (mschoberg))
Date: Fri, 21 Sep 2018 16:32:19 +0000
Subject: linux-nvme: driver removal deadlock when device hot-removed
Message-ID: <MWHPR08MB2671C87514045AC3D85AAA5BC9120@MWHPR08MB2671.namprd08.prod.outlook.com>

I'm not sure if this is the correct forum, but hopefully someone can help instruct me on how to proceed towards resolving this issue.

I'm working on a problem that occurs when a nvme device is hot-removed while IO is occurring.? I see a driver deadlock during recovery or more precisely, the removal of the driver instance during the recovery attempt.? What seems to be happening is when the system calls the nvme timeout routine, it eventually calls outside the driver and runs into a mutex deadlock.? I'm running with a 4.18.8 kernel:

The code path appears as follows (note - the device has been removed so there is no possibility of it being recovered):

	nvme_timeout --> nvme_warn_reset

	nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff

*The pci_read_config_word() returns PCIBIOS_SUCCESSFUL when the returned values show the device is detached.? I'm not quite sure how the configuration read works with a detached device, but it's pretty clear the returned values are not valid.

Within nvme_timeout(), it begins the process to reset the controller:

	nvme_reset_ctrl --> nvme_reset_work --> nvme_remove_dead_ctrl --> nvme_kill_queues --> nvme_set_queue_dying --> revalidate_disk

The thread hits a mutex deadlock after returning back to fs/block_dev.c::revalidate_disk():? mutex_lock(&bdev->bd_mutex)

This is the point where the driver appears completely stuck and never recovers.? A power cycle or system reset is required to restore operation (reboot or shutdown hangs).? I'm not sure what within block_dev.c is holding bd_mutex that would cause the deadlock and therefore it's very possible there is a cleaner solution than what I am using.
