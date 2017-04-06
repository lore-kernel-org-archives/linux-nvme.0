From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Apr 2017 11:34:03 +0300
Subject: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
In-Reply-To: <86ed1762-a990-691f-e043-3d7dcac8fe85@mellanox.com>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <86ed1762-a990-691f-e043-3d7dcac8fe85@mellanox.com>
Message-ID: <09b4dcb4-d0ab-43b7-5f1c-394ecfcce2f0@grimberg.me>

> Hi Sagi,

Hey Max,

> the patchset looks good and of course we can add support for more
> drivers in the future.
> have you run some performance testing with the nvmf initiator ?

I'm limited by the target machine in terms of IOPs, but the host shows
~10% cpu usage decrease, and latency improves slightly as well
which is more apparent depending on which cpu I'm running my IO
thread (due to the mismatch in comp_vectors and queue mappings
some queues have irq vectors mapped to a core on a different numa
node.
