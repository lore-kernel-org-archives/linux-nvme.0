From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Jul 2016 11:47:12 +0300
Subject: [PATCH RFC 0/3] iwarp device removal deadlock fix
In-Reply-To: <cover.1468879135.git.swise@opengridcomputing.com>
References: <cover.1468879135.git.swise@opengridcomputing.com>
Message-ID: <578F3A90.1000208@grimberg.me>

> This RFC series attempts to address the deadlock issue discovered
> while testing nvmf/rdma handling rdma device removal events from
> the rdma_cm.

Thanks for doing this Steve!

> For a discussion of the deadlock that can happen, see
>
> http://lists.infradead.org/pipermail/linux-nvme/2016-July/005440.html.
>
> For my description of the deadlock itself, see this post in the above thread:
>
> http://lists.infradead.org/pipermail/linux-nvme/2016-July/005465.html
>
> In a nutshell, iw_cxgb4 and the iw_cm block during qp/cm_id destruction
> until all references are removed.  This combined with the iwarp CM passing
> disconnect events up to the rdma_cm during disconnect and/or qp/cm_id destruction
> leads to a deadlock.
>
> My proposed solution is to remove the need for iw_cxgb4 and iw_cm to
> block during object destruction for the recnts to reach 0, but rather to
> let the freeing of the object memory be deferred when the last deref is
> done. This allows all the qps/cm_ids to be destroyed without blocking, and
> all the object memory freeing ends up happinging when the application's
> device_remove event handler function returns to the rdma_cm.

This sounds like a very good approach moving forward.

> Sean, I was hoping you could have a look at the iwcm.c patch particularly,
> to tell my why its broken. :)  I spent some time trying to figure out
> why we really need the CALLBACK_DESTROY flag, but I concluded it really
> isn't needed.  The one side effect I see with my change, is that the
> application could possibly get a cm_id event after it has destroyed the
> cm_id.  There probably is a way to discard events that have a reference
> on the cm_id but get processed after the app has destoyed the cm_id by
> having a new flag indicating "destroyed by app".

That sounds easy enough. Does this mean that iwcm relies on the driver
to do this or is it inter-operable with the existing logic? If not this
will need to take care of all the iWARP drivers.
