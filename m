From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 10 Apr 2017 13:05:50 -0500
Subject: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
In-Reply-To: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
Message-ID: <14fd128d-7155-ab13-492f-952f072808d5@opengridcomputing.com>

On 4/2/2017 8:41 AM, Sagi Grimberg wrote:
> This patch set is aiming to automatically find the optimal
> queue <-> irq multi-queue assignments in storage ULPs (demonstrated
> on nvme-rdma) based on the underlying rdma device irq affinity
> settings.
>
> First two patches modify mlx5 core driver to use generic API
> to allocate array of irq vectors with automatic affinity
> settings instead of open-coding exactly what it does (and
> slightly worse).
>
> Then, in order to obtain an affinity map for a given completion
> vector, we expose a new RDMA core API, and implement it in mlx5.
>
> The third part is addition of a rdma-based queue mapping helper
> to blk-mq that maps the tagset hctx's according to the device
> affinity mappings.
>
> I'd happily convert some more drivers, but I'll need volunteers
> to test as I don't have access to any other devices.

I'll test cxgb4 if you convert it. :)
