From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Nov 2018 08:40:22 -0700
Subject: [PATCH 1/3] nvme: enable multipathing by default
In-Reply-To: <94c71f85-3ff8-ca11-05fa-b5a489c302d8@grimberg.me>
References: <20181120162734.2013-1-hch@lst.de>
 <20181120162734.2013-2-hch@lst.de>
 <20181120184749.GF26707@localhost.localdomain>
 <20181121082724.GA29231@lst.de>
 <94c71f85-3ff8-ca11-05fa-b5a489c302d8@grimberg.me>
Message-ID: <20181126154021.GO26707@localhost.localdomain>

On Wed, Nov 21, 2018@06:44:05PM -0800, Sagi Grimberg wrote:
> 
> >> This is okay with me, but I have one little follow-on I'd like to RFC here:
> >>
> >> The /dev/nvme naming convention with multiplath has broken people's
> >> minds, and making it default will invite a lot of repeat questions on
> >> how to match up block to admin handles.
> >>
> >> Could we promote /dev/nvme0 to be a subsystem handle instead of a
> >> controller handle, and add new per-controller handles, like /dev/nvme0c1,
> >> nvme0c2, etc...? The subsystem handle's management interface can just use
> >> the first active controller to forward admin commands, and per-controller
> >> specific administration can be taught to use the new handles as needed.
> >>
> >> Tooling shouldn't care about the names, but I am not sure if this could
> >> possibly break productino scripts. The naming disconnect has broken
> >> some things, though, so I hope this doesn't end up being a pick your
> >> poision suggestion...
> > 
> > The problem is that typical admin command are sensitive to the controller
> > they are sent to, so a per-subsystem handle does not make whole lot
> > sense.  But I like the idea of the nvmeXcY names.  Maybe we just keep
> > the nvmeX names as an additional alias for the first found controller
> > in a subsystem and otherwise use nvmeXcY?
> 
> Not sure if different naming conventions between controllers are a good
> idea..
> 
> What is the problem of simply changing nvmeX to nvmeXcY? if nvmeX is
> a must perhaps we can soft link nvmeX to nvmeXc1?

I am not aware of anything that has a hard dependency on /dev/nvmeX
being present, but I can't say if that applies to everyone. I'll check
with some internal folks if this will break there tools/workflows.

It will just take some minor shuffling of the initialization order to do
this since we currently assign the controller instance before we know
the subsystem instance. Otherwise, it should work.

I'll finish off the code and send separately. As far as this patch
series is concerned, looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
