From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 12:44:53 +0200
Subject: [PATCH] nvme_fc: correct hang in nvme_ns_remove()
In-Reply-To: <20180111232138.10669-1-jsmart2021@gmail.com>
References: <20180111232138.10669-1-jsmart2021@gmail.com>
Message-ID: <98acda28-7c20-5830-bd8b-11ca77e7c3c1@grimberg.me>


> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index fe98e994498c..99bf51c7e513 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2938,6 +2938,9 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
>   	 * waiting for io to terminate
>   	 */
>   	nvme_fc_delete_association(ctrl);
> +
> +	/* resume the io queues so that things will fast fail */
> +	nvme_start_queues(nctrl);

Is fc also unquiescing the admin queue here?
