From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Feb 2019 08:30:40 -0700
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <c4db17c4-c9fb-cf79-12ae-e2d3ceab123a@suse.de>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
 <20190131161108.GA20811@localhost.localdomain>
 <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>
 <bcbfb9ea-88ff-d8c7-22ba-8f1df7104930@suse.de>
 <f973dcd6-3455-449d-bf5b-117647d04b12@mellanox.com>
 <20190208084216.GA23155@lst.de>
 <c4db17c4-c9fb-cf79-12ae-e2d3ceab123a@suse.de>
Message-ID: <20190208153039.GA32695@localhost.localdomain>

On Fri, Feb 08, 2019@12:49:47AM -0800, Johannes Thumshirn wrote:
> On 08/02/2019 09:42, Christoph Hellwig wrote:
> > I don't really care.  We clearly have command decoding in the trace
> > points, so adding a little more won't hurt, but I'm also not sure
> > we really need it.
> 
> Hmm one thing, *iff* we want to decode the commands in user-space we
> have to agree on one input format for the decoder which then becomes an
> ABI (see for example blktrace). If we decode in the kernel we can easily
> extent it (like we already did with the tracepoints).
> 
> IMHO maintaining an ABI like format is a major pain in the lower body
> parts and the benefits from it aren't worth it.

That's fine, I certainly won't nak this and am okay to see this staged for
the next merge window. I just wanted to confirm preference on maintaining
the kernel vs tooling as the spec changes.
