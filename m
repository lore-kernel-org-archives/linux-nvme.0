From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jan 2018 13:17:16 -0700
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180129160145.GA25515@localhost.localdomain>
 <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>
Message-ID: <20180129201716.GB25515@localhost.localdomain>

On Mon, Jan 29, 2018@09:55:41PM +0200, Sagi Grimberg wrote:
> > Thanks for the fix. It looks like we still have a problem, though.
> > Commands submitted with the "shutdown_lock" held need to be able to make
> > forward progress without relying on a completion, but this one could
> > block indefinitely.
> 
> Can you explain to me why is the shutdown_lock needed to synchronize
> nvme_dev_disable? More concretely, how is nvme_dev_disable different
> from other places where we rely on the ctrl state to serialize stuff?
> 
> The only reason I see would be to protect against completion-after-abort
> scenario but I think the block layer should protect against it (checks
> if the request timeout timer fired).

We can probably find a way to use the state machine for this. Disabling
the controller pre-dates the state machine, and the mutex is there to
protect against two actors shutting the controller down at the same
time, like a hot removal at the same time as a timeout handling reset.
