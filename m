From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 20:38:12 +0300
Subject: [PATCH 0/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180622195914.18575-1-scott.bauer@intel.com>
References: <20180622195914.18575-1-scott.bauer@intel.com>
Message-ID: <8263513b-a714-b669-b485-28e894106607@grimberg.me>


> This small patch is an attempt to fix a rare boundary condition.
> The only downside of the patch is scan work cannot happen concurrently,
> but I don't think that's possible outside of someone issuing a sysctl.
> 
> If the controller goes down during the admin command, the command will
> timeout, if the controller is in a poor enough state the reset commands
> will time out. After the original admin command timeout, we unblock userland
> which can start to revalidate the namespaces. In order todo that we
> aquire the controller namespace sempahore as WRITE. We then issue an admin
> command which times out, triggers a reset where we attempt to stop queues
> in dev_disable(). Stopping queues attempts to down_read on the semaphore,
> which is currently being held on a down write, waiting for this I/O to timeout.
> This I/O cannot timeout until the semaphore is dropped from down_write, and
> now we're deadlocked.
> 
> The patch does what nvme_remove_namespaces does, it takes over the controllers
> namespace list under the down_write. Then modifies the private list, potentially
> removing namespaces, and resplicing it once revalidation has occured. The whole
> goal is to *not* hold a down write while issuing admin commands.

Keith, can you explain why we need to disable the device from the
timeout handler instead of simply schedule a reset and return
BLK_EH_RESET_TIMER?

The only place where I *think* can't schedule a reset and need to
return BLK_EH_DONE is when the controller is already resetting, in which
case we'd simply need to cancel the timed out command.

What am I missing?
