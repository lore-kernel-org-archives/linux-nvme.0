From: james.smart@broadcom.com (James Smart)
Date: Fri, 22 Dec 2017 09:39:14 -0800
Subject: [PATCH 4.15-rc 2/3] nvme-core/loop/rdma: Host delete_work and
 reset_work on system workqueues
In-Reply-To: <20171221100752.18386-3-sagi@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-3-sagi@grimberg.me>
Message-ID: <6e87270a-ee67-4b93-e2c3-b977400f9e79@broadcom.com>

On 12/21/2017 2:07 AM, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
>
> We need to ensure that delete_work will be hosted on a different
> workqueue than all the works we flush or cancel from it.
> Otherwise we may hit a circular dependency warning [1].
>
> Also, given that delete_work flushes reset_work, host reset_work
> on system_wq and delete_work on system_long_wq. In addition,
> fix the flushing in the individual drivers to flush system_long_wq
> when draining queued deletes.
>
>
Any particular reason you didn't do similar mods for the fc transport ?

-- james
