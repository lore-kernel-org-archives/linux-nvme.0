From: shiro.itou@outlook.com (=?utf-8?B?U2hpcm8gSXRvdSDkvIrmnbE=?=)
Date: Wed, 6 Aug 2014 00:30:51 -0700
Subject: NVMe: Fix partition detection issue during hotplug
In-Reply-To: <alpine.LRH.2.03.1408052337540.5109@AMR>
References: <SNT149-W326B993C35AFE7F71C0FEB9AE00@phx.gbl>,
 <alpine.LRH.2.03.1408052337540.5109@AMR>
Message-ID: <SNT149-W4916913F367C832A6FA77D9AE00@phx.gbl>

Hi Kieth,

My mistake, sorry. I will use text mail.

Some our SCSI engineers and some customer suggest SCSI driver work the same way for the use case as it is with patch I sent.

Thank you, please advice right solution as you suggest.

Thank You,
Shiro

Date: Tue, 5 Aug 2014 23:47:04 -0600
From: keith.busch@intel.com
To: shiro.itou at outlook.com
Subject: Re: NVMe: Fix partition detection issue during hotplug
CC: keith.busch at intel.com; willy at linux.intel.com; linux-nvme at lists.infradead.org

Hi Shiro,

Your email will not show up on the mailing list if you use html instead
of plain text.

Regarding your use case, I think you are inviting data loss among other
problems by hot removing a mounted drive no matter what the driver is
doing with the device minors, but I'll see if there is a way we can keep
dynamic partitions and get the same functionality you're looking for.

On Tue, 5 Aug 2014, Shiro Itou ?? wrote:
> Hi All,
> 
> In out setup we see nighlty test fail when device mount
> and hot-remove and hot-plug sequence. read-write command
> fail to do on device after hotplug, because partition do
> not come visible.
> ?
> The test sequence create,
> ?a. multi-partition on device
> ?b. and mount
> ?c. stress test from mount folder
> ?d. and hot-remove
> ? e. hot-add
> ??
> ? now after 'step-e' read-write fail on device. Here device
> ? partition do not come visible.
> ??
> ? This patch fix the issue by revert:469071a37afc8a627b6b2ddf29db0a097d864845
> ? and minor change.
> 
> Thank You,
> Shiro
> 
>

_______________________________________________ Linux-nvme mailing list Linux-nvme at lists.infradead.org http://lists.infradead.org/mailman/listinfo/linux-nvme 		 	   		  
