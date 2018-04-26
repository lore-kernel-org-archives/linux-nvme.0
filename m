From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 26 Apr 2018 14:59:06 +0000
Subject: NVMe Poll CQ on timeout
Message-ID: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>

Hi,

We are testing NVMe cards on ARM64 platform, the card uses legacy interrupts.
Intermittently we are hitting following case in drivers/nvme/host/pci.c
       /*
         * Did we miss an interrupt?
         */
        if (__nvme_poll(nvmeq, req->tag)) {
                dev_warn(dev->ctrl.device,
                         "I/O %d QID %d timeout, completion polled\n",
                         req->tag, nvmeq->qid);
                return BLK_EH_HANDLED;
        }

Can anyone tell when does nvme_timeout gets invoked ?
What does "Did we miss an interrupt mean" ? Does it mean host missing
to service a interrupt raised by EP card ?

Regards,
Bharat
