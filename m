From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Wed, 8 May 2019 09:47:42 -0700
Subject: [PATCH, RFC 1/2] nvme: change locking for the per-subsystem
 controller list
In-Reply-To: <20190508075508.28552-1-hch@lst.de>
References: <20190508075508.28552-1-hch@lst.de>
Message-ID: <6b9497da-a1d1-84ed-f59c-ef602297a2aa@linux.microsoft.com>

On 5/8/19 12:55 AM, Christoph Hellwig wrote:
> Life becomes a lot simpler if we just use the global
> nvme_subsystems_lock to protect this list.  Given that it is only
> accessed during controller probing and removal that isn't a scalability
> problem either.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eebaeadaa800..4f4ffcce7416 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2346,13 +2346,11 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>   	int count = 0;
>   	struct nvme_ctrl *ctrl;
>   
> -	mutex_lock(&subsys->lock);
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>   		if (ctrl->state != NVME_CTRL_DELETING &&
>   		    ctrl->state != NVME_CTRL_DEAD)
>   			count++;
>   	}
> -	mutex_unlock(&subsys->lock);
>   
>   	return count;
>   }

Would lockdep_assert_held(&nvme_subsystems_lock); be beneficial here?

Thanks,
Ed
