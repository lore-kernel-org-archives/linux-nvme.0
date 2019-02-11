From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Feb 2019 13:06:23 -0700
Subject: nvme-cli argument passing for connect-all
In-Reply-To: <32dcb074-8d23-db13-9074-d0a8619b8baa@suse.de>
References: <32dcb074-8d23-db13-9074-d0a8619b8baa@suse.de>
Message-ID: <20190211200623.GE4525@localhost.localdomain>

On Mon, Feb 11, 2019@03:34:23PM +0100, Hannes Reinecke wrote:
> Hi Keith,
> 
> I've come across a bit of an awkward issue, and I really would like some
> clarification on how to move forward.
> 
> Thing is, for 'connect-all' we have to pass _all_ arguments (for connect
> _and_ discovery), yet not every argument is valid for both calls.
> Which means if we enable nvme-cli to accept the superset of those arguments
> one or the other call will fail.
> (Case in point: 'keep-alive-tmo' will return an error for discovery
> controllers, so we cannot set it when calling 'connect-all').
> 
> We now have two ways of solving it:
> 
> Either blank the incorrect options from nvme-cli, and ensure that we're only
> setting the valid options.
> However, when doing so we will have to keep nvme-cli in sync with the
> kernel, otherwise we'll never be setting this option even if at some later
> time one of these options becomes valid.
> 
> Or we can simply ignore the options from the kernel parser, giving us some
> more leeway when updating either side.
> (Case in point: the kernel will ignore the 'nr_io_queues' argument for
> discovery controllers)
> 
> Can we please decide on a common policy how to handle invalid arguments?
> Like accept _all_ known arguments for both, discovery _and_ connect, and
> only return errors for unknown arguments?
> 
> Cheers,
> 
> Hannes

Hi Hannes,

IMO, I think we should make the kernel handle this and ignore entries that
don't apply. The discovery controller seems to be the special case here,
and we don't even handle it consistently. For example, a discovery_nqn
will ignore nr_io_queues parms, but will consider KATA an error. Why
the difference there?

Thanks,
Keith
