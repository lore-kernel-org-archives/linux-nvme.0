From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Aug 2019 17:26:59 +0300
Subject: [PATCH v7 03/14] nvmet: add return value to
 nvmet_add_async_event()
In-Reply-To: <20190801234514.7941-4-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-4-logang@deltatee.com>
Message-ID: <9bb2966a-0d7c-a492-7628-37916a941cfb@mellanox.com>


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>
> Change the return value for nvmet_add_async_event().
>
> This change is needed for the target passthru code to generate async
> events.

As a stand alone commit it's not clear what is the purpose of it.

Please add some extra explanation in the commit message.

Also better to use integer as return value if the return value should 
reflect return code.


> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> [logang at deltatee.com: fixed up commit message that was no
>   longer accurate]
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>   drivers/nvme/target/core.c  | 5 +++--
>   drivers/nvme/target/nvmet.h | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3a67e244e568..f7f25bdc4763 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -173,14 +173,14 @@ static void nvmet_async_event_work(struct work_struct *work)
>   	}
>   }
>   
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page)
>   {
>   	struct nvmet_async_event *aen;
>   
>   	aen = kmalloc(sizeof(*aen), GFP_KERNEL);
>   	if (!aen)
> -		return;
> +		return false;
>   
>   	aen->event_type = event_type;
>   	aen->event_info = event_info;
> @@ -191,6 +191,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   	mutex_unlock(&ctrl->lock);
>   
>   	schedule_work(&ctrl->async_event_work);
> +	return true;
>   }
>   
>   static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c51f8dd01dc4..217a787952e8 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -441,7 +441,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>   		struct nvmet_subsys *subsys);
>   void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>   		struct nvmet_host *host);
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page);
>   
>   #define NVMET_QUEUE_SIZE	1024
