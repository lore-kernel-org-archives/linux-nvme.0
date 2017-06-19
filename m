From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 15:00:45 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <8667b820-b25a-c5ea-759b-68fb95a1b02f@grimberg.me>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
 <20170619104245.GA19651@lst.de>
 <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>
 <20170619105907.GB21924@lst.de>
 <8667b820-b25a-c5ea-759b-68fb95a1b02f@grimberg.me>
Message-ID: <20170619130045.GA32190@lst.de>

On Mon, Jun 19, 2017@02:27:26PM +0300, Sagi Grimberg wrote:
> I completely agree that the multipath map (sibling list) is
> driver specific, I'm just arguing that the search itself can
> be invoked from the block layer through a block_device_operation
> when the bdev is created (in there, the driver sibling search has
> its own driver specific locking).

Let's wait for that until we have some block layer code posted.
I'll see if I can make this work, but I suspect driving the search
from the driver is going to be a lot easier.

> btw, I didn't see handling of the case where a sibling match found where
> the sibling is already linked (a sibling too).
>
> say we have namespaces a, b and c, where b,c are siblings of a (all with
> the same nsid=3).
>
> If I read the code correctly, c will link to both a and b wouldn't it?
>
> Do we need to check: list_empty(&cur->siblings)?
>
> Or am I not understanding the data structure?

Yeah, we should break after finding the first sibling.  Let me create
a test setup with three controllers with the same namespaces..
