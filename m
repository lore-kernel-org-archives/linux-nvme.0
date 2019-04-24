From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:58:21 -0700
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>
Message-ID: <7588161e-deea-0009-0f53-7f0cd7295fc2@grimberg.me>


> Phew. I was wondering whether I'd been too stupid to find it.
> And having looked at it a bit closer, moving the bioset into the holding 
> structure would induce more churn, as we'd need to pass the bioset into
> blk_queue_split(), which would mean to update all drivers (11 in total) 
> for no real gain IMO; bio splitting shouldn't really be a regular 
> occurrence and hence the bioset should only be used infrequently.
> 
> However, I really would like to get feedback to the actual patch, as 
> this solves a real customer issues we've had (or still have, depending 
> on the view :-)

I think that the patch is good, which is why I asked Ming to provide
more info...
