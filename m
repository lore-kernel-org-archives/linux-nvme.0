From: wyung@micron.com (Winson Yung (wyung))
Date: Sun, 18 May 2014 11:55:05 +0000
Subject: [RFC PATCH] NVMe: Runtime suspend
Message-ID: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>

Hi, I am new to the mailing list in case my comment mention here was discussed in the past. Please let me know the past discussion thread if it exists. Here is my comment to the patch:

* How is the current NVMe power states defined by a storage device exposed/used in the kernel? I looked at the driver/block/nvme-scsi.c, and only can see that they were mapped to supporting scsi START STOP UNIT cmd inside nvme_trans_power_state(). So is it accurate to say that no (power management) code in linux kernel take advantage of these NVMe power states?

* I think your patch is a good idea, but you should consider to extend it such that it uses runtime power management to create a dynamic power reduction model based on the idleness of IO activity. For example, if the storage drive supports 3 NVMe power states (0, 1, 2), we can let nvme_runtime_suspend() to determine which NVMe power states to use among 0, 1 or 2 based on the IO activity. This way creates a more scalable solution that gives better balance between power saving and performance (i.e. exit latency) in the middle of D0 and D3.

* As for your observation of the potential issue, I think if a device is in suspended mode, driver should allowed to post a command to IO queue as long as the device can be awaken. Of course, the service of the command will be queued and delay serviced only after runtime resume is completed.

/Winson
