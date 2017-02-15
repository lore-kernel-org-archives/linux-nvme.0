From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 18:33:34 +0200
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <6f56f570-c0a9-0f8a-2459-ec49ea680364@mellanox.com>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
 <6f56f570-c0a9-0f8a-2459-ec49ea680364@mellanox.com>
Message-ID: <c31ba32e-eec0-da91-d924-738ec87be5cf@grimberg.me>


> Also, currently this is implemented for FC but I'll want to add an
> option for rdma too.
> so we'll be able to use it like that:
>
> nvme connect -t rdma -n testsubsystem -a <target_ip> -w <host_ip> -s 1023
>
> in case we want to choose the interface for rdma_resolve_addr.
> I'll put it on my plate.

That would be nice.
