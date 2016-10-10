From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Oct 2016 09:49:55 +0200
Subject: [PATCH rfc 5/6] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <27b72354-439c-392c-226f-76c522f15877@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-6-git-send-email-sagi@grimberg.me>
 <20161005135237.ia5yqv3k73jgszed@linux-x5ow.site>
 <27b72354-439c-392c-226f-76c522f15877@grimberg.me>
Message-ID: <20161010074955.cx3itacl7upoi5ef@linux-x5ow.site>

On Wed, Oct 05, 2016@08:02:15PM +0300, Sagi Grimberg wrote:
> 
> > > Given that the code is simple enough it seems better
> > > then passing a tag by reference for each call site.
> > > 
> > > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> > > ---
> > >  drivers/nvme/host/pci.c | 36 +++++++++++++++++++++---------------
> > >  1 file changed, 21 insertions(+), 15 deletions(-)
> > > 
> > 
> > I don't really see how the call by value vs. call by reference change is a
> > better trade-off than open coding __nvme_process_cq(), as we'd have to
> > duplicate any possible fix for this function then (yes I see it's quite
> > simple but I have some doubt it's 100% bugfree).
> 
> I just figured it'd be nicer to remove the tag that we carry in all
> the call sites because we want to reuse the code in nvme_poll(). It
> made better sense before, but now that its simpler (for me at least)
> we can lose it.
> 
> Having said that, we can easily remove this patch if we're not all
> on board...

Would be nice to have a 3rd opinion here. Jens, Keith, Christoph?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
