From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 3 Jul 2019 13:19:11 -0600
Subject: [PATCH 0/2] Fix use-after-free bug when ports are removed
In-Reply-To: <20190703170136.21515-1-logang@deltatee.com>
References: <20190703170136.21515-1-logang@deltatee.com>
Message-ID: <081f5e37-19de-228c-6c37-a82b8fb29932@deltatee.com>



On 2019-07-03 11:01 a.m., Logan Gunthorpe wrote:
> Hey,
> 
> NVME target ports can be removed while there are still active
> controllers. Largely this is fine, except some admin commands
> can access the req->port (for example, id-ctrl uses the port's
> inline date size as part of it's response). This was found
> while testing with KASAN.
> 
> Two patches follow which disconnect active controllers when the
> ports are removed for loop and rdma. I'm not sure if fc has the
> same issue and have no way to test this.

Oh, I also should have done a similar patch for tcp... Forgot about that
one. It looks fairly straight forward, though (unlike fc).

Logan
