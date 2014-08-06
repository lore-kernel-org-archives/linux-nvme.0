From: keith.busch@intel.com (Keith Busch)
Date: Tue, 5 Aug 2014 23:47:04 -0600 (MDT)
Subject: NVMe: Fix partition detection issue during hotplug
In-Reply-To: <SNT149-W326B993C35AFE7F71C0FEB9AE00@phx.gbl>
References: <SNT149-W326B993C35AFE7F71C0FEB9AE00@phx.gbl>
Message-ID: <alpine.LRH.2.03.1408052337540.5109@AMR>

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
