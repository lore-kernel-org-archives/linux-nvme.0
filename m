From: hare@suse.de (Hannes Reinecke)
Date: Thu, 4 Oct 2018 17:40:08 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <dc0eb654-8cf5-bb06-c815-182ea124ca04@grimberg.me>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
 <20180930230144.GB20144@lst.de>
 <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
 <4d6336da-9441-fd97-b716-ec219489175a@suse.de>
 <20181002173924.GA19808@lst.de>
 <a033c3a2-b825-4d9a-e844-adddea2e155f@suse.de>
 <dc0eb654-8cf5-bb06-c815-182ea124ca04@grimberg.me>
Message-ID: <2a0c88c4-f2e6-8e0e-1f7f-077a2fe39842@suse.de>

On 10/4/18 3:30 AM, Sagi Grimberg wrote:
> 
>> Ah. So that should be more like it.
> 
> For it to be useful for RDMA you'll want to add:
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index ea325a636588..a926c370e83a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -755,6 +755,7 @@ static int nvme_rdma_configure_admin_queue(struct 
> nvme_rdma_ctrl *ctrl,
>  ??????????????? return error;
> 
>  ??????? ctrl->device = ctrl->queues[0].device;
> +?????? ctrl->ctrl.node_id = dev_to_node(device->dev->dma_device);
> 
>  ??????? ctrl->max_fr_pages = 
> nvme_rdma_get_max_fr_pages(ctrl->device->dev);
> -- 
Ah, I knew I could count on you :-)
The mapping to the underlying hardware in RDMA had got me confused.

Will be fixing it up and resend the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
