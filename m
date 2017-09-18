From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 17 Sep 2017 17:27:13 -0700
Subject: [PATCH] nvme: allow timed-out ios to retry
In-Reply-To: <20170907203759.GA2832@localhost.localdomain>
References: <20170907201804.24979-1-jsmart2021@gmail.com>
 <20170907203759.GA2832@localhost.localdomain>
Message-ID: <20170918002713.GA20043@infradead.org>

On Thu, Sep 07, 2017@04:37:59PM -0400, Keith Busch wrote:
> I'm a bit conflicted on this. While it'd be nice to give commands a chance
> to succeed after a timeout handling's controller reset, some uses would
> rather a command fail fast than succeed slow, and this change could keep
> a request outstanding for a very long time.

That's what we have the fastfail flags for, which we set for all
the internal commands for example? and evaluate just a little bit
above the start_time line.
