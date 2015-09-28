From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Sep 2015 18:15:47 +0000 (UTC)
Subject: [PATCH 04/10] blk-mq: kill undead requests during CPU hotplug
 notify
In-Reply-To: <20150928174648.GA2136@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-5-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509281709460.23840@localhost.lm.intel.com>
 <20150928174648.GA2136@lst.de>
Message-ID: <alpine.LNX.2.00.1509281758200.23840@localhost.lm.intel.com>

On Mon, 28 Sep 2015, Christoph Hellwig wrote:
> On Mon, Sep 28, 2015@05:39:47PM +0000, Keith Busch wrote:
>> The command is still owned by the device and breaks if the controller
>> happens to complete the command after a cpu hot event. This was 'ok'
>> when the driver provided special completion handling.
>>
>> We'd have to reset the controller to reliably recover the command,
>> but that's a bit heavy handed.
>
> My impression was that's it's flakey to broken already and we don't
> change that situation.  With my changes we'll mark it as completed
> and if the command comes in during the small hotplug CPU window the
> completion handler will see it already completed and ignore the
> actual hardware completion.

It's not only during the window that there is a problem. Without
a controller reset, the driver and drive will be permanently out of
sync with the block layer after a hot cpu event, so we'll never have a
successful async event notification.

Yes, the original was a kludge, but worked.

It'd be really cool if we can run the blk-mq cpu mapping on unfrozen
queues. It doesn't look safe, though.
