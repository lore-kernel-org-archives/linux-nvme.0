From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 10 Dec 2018 22:48:14 +0000
Subject: [PATCH 04/12] nvmet: add interface to update error-log page
In-Reply-To: <8f2faf9c-4a48-c4d1-bb7b-f4f6a0a25ad2@grimberg.me>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-5-chaitanya.kulkarni@wdc.com>,
 <8f2faf9c-4a48-c4d1-bb7b-f4f6a0a25ad2@grimberg.me>
Message-ID: <BYAPR04MB4502668CF34A139786C30D0786A50@BYAPR04MB4502.namprd04.prod.outlook.com>


Sounds good.




From: Sagi Grimberg <sagi@grimberg.me>
Sent: Monday, December 10, 2018 12:18 PM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Cc: hch at lst.de; keith.busch at intel.com
Subject: Re: [PATCH 04/12] nvmet: add interface to update error-log page
? 


> +static void nvmet_set_error(struct nvmet_req *req, u16 status)
> +{
> +???? struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +???? struct nvme_error_slot *new_error_slot;
> +???? unsigned long flags;
> +
> +???? req->rsp->status = cpu_to_le16(status << 1);
> +
> +???? if (!ctrl)
> +???????????? return;
> +
> +???? spin_lock_irqsave(&ctrl->error_lock, flags);
> +???? ctrl->counter++;

ctrl->err_counter reads out better.
    
