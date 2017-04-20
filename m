From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 20 Apr 2017 20:33:29 +0000
Subject: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
In-Reply-To: <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
Message-ID: <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>


> Nah, let's just leave it as-is then, even though I don't think it's the
> prettiest thing I've ever seen.

I did look at making the stats buckets in the request_queue struct based on dir and size. Something like:

-       struct blk_rq_stat      poll_stat[2];
+       struct blk_rq_stat      poll_stat[2][BLK_MQ_POLL_STATS_BKTS/2];

This actually did clean up some in some places but because the callback still uses a linear array of buckets we do get this:

-       if (cb->stat[READ].nr_samples)
-               q->poll_stat[READ] = cb->stat[READ];
-       if (cb->stat[WRITE].nr_samples)
-               q->poll_stat[WRITE] = cb->stat[WRITE];
+       for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
+               if (cb->stat[bucket].nr_samples)
+                       q->poll_stat[bucket%2][bucket/2] = cb->stat[bucket];

I tend to agree with Omar that keeping the buckets in a linear array is overall cleaner and more generalized.

However right now I am stuck as I am seeing the kernel oops I reported before in testing of my latest patchset [1]. I will try and find some time to bisect that but it looks like it was introduced when the support for mq schedulers was added (on or around bd166ef18).

Stephen

[1] http://marc.info/?l=linux-block&m=149156785215919&w=2
