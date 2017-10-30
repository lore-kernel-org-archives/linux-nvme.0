From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 30 Oct 2017 10:11:54 +0200
Subject: [PATCH 2/2] nvme-rdma: Add remote_invalidation module parameter
In-Reply-To: <1509295101-14081-3-git-send-email-idanb@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-3-git-send-email-idanb@mellanox.com>
Message-ID: <4423f96f-bf42-3603-aa6a-fa259a1d09d1@grimberg.me>

Idan,

> NVMe over Fabrics in its secure "register_always" mode
> registers and invalidates the user buffer upon each IO.
> The protocol enables the host to request the susbsystem
> to use SEND WITH INVALIDATE operation while returning the
> response capsule and invalidate the local key
> (remote_invalidation).
> In some HW implementations, the local network adapter may
> perform better while using local invalidation operations.

This is a device quirk and if you want to optimize for this
you need to expose it via verbs interface. We won't add a module
parameter for implementation specific stuff.

Note that we currently need to rework the case where we use local
invalidates and properly wait for them to complete.
