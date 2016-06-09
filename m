From: mlin@kernel.org (Ming Lin)
Date: Thu, 9 Jun 2016 12:47:54 -0700
Subject: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
In-Reply-To: <20160609141012.GB30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <1465415292-9416-3-git-send-email-mlin@kernel.org>
 <575950DB.6080701@lightbits.io> <20160609141012.GB30293@lst.de>
Message-ID: <CAF1ivSbkU2q4bUReMHo0W=wCYs2rO8ZWEFQYyH1qtzjftJrkug@mail.gmail.com>

On Thu, Jun 9, 2016@7:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jun 09, 2016@02:19:55PM +0300, Sagi Grimberg wrote:
>> This needs documentation in the form of:
>>
>> /*
>>  * XXX: blk-mq might not map all our hw contexts but this is a must for
>>  * us for fabric connects. So until we can fix blk-mq we check that.
>>  */
>
> I think the right thing to do is to have a member of actually mapped
> queues in the block layer, and I also don't think we need the XXX comment
> as there are valid reasons for not mapping all queues.

I think it is a rare case that we need all hw contexts mapped.
Seems unnecessary to add a new field to "struct request_queue" for the
rare case.
