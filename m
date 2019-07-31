From: kbusch@kernel.org (Keith Busch)
Date: Wed, 31 Jul 2019 08:16:59 -0600
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate
 failed because of controller reset
In-Reply-To: <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
References: <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
 <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
 <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>
 <82a91815-f7ed-5931-58ac-5893e68cc940@grimberg.me>
 <CACVXFVN6o+dOFwDV=FPSHjVnhYSLBUWNHsXc4B=fwE5PAny_dQ@mail.gmail.com>
 <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
 <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>
 <2825eb74-1df5-5dd2-3e90-c696bc7fa3d1@grimberg.me>
 <20190730173048.GC13948@localhost.localdomain>
 <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
Message-ID: <20190731141658.GB14402@localhost.localdomain>

On Wed, Jul 31, 2019@12:01:58AM -0700, Hannes Reinecke wrote:
> > I'm not too concerned about this corner case actually occuring in
> > practice, though.
> > 
> ... discarding those poor folks having to hunt down this very same issue
> for several months now ...
> 
> Yes, it _does_ occur.
> Not on PCI, mind, but definitely for FC. RDMA might have a slightly
> better chance of not hitting it, but even there we have seen it.

Fair enough! I'll re-read your patches with this better understanding
on the context. :)
