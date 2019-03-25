From: kbusch@kernel.org (Keith Busch)
Date: Mon, 25 Mar 2019 07:49:18 -0600
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20190325134917.GA4328@localhost.localdomain>

On Mon, Mar 25, 2019@01:38:37PM +0800, Jianchao Wang wrote:
> blk_mq_tagset_inflight_iter is not safe that it could get stale request
> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
> interface nvme_iterate_inflight_rqs is introduced to iterate
> all of the ns under a ctrl.

Nak, NVMe only iterates tags when new requests can't enter, allocated
requests can't dispatch, and dispatched commands can't complete. So
it is perfectly safe to iterate if the driver takes reasonable steps
beforehand. Further, for M tags and N namespaces, we complete teardown
in O(M) time, but this makes in O(M*N) without gaining anything.
