From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 29 Jul 2016 23:00:17 +0300
Subject: NVMF/RDMA QP usage
In-Reply-To: <008801d1e8e1$217b4f30$6471ed90$@opengridcomputing.com>
References: <008801d1e8e1$217b4f30$6471ed90$@opengridcomputing.com>
Message-ID: <0cb180f3-7126-a620-3469-221322c46bcc@grimberg.me>


> Hey NVMF experts!

Hey Steve,

>
> Are NVMF/RDMA IOs to a given target device spread across the connected QPs in
> any particular fashion?  Is this tweakable?

It's on blk-mq, nothing fabrics specific about it, and its driven
from the submitting core (you can see the core->queue assignments
on the block device sysfs).
