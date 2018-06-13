From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 01:10:56 -0700
Subject: [REPOST][PATCH] nvme: move init of keep_alive work item to
 controller initialization
In-Reply-To: <20180612232824.12379-1-jsmart2021@gmail.com>
References: <20180612232824.12379-1-jsmart2021@gmail.com>
Message-ID: <20180613081056.GB7429@infradead.org>

On Tue, Jun 12, 2018@04:28:24PM -0700, James Smart wrote:
> Currently, the code initializes the keep alive work item whenever
> nvme_start_keep_alive() is called. However, this routine is called
> several times while reconnecting, etc. Although it's hoped that keep
> alive is always disabled and not scheduled when start is called,
> re-initing if it were scheduled or completing can have very bad
> side effects. There's no need for re-initialization.
> 
> Move the keep_alive work item and cmd struct initialization to
> controller init.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

I don't think this can actually happen, but reducing initialization
is always a good thing.  I'll queue it up in the 4.19 tree once that
opens.
