From: idanb@mellanox.com (idanb)
Date: Mon, 30 Oct 2017 10:45:12 +0200
Subject: [PATCH 2/2] nvme-rdma: Add remote_invalidation module parameter
In-Reply-To: <4423f96f-bf42-3603-aa6a-fa259a1d09d1@grimberg.me>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-3-git-send-email-idanb@mellanox.com>
 <4423f96f-bf42-3603-aa6a-fa259a1d09d1@grimberg.me>
Message-ID: <2f9723ae-93f4-aeec-22b0-31634d52b3aa@mellanox.com>



On 10/30/2017 10:11 AM, Sagi Grimberg wrote:
> Idan,
>
>> NVMe over Fabrics in its secure "register_always" mode
>> registers and invalidates the user buffer upon each IO.
>> The protocol enables the host to request the susbsystem
>> to use SEND WITH INVALIDATE operation while returning the
>> response capsule and invalidate the local key
>> (remote_invalidation).
>> In some HW implementations, the local network adapter may
>> perform better while using local invalidation operations.
>
> This is a device quirk and if you want to optimize for this
> you need to expose it via verbs interface. We won't add a module
> parameter for implementation specific stuff.

After our discussion yesterday I was thinking it may be better to hide
it within the nvme host driver while having a messages size threshold for
using send_with_invalidate. To make it device agnostic we will need
to come out with an idea of how to expose such limitation.

>
> Note that we currently need to rework the case where we use local
> invalidates and properly wait for them to complete.
