From: kbusch@kernel.org (Keith Busch)
Date: Wed, 14 Aug 2019 10:27:54 -0600
Subject: [PATCH] nvme: Use first ctrl->instance id as subsystem id
In-Reply-To: <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
Message-ID: <20190814162754.GB3256@localhost.localdomain>

On Wed, Aug 14, 2019@09:18:22AM -0700, Guilherme G. Piccoli wrote:
> On 14/08/2019 13:06, Keith Busch wrote:
> > On Wed, Aug 14, 2019@07:28:36AM -0700, Guilherme G. Piccoli wrote:
> >>[...]
> > 
> > The subsystem lifetime is not tied to a single controller's. Disconnect
> > the "first" controller in a multipathed subsystem with this patch, then
> > connect another controller from a different subsystem, and now you will
> > create naming collisions.
> > 
> 
> Hi Keith, thanks for your clarification. Isn't the controller id unique?
> Could the new connected controller from a different subsystem have the
> same id? If you can give a rough example I appreciate.

Sure, start with nvme subsystem A, with host connected to to
controllers, X and Y.

 ctrl X gets instance 0, which you assign to the newly discovered
 subsytem

 ctrl Y gets instance 1

 disconnect ctrl X, which releases instance 0 back to the allocator

 connect to a new ctrl Z in new subsystem B: ctrl Z gets the first
 available instance, which is now 0, and you assign that name to the new
 susbystem, colliding with the sysfs nvme-subsys entries we've created
 for subsys A, as well as any namespaces.
 
> But given the above statement is a fact, what do you think of trying the
> ctrl->instance first and in case we have duplicity, fallback to
> subsystem ID allocator?

At the point we assign the subsystem identifier, we're locked into using
that for the namespace names, which may be discovered long before we're
aware the host has multiple connections to the same subsystem.

I think it'd be better to just completely disassociate any notion of
relationships based on names. The following patch enforces that way of
thinking:

  http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
