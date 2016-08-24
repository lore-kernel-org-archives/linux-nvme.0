From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Aug 2016 12:31:38 +0300
Subject: nvme_rdma - leaves provider resources allocated
In-Reply-To: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
References: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
Message-ID: <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>


> Assume an nvme_rdma host has one attached controller in RECONNECTING state, and
> that controller has failed to reconnect at least once and thus is in the
> delay_schedule time before retrying the connection.  At that moment, there are
> no cm_ids allocated for that controller because the admin queue and the io
> queues have been freed.  So nvme_rdma cannot get a DEVICE_REMOVAL from the
> rdma_cm.  This means if the underlying provider module is removed, it will be
> removed with resources still allocated by nvme_rdma.  For iw_cxgb4, this causes
> a BUG_ON() in gen_pool_destroy() because MRs are still allocated for the
> controller.
>
> Thoughts on how to fix this?

Hey Steve,

I think it's time to go back to your client register proposal.

I can't think of any way to get it right at the moment...

Maybe if we can make it only do something meaningful in remove_one()
to handle device removal we can get away with it...
