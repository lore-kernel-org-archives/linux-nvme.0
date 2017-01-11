From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 11 Jan 2017 16:42:56 -0200
Subject: [PATCH] nvme/quirk: apply DELAY_BEFORE_CHK_RDY quirk at probe
 time too
In-Reply-To: <20170111161907.GA16710@lst.de>
References: <1482970395-14867-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <CY4PR04MB067867FDBE90838EADDEDC4CEA670@CY4PR04MB0678.namprd04.prod.outlook.com>
 <58765012.9090105@linux.vnet.ibm.com> <20170111161907.GA16710@lst.de>
Message-ID: <58767CB0.80705@linux.vnet.ibm.com>

On 01/11/2017 02:19 PM, hch@lst.de wrote:
> I guess I'll have to pick it up, not that I'm too fond of more boot
> delay time..

Thanks very much Christoph.

Me neither...at least this is a quirk to only 2 adapters currently. The
risk of not having it is reach a scenario with zombie adapter, and
reboots won't solve it. We manage to restore adapters sometimes with pci
rescan...

Cheers,


Guilherme

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
