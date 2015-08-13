From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Aug 2015 13:52:26 +0000 (UTC)
Subject: [PATCH] NVMe: Set queue max segments
In-Reply-To: <20150813063842.GA11272@infradead.org>
References: <1439417874-8925-1-git-send-email-keith.busch@intel.com>
 <20150813063842.GA11272@infradead.org>
Message-ID: <alpine.LNX.2.00.1508131348460.15930@localhost.lm.intel.com>

On Wed, 12 Aug 2015, Christoph Hellwig wrote:
> On Wed, Aug 12, 2015@04:17:54PM -0600, Keith Busch wrote:
>> This sets the queue's max segment size to match the device's
>> capabilities. The default of 128 is usable until a device's transfer
>> capability exceeds 512k, assuming a device page size of 4k. Many nvme
>> devices exceed that transfer limit, so this lets the block layer know what
>> kind of commands it to allow to form rather than unnecessarily split them.
>>
>> One additional segment is added to account for a transfer that may start
>> in the middle of a page.
>
> But it might not start in the middle of the page, too - in which case
> you're overcounting here, aren't you?

queue_max_sectors() would exceed before the next segment is considered,
similar to what happens with very large segments.
