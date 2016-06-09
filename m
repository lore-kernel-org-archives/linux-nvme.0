From: mlin@kernel.org (Ming Lin)
Date: Thu, 9 Jun 2016 12:43:51 -0700
Subject: [PATCH 0/2] check the number of hw queues mapped to sw queues
In-Reply-To: <20160609140909.GA30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <20160609140909.GA30293@lst.de>
Message-ID: <CAF1ivSaJUPQg2uTQVZLGL36yERF6eGFF6_jot7DsSZ=D3uPqPQ@mail.gmail.com>

On Thu, Jun 9, 2016@7:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jun 08, 2016@03:48:10PM -0400, Ming Lin wrote:
>> It adds check code to blk_mq_update_queue_map().
>> But it seems too aggresive because it's not an error that some hw queues
>> were not mapped to sw queues.
>>
>> So this series just add a new function blk_mq_hctx_mapped() to check
>> how many hw queues were mapped. And the driver(for example, nvme-rdma)
>> that cares about it will do the check.
>
> I think it would be better to have this number available a structure
> field.  Any reason not to update nr_hw_queues in the tag set
> with the actual number of queues?

One reason is we don't know which hctx(s) not mapped.

HW Queue 1 <-> CPU 0,4
HW Queue 2 <-> CPU 1,5
HW Queue 3 <-> None
HW Queue 4 <-> CPU 2,6
HW Queue 5 <-> CPU 3,7
HW Queue 6 <-> None

If we updated nr_hw_queues from 6 to 4,
then queue_for_each_hw_ctx will not work.

#define queue_for_each_hw_ctx(q, hctx, i)                               \
        for ((i) = 0; (i) < (q)->nr_hw_queues &&                        \
             ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
