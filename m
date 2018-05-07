From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Mon, 7 May 2018 06:57:54 +0000
Subject: NVMe Poll CQ on timeout
In-Reply-To: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>

Hi,

Does anyone have any inputs ?

Regards,
Bharat

> Hi,
> 
> We are testing NVMe cards on ARM64 platform, the card uses legacy
> interrupts.
> Intermittently we are hitting following case in drivers/nvme/host/pci.c
>        /*
>          * Did we miss an interrupt?
>          */
>         if (__nvme_poll(nvmeq, req->tag)) {
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, completion polled\n",
>                          req->tag, nvmeq->qid);
>                 return BLK_EH_HANDLED;
>         }
> 
> Can anyone tell when does nvme_timeout gets invoked ?
> What does "Did we miss an interrupt mean" ? Does it mean host missing to
> service a interrupt raised by EP card ?
> 
> Regards,
> Bharat
> 
