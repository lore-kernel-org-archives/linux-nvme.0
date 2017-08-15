From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Aug 2017 12:58:34 +0300
Subject: [PATCH 1/1] nvme-rdma: Use unlikely macro in the fast path
In-Reply-To: <c7105632-b69e-7a7c-d700-dfb224e32ebc@mellanox.com>
References: <1502713766-10055-1-git-send-email-maxg@mellanox.com>
 <407fda2c-b54d-a4a6-7504-a7fc51a416f5@grimberg.me>
 <c7105632-b69e-7a7c-d700-dfb224e32ebc@mellanox.com>
Message-ID: <73d33114-8930-045a-b2c5-89ef34d87ff0@grimberg.me>


> 1 subsystem, 1 ns (null blk backing device)
> 
> 
> bs      (w/w.o)
> ---    ---------
> 512:    912k/900k
> 1k:     912k/900k
> 2k :    911k/901k
> 4k:     922k/906k

That's somewhat surprising...

Thanks
