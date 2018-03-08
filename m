From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 8 Mar 2018 11:36:23 -0700
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
 <20180308155147.GD3766@localhost.localdomain>
 <20180308172018.GA6785@ziepe.ca>
 <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
Message-ID: <20180308183623.GE6785@ziepe.ca>

On Thu, Mar 08, 2018@07:56:37PM +0200, Sagi Grimberg wrote:
> 
> >>>@@ -437,8 +437,14 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
> >>>  	if (++tail == nvmeq->q_depth)
> >>>  		tail = 0;
> >>>  	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
> >>>-					      nvmeq->dbbuf_sq_ei))
> >>>+					      nvmeq->dbbuf_sq_ei)) {
> >>>+		/*
> >>>+		 * Make sure that descriptors are written before
> >>>+		 * doorbell record.
> >>>+		 */
> >>>+		wmb();
> >>>  		writel(tail, nvmeq->q_db);
> >>>+	}
> >>>  	nvmeq->sq_tail = tail;
> >>>  }
> >>
> >>If this really is necessary, we'd need this before updating the event
> >>shadow registers too.
> >>
> >>I'd like to understand this a bit more as we haven't done this in eight
> >>years and I can't recall any issues around this section. Have we just
> >>been fortunate that the problem this fixes is extraordinarily unlikely,
> >>or is something else implicitly ordering within this critical section?
> >
> >Well, there is a wmb() already inside
> >nvme_dbbuf_update_and_check_event so any failure would only
> >be related to dbbuf_sq_db being wrong when tail is written to q_db.
> 
> Right, we have that covered.
> 
> >Guessing that might be a basically undetectable situation, maybe some
> >temporary higher latency or something?
> 
> If the SQE and DB update have been reordered,

But that can't happen, the SQE is written before
nvme_dbbuf_update_and_check_event(), and that function does wmb.

The only reordering is related to this:

		wmb();

		old_value = *dbbuf_db;
		*dbbuf_db = value;
[..]
	writel(tail, nvmeq->q_db);

So q_db and dbbuf_db could be swapped at the worst.

Jason
