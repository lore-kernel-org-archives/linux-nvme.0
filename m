From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Thu, 09 Jun 2016 23:34:20 -0700
Subject: [RFC 0/2] nvme/loop: Add support for controllers-per-port model
In-Reply-To: <20160609133937.GA29580@lst.de>
References: <1465356861-4321-1-git-send-email-nab@linux-iscsi.org>
 <20160608121448.GA31119@lst.de>
 <1465449233.5365.139.camel@haakon3.risingtidesystems.com>
 <20160609133937.GA29580@lst.de>
Message-ID: <1465540460.5365.194.camel@haakon3.risingtidesystems.com>

On Thu, 2016-06-09@15:39 +0200, Christoph Hellwig wrote:
> On Wed, Jun 08, 2016@10:13:53PM -0700, Nicholas A. Bellinger wrote:
> > I still don't see why a loopback controller on a port of an individual
> > subsystem NQN can't be created + deleted directly from configfs, and
> > operate independently of other loopback controllers on a port of a
> > different subsystem NQNs.
> 
> I think you are misunderstanding the NVMe entities - there is no port
> of a subsystem.  There are port, and there are subsystems and there
> is an N to M relation between them, not an N to one relation.
> 

Yes, the mapping of subsystem NQNs and ports works identically to how
iscsi IQNs and network portals work.

That is, network portals can be setup across multiple IQNs, or setup
specifically to one IQN.

> Multiple controllers may and usually will use the same port to access
> one or more subsystems, but multiple controllers may also use different
> ports to use the same subsystem.
> 

Yes.  Also similar to MC/S in a single IQN across multiple network
portals setup.  ;)

> For full NVMe functionality we thus need to be able to create all
> these objects indepdently.

Yes.

> While loopback ports are extremtly cheap
> I see no reason to introduce a shortcut to break this model for our
> debug local implementation - the whole point of the loopback driver
> is to give you the full NVMe over Fabrics experience without needing
> an (possibly expensive) transport.
> 

I think making this extra step for loopback in pointless, and just adds
unnecessary list lookups, and is something that configfs is better
suited to handle directly.

But loopback is a special case, both for drivers/target/loopback/ and
driver/nvme/target/loop.c code.

So why not just let configfs do it..?

However, your point is taken about using the global hostnqn for loopback
controllers in this patch.  Following what we do for SCSI loopback, I
think it makes the sense to have each loopback subsystem port setup it's
own hostnqn instead.

Updating the patch to do this.

> > > Something like the patch below is the right way, it just needs a bit more
> > > fine tuning and proper test cases:
> > 
> > I don't see how adding a internal mutex for loopback ports, and doing
> > internal sequential list lookup holding the global nvmet_config_sem
> > whilst doing nvmet_fabric_ops->add_port() helps to scale at all..
> 
> Scalability of the controller creation is not the prime goal for the
> nvme-loop driver.  It's supposed to be the simples possible implementation
> of a NVMe over Fabrics transport.
> 

Btw, I consider adding a global list for loopback to be 'less' simple.

> > AFAICT for loopback, neither of these is necessary.  Why can't a
> > loopback controller on a port for a individual subsystem NQN be created
> > + deleted directly from configfs,
> 
> We could trivially do this, but I think it's counter productive.  NVMe
> over Fabrics does not automatically create one or multiple controllers,
> and nvme-loop is just another transport that follows the higher level
> spec.
> 

I disagree.  The more interesting question is if to enforce a limit to
the amount of loopback ports that be allocated with this patch
per /sys/kernel/config/nvmet/subsystems/$NQN.FOO/.

That is, each echo 1 > ../$NQN_FOO/$ANY_LOOPBACK/enable will create it's
own controller, regardless if another loopback controller already exists
on the subsystem NQN.

Leaving that as-is for -v2.
