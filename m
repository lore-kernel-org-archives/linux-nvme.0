From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 Nov 2016 11:28:51 +0200
Subject: [PATCH v3 1/2] nvmet-rdma: align to generic ib_event logging
 helper
In-Reply-To: <20161125074807.GC1569@infradead.org>
References: <1479893928-32445-1-git-send-email-maxg@mellanox.com>
 <1479893928-32445-2-git-send-email-maxg@mellanox.com>
 <1479925553.5486.4.camel@linux.intel.com>
 <9e7a1e2a-aa02-e6b1-4821-1b47c795f743@mellanox.com>
 <20161125074807.GC1569@infradead.org>
Message-ID: <e17d687f-9f0d-d07f-16f3-ffb85cdad1ff@mellanox.com>



On 11/25/2016 9:48 AM, Christoph Hellwig wrote:
> On Thu, Nov 24, 2016@01:19:11PM +0200, Max Gurtovoy wrote:
>> in that case you'll get something like:
>>
>> "nvmet_rdma: received unrecognized IB QP event: last WQE reached (16)"
>>
>> instead of
>>
>> "nvmet_rdma: received IB QP event: last WQE reached (16)"
>>
>> Sagi/Christoph, what do you think ?
>
> I don't care, it's only a debug printk anyway.
>

me too :) I just want to put this 2 patches behind us.
