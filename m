From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 14:52:59 +0200
Subject: [PATCH 3/4] nvme: ANA transition timeout handling
In-Reply-To: <20180607120941.GC11938@lst.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-4-hare@suse.de>
 <20180607120941.GC11938@lst.de>
Message-ID: <20180607145259.4017f366@pentland.suse.de>

On Thu, 7 Jun 2018 14:09:41 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > +	timer_setup(&ns->anatt_timer, nvme_anatt_timedout, 0);  
> 
> ANATT is per-group, so having a timer in the namespace is wrong.
> 

But would requiring us to create a separate ana group structure on the
host. Could be looking into that if you insist, but this implementation
is way easier.

Cheers,

Hannes
