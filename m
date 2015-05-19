From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 19 May 2015 09:14:28 -0700
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
 <1431977423-31587-3-git-send-email-keith.busch@intel.com>
 <20150519074645.GA21597@infradead.org>
 <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>
Message-ID: <20150519161428.GA26772@infradead.org>

On Tue, May 19, 2015@03:35:19PM +0000, Keith Busch wrote:
> I'm actually not sure why every request queue has their own hardware
> context. Shouldn't it be an artifact of the tagset rather than the
> request queue?

That might make sense, but separating the hctx from the queue will
involve a fair amount of work.
