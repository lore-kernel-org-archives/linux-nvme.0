From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:52:37 +0200
Subject: [PATCH rfc 5/6] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1475660534-16681-6-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-6-git-send-email-sagi@grimberg.me>
Message-ID: <20161005135237.ia5yqv3k73jgszed@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:13PM +0300, Sagi Grimberg wrote:
> Given that the code is simple enough it seems better
> then passing a tag by reference for each call site.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/pci.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 

I don't really see how the call by value vs. call by reference change is a
better trade-off than open coding __nvme_process_cq(), as we'd have to
duplicate any possible fix for this function then (yes I see it's quite
simple but I have some doubt it's 100% bugfree).

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
