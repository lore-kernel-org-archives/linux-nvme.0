From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 25 Apr 2019 08:41:07 +0800
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190424221422.GA21351@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <20190424221422.GA21351@ming.t460p>
Message-ID: <20190425004106.GA22683@ming.t460p>

On Thu, Apr 25, 2019@06:14:22AM +0800, Ming Lei wrote:
> On Wed, Apr 24, 2019@10:20:46AM -0700, Sagi Grimberg wrote:
> > 
> > > per-queue bioset is used originally for avoiding deadlock, are you
> > > sure the static bioset is safe?
> > 
> > Can you explain this? I didn't find any indication of that in the change
> > log history...
> > 
> > Originally introduced by Kent:
> 
> bio split can be run from stacking drivers, for example, MD over NVMe,
> if the global reserved mempool is consumed by MD bio splitting, then
> no any progress can be made when splitting on bio submitted to NVMe.
> 
> Kent may have more details...

I guess it might be fine to use one shared global bio_set for all
lowest underlying queues, could be all queues except for loop, dm, md
, drbd, bcache, ...

Thanks,
Ming
