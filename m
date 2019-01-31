From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Jan 2019 14:05:49 -0700
Subject: [PATCH] nvme-pci: Fix rapid add remove sequence
In-Reply-To: <a3b0f71e-0694-36eb-4eff-2a20d51a6d5d@grimberg.me>
References: <20190124014611.8643-1-keith.busch@intel.com>
 <a3b0f71e-0694-36eb-4eff-2a20d51a6d5d@grimberg.me>
Message-ID: <20190131210548.GA21082@localhost.localdomain>

On Thu, Jan 31, 2019@12:54:03PM -0800, Sagi Grimberg wrote:
> 
> > A surprise removal may fail to tear down request queues if it is racing
> > with the initial asynchronous probe. If that happens, the remove path
> > won't see the queue resources to tear down, and the controller reset
> > path may create a new request queue on a removed device, but will not
> > be able to make forward progress, deadlocking the pci removal.
> 
> Doesn't pci removal flush the reset work before making forward
> progress? Perhaps what is needed that it will flush it earlier instead
> of serializing with the shutdown lock?

Removal does flush reset work, but doesn't help this particular
issue. It's pretty timing sensitive to trigger.

Before flushing reset on an surprise removal, we do an ungraceful device
teardown first in order to unblock any IO that reset work is waiting on.

In this case that Alex discovered, though, the surprise removal happens
just before the nvme driver has set up the admin and io tagsets, so
removal doesn't find any tagsets to kill, and proceeds with flushing
the reset work.

The reset work, though, just allocated brand new tagsets right after
that, so it looks like they are good to use, so dispatches an admin
command to a device that's gone.

You might expect the nvme_timeout() work to trigger 60 seconds later,
but we can't use that when the pci device is not in a normal channel
state. I wouldn't want to wait 60 seconds either, so the removal task
needs to handle get things unblocked.
