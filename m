From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 2 Jan 2017 16:07:58 +0200
Subject: Bug/Issue report: removing nvme device don't ack the target core
Message-ID: <fa67387b-14db-b828-ff2c-efc8c80e0072@mellanox.com>

hi Christoph/Jens/Sagi,

I've noticed that in case I have nvme device configured and I decided to 
remove it by "echo 1 > /sys/bus/pci/drivers/nvme/<pci>/remove" then the 
nvme ctrl is freed. later on when I run "echo 1 > /sys/bus/pci/rescan" I 
get the same block device name (e.g nvme0n1) - Expected result.

Other test is when I do it with nvme target configured and /dev/nvme0n1 
is assigned to a namespace as device_path. In that case the nvme target 
take another refcount on the ns (by calling blkdev_get_by_path) so the 
pci remove will not free the nvme ctrl accordinglly. In that case when I 
rescan the pci bus by "echo 1 > /sys/bus/pci/rescan" I get *different* 
block device name (e.g nvme1n1) to the same backing store device.

I wonder if it's a bug ?
Maybe we need to notify all block device openers that something caused 
the device removal and call some callback funtion to release it's 
resources (maybe in del_gendisk).

If it's an expected behaviour, how should the initiator recover from it 
? I don't see a way that his traffic will succeed in case we remove the 
pci device and bring it back again.

thanks,
Max.
