From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 14 Mar 2019 06:56:08 -0700
Subject: [PATCH] nvme: lightnvm: expose OC devices as zero size to OS
In-Reply-To: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
References: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
Message-ID: <4e43d40a-b253-1493-da38-70a8c062749e@lightnvm.io>

On 3/14/19 6:41 AM, Marcin Dziegielewski wrote:
> Open channel devices are not able to handle traditional
> IO requests addressed by LBA, so following current
> approach to exposing special nvme devices as zero size
> (e.g. with namespace formatted to use metadata) also
> open channel devices should be exposed as zero size
> to OS.
> 
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski at intel.com>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 07bf2bf..52cd5c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1606,7 +1606,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	if (ns->ms && !ns->ext &&
>   	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>   		nvme_init_integrity(disk, ns->ms, ns->pi_type);
> -	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
> +	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
> +	    ns->ndev)
>   		capacity = 0;
>   
>   	set_capacity(disk, capacity);
> 

Marcin,

The read/write as traditional I/Os feature is supported in OCSSD 2.0. 
For example, one can hook support up through the zone device support in 
the kernel. There is a patch here that enables it here:

https://github.com/OpenChannelSSD/linux/commit/e79e747601a315784e505d51a9265e82a3e7613c

With that, an OCSSD device can be used as a traditional zoned block 
device, and use the existing infrastructure. Which is really neat.

It is not upstream, since it depends on some features that we introduce 
with zoned namespaces, but in general, tools can read/write from a block 
device as any other, just honoring the special write rules that are for 
OCSSD/zoned block devices.

-Matias
