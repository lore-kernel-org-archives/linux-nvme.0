From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 25 Oct 2016 18:25:56 +0000
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <014d01d22eec$832e60e0$898b22a0$@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
 <b5d32deb-af6a-3f98-98da-c5f61d400876@sandisk.com>
 <014d01d22eec$832e60e0$898b22a0$@opengridcomputing.com>
Message-ID: <1477419953.2385.3.camel@sandisk.com>

On Tue, 2016-10-25@13:20 -0500, Steve Wise wrote:
> > 
> > On 10/24/2016 12:09 PM, Steve Wise wrote:
> > > 
> > > +	rej_msg = rdma_reject_msg(cm_id, status);
> > > +	rej_data = (struct nvme_rdma_cm_rej *)
> > > +		???rdma_consumer_reject_data(cm_id, ev,
> > > &rej_data_len);
> > 
> > Please reorder the patches in this patch series such that it
> > doesn't
> > break a bisect. rdma_consumer_reject_data() should be introduced
> > before
> > it is used.
> 
> rdma_consumer_reject_data() is introduced in patch 3.

Hello Steve,

Thanks for the feedback. Apparently my e-mail client displayed the
patches in the wrong order ...

Bart.
