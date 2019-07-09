From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 9 Jul 2019 17:07:47 -0600
Subject: [PATCH rfc] nvme-tcp: support simple polling
In-Reply-To: <20190709212717.GA9636@lst.de>
References: <20190703210804.23137-1-sagi@grimberg.me>
 <20190709202201.GB8405@lst.de>
 <70b60d78-1a77-ddb0-3414-e0c26d657e4f@grimberg.me>
 <20190709212717.GA9636@lst.de>
Message-ID: <e7e4ec9a-b644-58a3-77b0-7828d73831ca@kernel.dk>

On 7/9/19 3:27 PM, Christoph Hellwig wrote:
> On Tue, Jul 09, 2019@02:26:04PM -0700, Sagi Grimberg wrote:
>>> Looks good enough to me, especially now that we need to explicitly opt
>>> into polling queues.
>>
>> Cool, so unless we have any objections, lets let it sit in 5.3?
> 
> Well, the 5.3 merge window is over, I'm not sure how happy Jens would
> be about this new feature.

I'm most likely doing a later pull this merge window, so if it's
important and not super involved, we can probably sneak it in without
too much fuss.

-- 
Jens Axboe
