From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Feb 2017 18:26:49 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <2e1c1ca8-1272-5bc1-2b9c-551c872e8dea@grimberg.me>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <2e1c1ca8-1272-5bc1-2b9c-551c872e8dea@grimberg.me>
Message-ID: <20170221232648.GA2429@localhost.localdomain>

On Tue, Feb 21, 2017@11:55:10PM +0200, Sagi Grimberg wrote:
> > 
> > Maybe. I'm okay with moving it to the core and document the intended
> > usage, but the sequence inbetween initiating the freeze and waiting for
> > frozen is specific to the driver, as well as knowing when it needs to
> > be done. The above could be moved to core, but it only makes sense to
> > call it only if the request to start the freeze was done prior to
> > reclaiming controller owned IO.
> 
> What if we pass a flag to blk_mq_quiesce_queue to indicate that we want
> it to flush (and freeze) all entered requests?

Sounds like that's shuffling the set up for no particular gain, and has
potential for getting the freeze depth off from misuse. Control still
has to pass back to the driver to do driver specific tasks to reclaim
IO and set up to fail requests that have entered but not issued prior
to temporarily restarting the hctx's and waiting for frozen.
