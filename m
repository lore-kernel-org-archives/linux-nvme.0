From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 22:17:20 +0200
Subject: [PATCH 4/5] nvme: move namespace scanning to core
In-Reply-To: <57153870.9050306@grimberg.me>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-5-git-send-email-hch@lst.de> <57152B88.1080403@grimberg.me>
 <20160418184903.GD4640@localhost.localdomain> <57153870.9050306@grimberg.me>
Message-ID: <20160418201720.GB4921@lst.de>

On Mon, Apr 18, 2016@10:41:36PM +0300, Sagi Grimberg wrote:
>
>>> Why does the affinity hints setting needs to happen
>>> after the ns scan?
>>
>> The driver has no idea what queues are associated to which CPU(s) until
>> after the namespaces are registered with blk-mq. We need to know that
>> mapping before providing affinity hints.
>
> So the name made me think at first that this callout is related
> to ns-scanning (like the driver needs something to finish the scan), is
> post_scan a better name?

Fine with me.
