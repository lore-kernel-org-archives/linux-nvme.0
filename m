From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 18:59:17 +0200
Subject: [PATCH 0/2] Performance Improvents for Secured Mode NVMe over
 Fabrics and other RDMA ULPs
In-Reply-To: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
Message-ID: <e1ba4993-5c77-4754-967c-4da8ec34bf77@grimberg.me>

Hi Idan,

One minor nit, there is no "secured mode", its the normal sane
mode. The other mode compromises insecurity for performance.

> The following two patches are including performance
> optimizations for RDMA kernel ULPs that register/invalidate
> per IO (e.g. NVMe over Fabrics, iSER, NFS RDMA). The patches
> improve the IOPs could be achieved by a single network
> adapter with the above ULPs, specifically for NVMe over
> Fabrics the IOPs have improved x5 for small IO reads could
> be achieved in Linux using a single network adapter.

That is very good! Thanks for doing this!
You should note that its mlx5 specific enhancement, which is
an important device, but its not a performance improvement for
RDMA ULPs as it is.

What about mlx4 btw?
