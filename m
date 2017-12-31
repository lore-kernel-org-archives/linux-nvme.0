From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 31 Dec 2017 14:48:01 +0200
Subject: [PATCH 3/3] block: Polling completion performance optimization
In-Reply-To: <20171229095021.GD24043@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
 <20171221213400.GB2975@localhost.localdomain> <20171229095021.GD24043@lst.de>
Message-ID: <b00a03f2-dbc7-fb4f-393e-1496861dbf28@grimberg.me>



On 12/29/2017 11:50 AM, Christoph Hellwig wrote:
> On Thu, Dec 21, 2017@02:34:00PM -0700, Keith Busch wrote:
>> It would be nice, but the driver doesn't know a request's completion
>> is going to be a polled.
> 
> We can trivially set a REQ_POLL bit.  In fact my initial patch kit had
> those on the insitence of Jens, but then I removed it because we had
> no users for it.
> 
>> Even if it did, we don't have a spec defined
>> way to tell the controller not to send an interrupt with this command's
>> compeletion, which would be negated anyway if any interrupt driven IO
>> is mixed in the same queue.
> 
> Time to add such a flag to the spec then..

That would be very useful, ideally we can also hook it into libaio
to submit without triggering an interrupt and have io_getevents to poll
the underlying bdev (blk_poll) similar to how the net stack implements
low latency sockets [1].

Having the ability to suppress interrupts and poll for completions would
be very useful for file servers or targets living in userspace.

https://lwn.net/Articles/551284/
