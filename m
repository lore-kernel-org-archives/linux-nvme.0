From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 24 Dec 2015 16:50:12 +0200
Subject: [PATCH RFC 1/4] blk-mq: Export a busy tagset iterator helper
In-Reply-To: <20151224142424.GC2646@infradead.org>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
 <1450956241-4626-2-git-send-email-sagig@mellanox.com>
 <20151224142424.GC2646@infradead.org>
Message-ID: <567C0624.5090102@dev.mellanox.co.il>


> Looks okay to me, although I'm not really sold on absolutely
> needing this helper..

We only use blk_mq_all_tag_busy_iter to iterate on *all* the queues, so
I just figured we can move this loop to blk-mq and just pass in the
tagset.
