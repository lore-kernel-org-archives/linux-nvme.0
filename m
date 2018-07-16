From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 16 Jul 2018 09:35:41 -0600
Subject: [PATCHv4 2/4] nvme: Start controller in own work queue
In-Reply-To: <7647e947-f20c-a0eb-d4b5-f19748e2b4bd@grimberg.me>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-3-keith.busch@intel.com>
 <7647e947-f20c-a0eb-d4b5-f19748e2b4bd@grimberg.me>
Message-ID: <20180716153540.GA26265@localhost.localdomain>

On Mon, Jul 16, 2018@06:00:38PM +0300, Sagi Grimberg wrote:
> 
> > This moves the controller start from the reset_work to its own work.
> > This is preparing for the possibility of running IO when starting the
> > controller, which we shouldn't do from the reset_work since we need that
> > context to handle timeouts.
> 
> What do you mean handle timeouts? the timeout handler is not invoked
> from the reset_work thread.

Not directly. If you dispatch blocking IO from the reset_work, the timeout
handler will eventually be invoked if the IO never returns. This series
is really just trying to get all the blocking IO out of the reset_work
because IO may requeue when the timeout handler disables the controller,
and we need the reset_work to restart the controller.
