From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Sep 2015 19:46:48 +0200
Subject: [PATCH 04/10] blk-mq: kill undead requests during CPU hotplug
 notify
In-Reply-To: <alpine.LNX.2.00.1509281709460.23840@localhost.lm.intel.com>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-5-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509281709460.23840@localhost.lm.intel.com>
Message-ID: <20150928174648.GA2136@lst.de>

On Mon, Sep 28, 2015@05:39:47PM +0000, Keith Busch wrote:
> The command is still owned by the device and breaks if the controller
> happens to complete the command after a cpu hot event. This was 'ok'
> when the driver provided special completion handling.
>
> We'd have to reset the controller to reliably recover the command,
> but that's a bit heavy handed.

My impression was that's it's flakey to broken already and we don't
change that situation.  With my changes we'll mark it as completed
and if the command comes in during the small hotplug CPU window the
completion handler will see it already completed and ignore the
actual hardware completion.

Now this relies on the subtile fact that nvmeq->tags doesn't change
during CPU hotplug, which it currently doesn't.  That's probably wrong to
start with for other reasons, but I'd like to untangle that whole
mess one at a time.  We'll probably need to move to a model where
multiple request_queues share the hw_ctx structures to sort that
out properly.
