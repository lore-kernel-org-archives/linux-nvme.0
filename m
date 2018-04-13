From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:30:04 +0200
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
 <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
Message-ID: <20180413173004.GC23674@lst.de>

On Fri, Mar 30, 2018@12:13:28PM -0600, Logan Gunthorpe wrote:
> I *really* dislike this interface. Not only is the "pt" directory
> confusing to the user, it's nearly identical to what a subsystem is. So
> as developers, if we want to add a config option to a subsystem we also
> have to add it to the equivalent pt. I've already seen one patch set
> that would be mutually exclusive to this only because of the
> configuration mess.
> 
> I'd much rather see either a couple new attributes in the existing
> subsystem

Maybe.  But how would you design it?  Have a passthrough filed under
the subsystem that you can echo a controller name to?  And then make
the exclusive vs creating namespaces?

> or some mechanism such that if you create a namespace that
> points to a controller (eg /dev/nvme1) it takes it as though you're
> trying to pass through the whole NVMe device. (The code would need to
> ensure that a passthrough subsystem configured this way could only have
> exactly one namespace.)

Ugg.  Hell no!  Way too much magic.
