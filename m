From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Mar 2018 10:41:22 -0700
Subject: [PATCH stable 4.14.y] nvme-rdma: don't suppress send completions
In-Reply-To: <20180307172721.GG7097@kroah.com>
References: <20180305193215.23008-1-sagi@grimberg.me>
 <20180307172721.GG7097@kroah.com>
Message-ID: <20180307174121.GB3766@localhost.localdomain>

On Wed, Mar 07, 2018@09:27:21AM -0800, Greg KH wrote:
> On Mon, Mar 05, 2018@09:32:15PM +0200, Sagi Grimberg wrote:
> > The entire completions suppress mechanism is currently broken because the
> > HCA might retry a send operation (due to dropped ack) after the nvme
> > transaction has completed.
> > 
> > In order to handle this, we signal all send completions and introduce a
> > separate done handler for async events as they will be handled differently
> > (as they don't include in-capsule data by definition).
> > 
> > Cc: <stable at vger.kernel.org> # v4.14+
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> > Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > ---
> >  drivers/nvme/host/rdma.c | 54 +++++++++++++-----------------------------------
> >  1 file changed, 14 insertions(+), 40 deletions(-)
> 
> What is the git commit id for this patch in Linus's tree?

Commit b4b591c87f2b0f4ebaf3a68d4f13873b241aa584 upstream
