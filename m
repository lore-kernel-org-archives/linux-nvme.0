From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 13:52:15 +0100
Subject: [PATCH 3/5] nvme: track shared namespaces
In-Reply-To: <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-4-hch@lst.de>
 <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
Message-ID: <20171109125214.GA21795@lst.de>

On Thu, Nov 09, 2017@01:37:43PM +0200, Sagi Grimberg wrote:
>
>> To allow lockless path lookup the list of nvme_ns structures per
>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>> structure through call_srcu.
>
> Can you remind me why isn't rcu sufficient? Can looking up a
> path (ns from head->list) block?

blk_mq_make_request can block.
