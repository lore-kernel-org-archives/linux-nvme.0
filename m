From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 May 2017 23:38:08 -0700
Subject: [PATCH] Add a parameter for  NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
Message-ID: <20170518063808.GA28607@infradead.org>

On Thu, May 18, 2017@04:17:41AM +0000, Zou Ming wrote:
> For distinguish return value,add a parameter for NVME_IOCTL_ID to get Namespaces ID.
> ---
>  drivers/nvme/host/core.c        | 3 +--
>  include/uapi/linux/nvme_ioctl.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3818ff6..886a031 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -769,8 +769,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  	switch (cmd) {
>  	case NVME_IOCTL_ID:
> -		force_successful_syscall_return();
> -		return ns->ns_id;
> +		return put_user(ns->ns_id, (__u32 __user *)arg);

This break any existing user.  I also don't really understand the
problem you're trying to solve..
