From: talgi@mellanox.com (Tal Gilboa)
Date: Thu, 2 May 2019 08:45:02 +0000
Subject: [PATCH rdma-for-next 0/9] drivers/infiniband: Introduce rdma_dim
In-Reply-To: <20190501160409.GA15547@ziepe.ca>
References: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
 <20190501160409.GA15547@ziepe.ca>
Message-ID: <a6ca622e-9203-e69c-8d34-22e151529f0a@mellanox.com>

On 5/1/2019 7:04 PM, Jason Gunthorpe wrote:
> 
> A lot of this is touching netdev, why wasn't netdev cc'd?
> 
> Who is supposed to merge this?
> 
> I think you need to take two steps and have netdev merge the above
> part and then send the single patch to RDMA for the last part, I don't
> really want to take so much netdev code here.

Ok, I'll submit the first 7 patches to netdev and the 2 RDMA specific 
patches will be submitted on top of them.

> 
> The maintainers file should also have some indication which tree
> patches for lib/dim/* this should go through..
> 
> Jason
> 
