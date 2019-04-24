From: hare@suse.de (Hannes Reinecke)
Date: Wed, 24 Apr 2019 20:56:05 +0200
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
Message-ID: <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>

On 4/24/19 7:20 PM, Sagi Grimberg wrote:
> 
>> per-queue bioset is used originally for avoiding deadlock, are you
>> sure the static bioset is safe?
> 
> Can you explain this? I didn't find any indication of that in the change
> log history...
> 
> Originally introduced by Kent:
> -- 
> commit 54efd50bfd873e2dbf784e0b21a8027ba4299a3e
> Author: Kent Overstreet <kent.overstreet at gmail.com>
> Date:?? Thu Apr 23 22:37:18 2015 -0700
> 
Phew. I was wondering whether I'd been too stupid to find it.
And having looked at it a bit closer, moving the bioset into the holding 
structure would induce more churn, as we'd need to pass the bioset into
blk_queue_split(), which would mean to update all drivers (11 in total) 
for no real gain IMO; bio splitting shouldn't really be a regular 
occurrence and hence the bioset should only be used infrequently.

However, I really would like to get feedback to the actual patch, as 
this solves a real customer issues we've had (or still have, depending 
on the view :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
