From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 14 May 2018 16:00:12 -0600
Subject: [PATCHv2 blktests] nvme: Add command timeout injection test
In-Reply-To: <20180514210136.GE13417@vader>
References: <20180514204241.15300-1-keith.busch@intel.com>
 <20180514210136.GE13417@vader>
Message-ID: <20180514220012.GA15199@localhost.localdomain>

On Mon, May 14, 2018@02:01:36PM -0700, Omar Sandoval wrote:
> On Mon, May 14, 2018@02:42:41PM -0600, Keith Busch wrote:
> > This test will run a background IO process and inject an admin command
> > with a very short timeout that is all but guaranteed to expire without
> > a completion: the async event request.
> > 
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > ---
> > v1 -> v2:
> > 
> >   Changed description since its not a test for a specific
> >   regression-fixing patch.
> > 
> >   Added fio requirement.
> > 
> >   Missing quotes around device name.
> 
> I tried this on my QEMU VM, which apparently doesn't emulate this
> command:

Ah, qemu mainline isn't spec compliant and doesn't support AEN requests. I
was testing on real hardware.

This older one has support:

  http://git.infradead.org/users/kbusch/qemu-nvme.git/

It is quite old, though.
 
> Can this test use a loopback target like the nvme tests Johannes has
> added recently?

It looks like the in-kernel nvme target supports it. I'll have to give
it a try.
