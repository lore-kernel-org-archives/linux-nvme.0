From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Sep 2017 10:18:10 -0600
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
Message-ID: <20170925161810.GD8463@localhost.localdomain>

On Mon, Sep 25, 2017@03:40:30PM +0200, Christoph Hellwig wrote:
> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
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
> The new block devices nodes for multipath access will show up as
> 
> 	/dev/nvm-subXnZ
> 
> where X is the local instance number of the subsystems, and Z is the index
> for the namespace.
> 
> To get persistent devices names the following lines can be added to
> /lib/udev/rules.d/60-persistent-storage.rules:
> 
> ---------------------------------- snip ----------------------------------
> KERNEL=="nvm-sub*[0-9]n*[0-9]", ATTR{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}"
> KERNEL=="nvm-sub*[0-9]n*[0-9]p*[0-9]", ENV{DEVTYPE}=="partition", ATTRS{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}-part%n"
> KERNEL=="nvm-sub*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*", ENV{ID_WWN}="$attr{wwid}"
> ---------------------------------- snip ----------------------------------
> 
> Note that these create the new persistent names.  Overriding the existing
> nvme ones would be nicer, but while that works for the first path, the
> normal rule will override it again for each subsequent path.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
