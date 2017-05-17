From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Wed, 17 May 2017 14:50:58 +0200 (CEST)
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <20170517090202.GA23880@infradead.org>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
 <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>
 <20170503162708.GO22833@mtr-leonro.local>
 <1493829456.3901.13.camel@sandisk.com>
 <310709514.10440651.1493902200194.JavaMail.zimbra@kalray.eu>
 <20170517090202.GA23880@infradead.org>
Message-ID: <1663889710.35971858.1495025458229.JavaMail.zimbra@kalray.eu>


>> This looks like a good idea to me. Then the division can change into
>> an AND. I'll come back with another version soon.
> 
> Did you get a chance to look at this?  I'm tempted to just merge v2
> with the division in it and leave any fixing up for the time we move this
> guestimate into the rdma core..

Yes, I've done another iteration but it needs testing. I'd prefer one of
the later versions finally. It seems that we're also seeing the
effect of the race condition on the signalling variable. 

However, we can also go incremental: do a like-v2 fix first, then fix the
races in nvme and then add a more general fix for all rdma.

Marta
