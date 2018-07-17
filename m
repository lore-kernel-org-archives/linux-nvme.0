From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 17 Jul 2018 13:37:54 +0800
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180716133059.GB19967@localhost.localdomain>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <9bd80570-5b7d-c093-ffbb-a8fbcaa58db0@oracle.com>
 <20180716103956.GB25386@ming.t460p>
 <20180716133059.GB19967@localhost.localdomain>
Message-ID: <61d982b9-069f-3c9c-bf64-24428b879876@oracle.com>



On 07/16/2018 09:30 PM, Keith Busch wrote:
>>> On 07/14/2018 04:56 AM, Keith Busch wrote:
>>>> This patch fixes races that occur with simultaneous controller
>>>> resets by synchronizing request queues prior to initializing the
>>>> controller. Withouth this, a thread may attempt disabling a controller
>>>> at the same time as we're trying to enable it.
>>> This issue is due to the previous blk-mq timeout mechanism will hold
>>> all the timed out requests, then nvme_dev_disable cannot grab these requests
>>> and when it returns, the blk_mq_timeout_work could be still running.
>>> But after commit 12f5b9314545 ("blk-mq: Remove generation seqeunce"),
>>> nvme_dev_disble have been able to grab all the requests and when it returns,
>>> there will be no any requests in blk_mq_timeout_work so nvme_dev_disable will
>>> not be invoked multiple times.
>>> So this patch should be unnecessary. :)
>> There are multiple namespaces, and all may trigger timeout at the same
>> time, so looks the sync is still needed.
> Yes, we still need this syncing because each namespace has a different
> request queue with their own timeout work.
> 

Yes, got it. :)

If there are multiple namespaces and trigger timeout at the same time,
so the nvme_dev_disable could be invoked by multiple namespaces' timeout work.
The nvme_dev_disable comes from other namespaces could race with the ctrl reset
work.

Thanks
Jianchao
