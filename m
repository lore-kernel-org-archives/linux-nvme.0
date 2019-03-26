From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 26 Mar 2019 10:41:00 +0800
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
Message-ID: <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>

On Tue, Mar 26, 2019 at 9:18 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Keith
>
> On 3/25/19 9:49 PM, Keith Busch wrote:
> > On Mon, Mar 25, 2019@01:38:37PM +0800, Jianchao Wang wrote:
> >> blk_mq_tagset_inflight_iter is not safe that it could get stale request
> >> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
> >> interface nvme_iterate_inflight_rqs is introduced to iterate
> >> all of the ns under a ctrl.
> >
> > Nak, NVMe only iterates tags when new requests can't enter, allocated
> > requests can't dispatch, and dispatched commands can't complete. So
> > it is perfectly safe to iterate if the driver takes reasonable steps
> > beforehand.
>
> nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
> So there still could be someone escapes the queue freeze checking and tries to allocate
> request.

The rq->state is just IDLE for these allocated request, so there
shouldn't be issue
in NVMe's case.

Thanks,
Ming
