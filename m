From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 09:27:24 +0100
Subject: [PATCH 1/3] nvme: enable multipathing by default
In-Reply-To: <20181120184749.GF26707@localhost.localdomain>
References: <20181120162734.2013-1-hch@lst.de>
 <20181120162734.2013-2-hch@lst.de>
 <20181120184749.GF26707@localhost.localdomain>
Message-ID: <20181121082724.GA29231@lst.de>

On Tue, Nov 20, 2018@11:47:49AM -0700, Keith Busch wrote:
> This is okay with me, but I have one little follow-on I'd like to RFC here:
> 
> The /dev/nvme naming convention with multiplath has broken people's
> minds, and making it default will invite a lot of repeat questions on
> how to match up block to admin handles.
> 
> Could we promote /dev/nvme0 to be a subsystem handle instead of a
> controller handle, and add new per-controller handles, like /dev/nvme0c1,
> nvme0c2, etc...? The subsystem handle's management interface can just use
> the first active controller to forward admin commands, and per-controller
> specific administration can be taught to use the new handles as needed.
> 
> Tooling shouldn't care about the names, but I am not sure if this could
> possibly break productino scripts. The naming disconnect has broken
> some things, though, so I hope this doesn't end up being a pick your
> poision suggestion...

The problem is that typical admin command are sensitive to the controller
they are sent to, so a per-subsystem handle does not make whole lot
sense.  But I like the idea of the nvmeXcY names.  Maybe we just keep
the nvmeX names as an additional alias for the first found controller
in a subsystem and otherwise use nvmeXcY? 
