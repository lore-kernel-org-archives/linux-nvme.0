From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jun 2017 11:37:50 -0400
Subject: nvme defintions not used in the kernel
In-Reply-To: <20170628231129.GA20902@lst.de>
References: <20170628231129.GA20902@lst.de>
Message-ID: <20170629153749.GD3110@localhost.localdomain>

On Thu, Jun 29, 2017@01:11:29AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> currently nvme-cli supports various nvme features that are not
> needed in the kernel and keeps them in its own nvme.h file,
> in addition to pulling in the kernel one.
> 
> Do we want to keep it that way in the long run, or just add
> things to nvme.h in the kernel even if they are not used to
> keep things in a single place.
> 
> To me the latter would seem a little nicer, especially as it
> doesn't involve a whole lot of defintion.

Hm, the only thing nvme-cli should be copying from Linux is the headers
defining ioctls and their arguments. The specification defined structures
and commands should be OS agnostic in the tooling, so personally I think
it's less work to let them evolve independently.

That said, it's a nice goal to keep them in sync if someone wants to
put the effort into that.
