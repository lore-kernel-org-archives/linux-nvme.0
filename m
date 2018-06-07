From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:11:46 +0200
Subject: [PATCH 3/4] nvme: ANA transition timeout handling
In-Reply-To: <20180607145259.4017f366@pentland.suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-4-hare@suse.de> <20180607120941.GC11938@lst.de>
 <20180607145259.4017f366@pentland.suse.de>
Message-ID: <20180607131146.GB13273@lst.de>

On Thu, Jun 07, 2018@02:52:59PM +0200, Hannes Reinecke wrote:
> On Thu, 7 Jun 2018 14:09:41 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > +	timer_setup(&ns->anatt_timer, nvme_anatt_timedout, 0);  
> > 
> > ANATT is per-group, so having a timer in the namespace is wrong.
> > 
> 
> But would requiring us to create a separate ana group structure on the
> host. Could be looking into that if you insist, but this implementation
> is way easier.

For now just add an array of timers, similar to ctrl->ana_state.
Eventually we might need an actual ana_group structure if the two arrays
become too sparse in practice, but we can defer that for now.
