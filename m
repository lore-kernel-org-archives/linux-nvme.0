From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 08:27:10 +0100
Subject: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
Message-ID: <b82fcfa1-4c8c-e834-b929-12411dd6e6ac@suse.de>

On 11/09/2017 06:44 PM, Christoph Hellwig wrote:
> This patch adds native multipath support to the nvme driver.  For each
> namespace we create only single block device node, which can be used
> to access that namespace through any of the controllers that refer to it.
> The gendisk for each controllers path to the name space still exists
> inside the kernel, but is hidden from userspace.  The character device
> nodes are still available on a per-controller basis.  A new link from
> the sysfs directory for the subsystem allows to find all controllers
> for a given subsystem.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/Kconfig     |   9 ++
>  drivers/nvme/host/Makefile    |   1 +
>  drivers/nvme/host/core.c      | 133 +++++++++++++++++++---
>  drivers/nvme/host/multipath.c | 255 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      |  57 ++++++++++
>  5 files changed, 440 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/nvme/host/multipath.c
> 
After much discussion I'm finally fine with this.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
