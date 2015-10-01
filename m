From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 1 Oct 2015 00:39:51 -0700
Subject: [PATCH 04/10] blk-mq: kill undead requests during CPU hotplug
 notify
In-Reply-To: <alpine.LNX.2.00.1509281758200.23840@localhost.lm.intel.com>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-5-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509281709460.23840@localhost.lm.intel.com>
 <20150928174648.GA2136@lst.de>
 <alpine.LNX.2.00.1509281758200.23840@localhost.lm.intel.com>
Message-ID: <20151001073951.GA1989@infradead.org>

On Mon, Sep 28, 2015@06:15:47PM +0000, Keith Busch wrote:
> >My impression was that's it's flakey to broken already and we don't
> >change that situation.  With my changes we'll mark it as completed
> >and if the command comes in during the small hotplug CPU window the
> >completion handler will see it already completed and ignore the
> >actual hardware completion.
> 
> It's not only during the window that there is a problem. Without
> a controller reset, the driver and drive will be permanently out of
> sync with the block layer after a hot cpu event, so we'll never have a
> successful async event notification.
> 
> Yes, the original was a kludge, but worked.
> 
> It'd be really cool if we can run the blk-mq cpu mapping on unfrozen
> queues. It doesn't look safe, though.

I've looked into AENs a it more, and the situation is worse than I
though:  AENs can't even be aborted on most devices I have access to
(after hacking the driver to allow aborts on admin commands), so
we can't even cancel them on a queue freeze.

So I'm goint to look into moving them entirely into the nvme driver
and remove the REQ_NO_TIMEOUT hacks in the block layer.  Given that we
only have on of AEN request, and it as a fixed tag number there
shouldn't be any need to abuse blk-mq as a tag allocator for them.
