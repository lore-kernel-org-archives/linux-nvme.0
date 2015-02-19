From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Feb 2015 17:30:47 +0000 (UTC)
Subject: [PATCH] NVMe: Check for Extended metadata in ioctl path
In-Reply-To: <1424345859-4002-1-git-send-email-sathya.m@samsung.com>
References: <1424345859-4002-1-git-send-email-sathya.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1502191707130.32385@localhost.lm.intel.com>

On Thu, 19 Feb 2015, Sathayavathi M wrote:
> From: Sathyavathi M <sathya.m at samsung.com>
>
> In NVME_IOCTL_SUBMIT_IO the check for the extended metadata is missing.
> Currently, whenever an i/o request with extended metadata is issued,
> io.metadata has to be assigned a dummy addr. If this is not assigned then the
> check fails and returns error. This patch fixes this issue and also adds checks
> at necessary places for extended metadata.
>
> Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
> ---
> drivers/block/nvme-core.c | 11 ++++++++---
> include/linux/nvme.h      |  1 +
> include/uapi/linux/nvme.h |  4 ++++
> 3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 3eaa0be..a632d78 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1595,13 +1595,15 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> 	struct nvme_iod *iod, *meta_iod = NULL;
> 	dma_addr_t meta_dma_addr;
> 	void *meta, *uninitialized_var(meta_mem);
> +	bool ext_lba = ns->flbas & EXT_LBA;
>
> 	if (copy_from_user(&io, uio, sizeof(io)))
> 		return -EFAULT;
> 	length = (io.nblocks + 1) << ns->lba_shift;
> 	meta_len = (io.nblocks + 1) * ns->ms;

If you're using extended, the 'length' you're using for get_user_pages
and setup_prps is wrong. You need to add the meta_len to it since we
expect the buffer has the metadata spliced into user data.

This function (and this driver for that matter) didn't expect to deal
with extended lba's, and we have bigger problems if you're actually
using them. There is more interest here so we should get this working,
but patches are starting to clash with other things on the patch queue.
It would really help if maintainer would merge, or at least comment on
what's going on.

Willy:

Are you going to help us out, or wait for a coup d'etat?
