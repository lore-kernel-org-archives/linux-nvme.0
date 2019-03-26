From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 26 Mar 2019 09:17:24 +0800
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <20190325134917.GA4328@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
Message-ID: <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>

Hi Keith

On 3/25/19 9:49 PM, Keith Busch wrote:
> On Mon, Mar 25, 2019@01:38:37PM +0800, Jianchao Wang wrote:
>> blk_mq_tagset_inflight_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
>> interface nvme_iterate_inflight_rqs is introduced to iterate
>> all of the ns under a ctrl.
> 
> Nak, NVMe only iterates tags when new requests can't enter, allocated
> requests can't dispatch, and dispatched commands can't complete. So
> it is perfectly safe to iterate if the driver takes reasonable steps
> beforehand.

nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
So there still could be someone escapes the queue freeze checking and tries to allocate
request.

> Further, for M tags and N namespaces, we complete teardown
> in O(M) time, but this makes in O(M*N) without gaining anything.
> 

Yes, it is indeed inefficient.

Thanks
Jianchao
