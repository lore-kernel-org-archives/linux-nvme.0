From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Mar 2017 07:46:05 -0800
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <7dc99796-899e-b1a0-6ddb-cbfc497195dd@grimberg.me>
References: <CY1PR12MB077418C35F6EA2499CBACA45BC2C0@CY1PR12MB0774.namprd12.prod.outlook.com>
 <7dc99796-899e-b1a0-6ddb-cbfc497195dd@grimberg.me>
Message-ID: <20170308154605.GA28937@infradead.org>

On Tue, Mar 07, 2017@03:33:27PM +0200, Sagi Grimberg wrote:
> 1. nvmet_sq_destroy is not doing its job for completing all
>    its inflight requests. Although we do wait for the final
>    ref on the nvmet_sq to drop to zero.

> For that perhaps you can try patch [1].

Yes, I'll think we need that.  Did I mention that the percpu
refounter API is a complete trainwreck a couple times? :)

> 2. ib_destroy_cq does not really protect against a case where
>    the work requeue itself because it runs flush_work(). In this
>    case when the work re-executes it polls a cq array that is
>    already freed and sees a bogus successful completion. Perhaps
>    ib_free_cq should run cancel_work_sync() instead? see [2].

Yeah, we'll probably need that as well.  Independent of it solves
the problem reported here.
