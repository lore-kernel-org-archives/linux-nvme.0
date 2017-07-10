From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 10:06:51 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170707094838.GD16648@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
Message-ID: <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>

Hey Johannes,

> I'm seeing this on stock v4.12 as well as on our backports.
> 
> My current hypothesis is that I saturate the RDMA link so the keepalives have
> no chance to get to the target.

Your observation seems correct to me, because we have no
way to guarantee that a keep-alive capsule will be prioritized higher
than normal I/O in the fabric layer (as you said, the link might be
saturated).

> Is there a way to priorize the admin queue somehow?

Not really (at least for rdma). We made kato configurable,
perhaps we should give a higher default to not see it even
in extreme workloads?

Couple of questions:
- Are you using RoCE (v2 or v1)? or Infiniband?
- Does it happen with mlx5 as well?
- Are host/target connected via switch/router? if so is flow-control
   on? and what are the host/target port speeds?
- Can you try and turn debug logging to know what delays (keep-alive
   from host to target or the keep-alive response)?
- What kato is required to not stumble on this?
