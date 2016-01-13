From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 13 Jan 2016 18:30:35 +0200
Subject: [LSF/MM ATTEND][LSF/MM TOPIC] Multipath redesign
In-Reply-To: <20160113162102.GA2933@redhat.com>
References: <56961493.5010901@suse.de> <56962BDB.4080509@dev.mellanox.co.il>
 <20160113154243.GA2563@redhat.com> <569675F5.8070501@dev.mellanox.co.il>
 <20160113162102.GA2933@redhat.com>
Message-ID: <56967BAB.9000809@dev.mellanox.co.il>


>> Hmm. I turned on /sys/module/dm_mod/parameters/use_blk_mq and indeed
>> saw a significant performance improvement. Anything else I was missing?
>
> You can enable CONFIG_DM_MQ_DEFAULT so you don't need to manually set
> use_blk_mq.

I do, I started out with the manual option to test the improvements but
got tired of it very quickly :)

> OK, so you're only getting 1/3 of the throughput.  Time for us to hunt
> down the bottleneck (before real devices hit it).

I have some initial instrumentation analysis so I'll be happy if we can
work on that (probably can free this thread and move it to dm-devel).
