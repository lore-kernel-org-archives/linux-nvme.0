From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:19:43 +0100
Subject: [PATCH 0/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <f235714b-6f3c-eba7-4f37-5bef6dab600e@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
 <20181116082659.GA14334@lst.de>
 <f235714b-6f3c-eba7-4f37-5bef6dab600e@suse.de>
Message-ID: <20181120161943.GA2755@lst.de>

On Tue, Nov 20, 2018@05:02:14PM +0100, Hannes Reinecke wrote:
> Also once we abandon direct NUMA mapping there's no good reason why we 
> should be selecting paths based on NUMA node; it might actually be better 
> to use the core id here, as then we could map as many paths as we have 
> CPUs.

True.

> So in the end the round-robin scheduler was just easier to implement, and 
> actually provided better performance on my testbed.

Oh well.  I guess we can pick it up as a tribute to FC given that it
isn't all that horrible.  I just hate using a dumb scheme like round
robin when we otherwise spend all our time optimizing every last cycle
and cache line.  I'll do another detailed review and will consider
picking it up as a non-default choice.
