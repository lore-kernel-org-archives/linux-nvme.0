From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 19 May 2018 08:01:42 +0800
Subject: [PATCH 1/6] nvme: Sync request queues on reset
In-Reply-To: <20180518234408.GA31749@localhost.localdomain>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518223210.GB18334@ming.t460p>
 <20180518234408.GA31749@localhost.localdomain>
Message-ID: <20180519000141.GB19799@ming.t460p>

On Fri, May 18, 2018@05:44:08PM -0600, Keith Busch wrote:
> On Sat, May 19, 2018@06:32:11AM +0800, Ming Lei wrote:
> > This way can't sync timeout reliably, since timeout events can
> > come from two NS at the same time, and one may be handled as
> > RESET_TIMER, and another one can be handled as EH_HANDLED.
> 
> You keep saying that, but the controller state is global to the
> controller. It doesn't matter which namespace request_queue started the
> reset: every namespaces request queue sees the RESETTING controller state

When timeouts come, the global state of RESETTING may not be updated
yet, so all the timeouts may not observe the state.

Please see my previous explanation:

https://marc.info/?l=linux-block&m=152600464317808&w=2


Thanks,
Ming
