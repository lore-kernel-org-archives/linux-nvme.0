From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 29 Oct 2017 19:09:41 +0200
Subject: [PATCH 0/2] Performance Improvents for Secured Mode NVMe over
 Fabrics and other RDMA ULPs
In-Reply-To: <e1ba4993-5c77-4754-967c-4da8ec34bf77@grimberg.me>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <e1ba4993-5c77-4754-967c-4da8ec34bf77@grimberg.me>
Message-ID: <8cb59a0a-c902-0c0e-27a8-fdf9b98982ac@mellanox.com>



On 10/29/2017 6:59 PM, Sagi Grimberg wrote:
> Hi Idan,
> 
> One minor nit, there is no "secured mode", its the normal sane
> mode. The other mode compromises insecurity for performance.
> 
>> The following two patches are including performance
>> optimizations for RDMA kernel ULPs that register/invalidate
>> per IO (e.g. NVMe over Fabrics, iSER, NFS RDMA). The patches
>> improve the IOPs could be achieved by a single network
>> adapter with the above ULPs, specifically for NVMe over
>> Fabrics the IOPs have improved x5 for small IO reads could
>> be achieved in Linux using a single network adapter.
> 
> That is very good! Thanks for doing this!
> You should note that its mlx5 specific enhancement, which is
> an important device, but its not a performance improvement for
> RDMA ULPs as it is.

Sagi,

the subject refers to both patches :)
And it mentions that more improvements are in the pipe, that will 
improve the small write IOs for NVMEoF (at first stage).

> 
> What about mlx4 btw?

We still haven't try to improve the mlx4, but it's on our plate.
