From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 13:08:03 -0600
Subject: [PATCH 0/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <8263513b-a714-b669-b485-28e894106607@grimberg.me>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <8263513b-a714-b669-b485-28e894106607@grimberg.me>
Message-ID: <20180627190803.GD9361@localhost.localdomain>

On Sun, Jun 24, 2018@08:38:12PM +0300, Sagi Grimberg wrote:
> 
> > This small patch is an attempt to fix a rare boundary condition.
> > The only downside of the patch is scan work cannot happen concurrently,
> > but I don't think that's possible outside of someone issuing a sysctl.
> > 
> > If the controller goes down during the admin command, the command will
> > timeout, if the controller is in a poor enough state the reset commands
> > will time out. After the original admin command timeout, we unblock userland
> > which can start to revalidate the namespaces. In order todo that we
> > aquire the controller namespace sempahore as WRITE. We then issue an admin
> > command which times out, triggers a reset where we attempt to stop queues
> > in dev_disable(). Stopping queues attempts to down_read on the semaphore,
> > which is currently being held on a down write, waiting for this I/O to timeout.
> > This I/O cannot timeout until the semaphore is dropped from down_write, and
> > now we're deadlocked.
> > 
> > The patch does what nvme_remove_namespaces does, it takes over the controllers
> > namespace list under the down_write. Then modifies the private list, potentially
> > removing namespaces, and resplicing it once revalidation has occured. The whole
> > goal is to *not* hold a down write while issuing admin commands.
> 
> Keith, can you explain why we need to disable the device from the
> timeout handler instead of simply schedule a reset and return
> BLK_EH_RESET_TIMER?
> 
> The only place where I *think* can't schedule a reset and need to
> return BLK_EH_DONE is when the controller is already resetting, in which
> case we'd simply need to cancel the timed out command.
> 
> What am I missing?

The reset, removing, and dead states.

It was done this way for a few reasons, some of which have changed. We
didn't actualy have the nvme state machine back then, so we didn't know
what state we were in, which forced the remove case to have lots of odd
work-queue syncs.

When an IO times out because a controller is stuck, we'll often time
them out in batches. By disabling the controller inline with the timeout
handler, we handle every single timed out command in a single call to
the nvme timeout handler instead of 1000's of them, and since we were
already in a work-queue, we are conveniently in a context that can handle
a timeout inline with the notification.

The other reason was how the blk-mq timeout handler worked. It was
creating restrictions on when a driver can complete a request, and
returning BLK_EH_HANDLED was the only way we could deterministically
get the request actually completed.

We might be able to revisit the nvme-pci behavior now that blk-wq
timeout works very differently, but I'll have to wait to see if the
current behavior is settled or not.
