From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 7 Feb 2016 18:43:48 +0200
Subject: [RFC PATCH] dm: fix excessive dm-mq context switching
In-Reply-To: <56B772D6.2090403@sandisk.com>
References: <20160129233504.GA13661@redhat.com> <56AC79D0.5060104@suse.de>
 <20160130191238.GA18686@redhat.com> <56AEFF63.7050606@suse.de>
 <20160203180406.GA11591@redhat.com> <20160203182423.GA12913@redhat.com>
 <56B2F5BC.1010700@suse.de> <20160204135420.GA18227@redhat.com>
 <20160205151334.GA82754@redhat.com> <20160205180515.GA25808@redhat.com>
 <20160205191909.GA25982@redhat.com> <56B7659C.8040601@dev.mellanox.co.il>
 <56B772D6.2090403@sandisk.com>
Message-ID: <56B77444.3030106@dev.mellanox.co.il>


> Hello Sagi,

Hey Bart,

> Did you run your test on a NUMA system ?

I did.

> If so, can you check with e.g.
> perf record -ags -e LLC-load-misses sleep 10 && perf report whether this
> workload triggers perhaps lock contention ? What you need to look for in
> the perf output is whether any functions occupy more than 10% CPU time.

I will, thanks for the tip!
