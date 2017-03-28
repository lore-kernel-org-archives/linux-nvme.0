From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 Mar 2017 13:32:56 +0300
Subject: BUG report: Invalid cross-device link while connecting with
 various nr-io-queues
In-Reply-To: <910e6625-1256-a6b4-68d3-c946f2b71aaf@mellanox.com>
References: <910e6625-1256-a6b4-68d3-c946f2b71aaf@mellanox.com>
Message-ID: <89604d8a-78e4-a754-7fd8-b5b1eedc38bd@grimberg.me>

...

> [1102928.407720] nvme nvme0: failed to connect i/o queue: -18
> [1102928.720957] nvme_rdma_find_get_device: enabling unsafe global rkey
> [1102928.777948] nvme nvme0: creating 14 I/O queues.
> [1102929.102588] nvme nvme0: Connect command failed, error wo/DNR bit:
> -16402
> [1102929.109029] nvme nvme0: failed to connect i/o queue: -18
> [1102929.422299] nvme_rdma_find_get_device: enabling unsafe global rkey
> [1102929.479662] nvme nvme0: creating 15 I/O queues.
> [1102929.828792] nvme nvme0: Connect command failed, error wo/DNR bit:
> -16402
> [1102929.835232] nvme nvme0: failed to connect i/o queue: -18
>
>
> have someone saw it before ?

I haven't, can you share what the target is logging?

This is strange because we get to an unknown connect error code...
