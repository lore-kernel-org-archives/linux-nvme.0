From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 11:48:41 +0200
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <20170208082743.GB7629@lst.de>
References: <1486507170-23285-1-git-send-email-parav@mellanox.com>
 <20170208082743.GB7629@lst.de>
Message-ID: <3824df02-ab98-2495-46b8-e632b8eff010@grimberg.me>


> This looks fine to me in general, but I'm a little curious how
> your arrived at that 2 number.  Why not 4 or 8?

Well, its preallocated with the request.

Maybe we can have a heuristic that will allocate dynamically according
to the max in-capsule data capability reported by the target (one sge
for each PAGE_SIZE)?
