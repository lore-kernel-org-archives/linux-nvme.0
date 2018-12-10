From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Dec 2018 12:18:18 -0800
Subject: [PATCH 04/12] nvmet: add interface to update error-log page
In-Reply-To: <20181210055011.3146-5-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-5-chaitanya.kulkarni@wdc.com>
Message-ID: <8f2faf9c-4a48-c4d1-bb7b-f4f6a0a25ad2@grimberg.me>


> +static void nvmet_set_error(struct nvmet_req *req, u16 status)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvme_error_slot *new_error_slot;
> +	unsigned long flags;
> +
> +	req->rsp->status = cpu_to_le16(status << 1);
> +
> +	if (!ctrl)
> +		return;
> +
> +	spin_lock_irqsave(&ctrl->error_lock, flags);
> +	ctrl->counter++;

ctrl->err_counter reads out better.
