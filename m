From: keith.busch@intel.com (Keith Busch)
Date: Tue, 3 Jan 2017 10:30:49 -0500
Subject: Bug/Issue report: removing nvme device don't ack the target core
In-Reply-To: <fa67387b-14db-b828-ff2c-efc8c80e0072@mellanox.com>
References: <fa67387b-14db-b828-ff2c-efc8c80e0072@mellanox.com>
Message-ID: <20170103153048.GA21060@localhost.localdomain>

On Mon, Jan 02, 2017@04:07:58PM +0200, Max Gurtovoy wrote:
> I've noticed that in case I have nvme device configured and I decided to
> remove it by "echo 1 > /sys/bus/pci/drivers/nvme/<pci>/remove" then the nvme
> ctrl is freed. later on when I run "echo 1 > /sys/bus/pci/rescan" I get the
> same block device name (e.g nvme0n1) - Expected result.
> 
> Other test is when I do it with nvme target configured and /dev/nvme0n1 is
> assigned to a namespace as device_path. In that case the nvme target take
> another refcount on the ns (by calling blkdev_get_by_path) so the pci remove
> will not free the nvme ctrl accordinglly. In that case when I rescan the pci
> bus by "echo 1 > /sys/bus/pci/rescan" I get *different* block device name
> (e.g nvme1n1) to the same backing store device.
> 
> I wonder if it's a bug ?
> Maybe we need to notify all block device openers that something caused the
> device removal and call some callback funtion to release it's resources
> (maybe in del_gendisk).
> 
> If it's an expected behaviour, how should the initiator recover from it ? I
> don't see a way that his traffic will succeed in case we remove the pci
> device and bring it back again.

I think you'd need to open a different device that indirectly maps to
the nvme disk with some persisitent name, like by the device's unique
identifier, or a partition's uuid.

The nvme driver's only concern is to provide a unique name. For all it
knows, the nvme drive it binds to after your pci rescan is a completely
different drive from the one it previously deleted, so it can't rebind
it the previous name while it's still in use by something else.
