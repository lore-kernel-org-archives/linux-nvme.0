From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 1 Apr 2019 15:55:09 +0200
Subject: [PATCH stable only] nvmet: set loop queue's segment boundary
 mask as PAGE_SIZE - 1
In-Reply-To: <20190328005505.GB19708@ming.t460p>
References: <20190327090230.12671-1-ming.lei@redhat.com>
 <20190327161658.GL25262@sasha-vm>
 <20190328005505.GB19708@ming.t460p>
Message-ID: <20190401135509.GC23581@kroah.com>

On Thu, Mar 28, 2019@08:55:06AM +0800, Ming Lei wrote:
> On Wed, Mar 27, 2019@12:16:58PM -0400, Sasha Levin wrote:
> > On Wed, Mar 27, 2019@05:02:30PM +0800, Ming Lei wrote:
> > > NVMe target only accepts single-page sg list, either file or block
> > > device backed target code follows this assumption.
> > > 
> > > However, loop target is one exception, given the sg list is from
> > > the host queue directly.
> > > 
> > > This patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
> > > for following NVMe target assumption.
> > > 
> > > Reported-by: Yi Zhang <yi.zhang at redhat.com>
> > > Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
> > > Cc: Yi Zhang <yi.zhang at redhat.com>
> > > Cc: Sagi Grimberg <sagi at grimberg.me>
> > > Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> > > Cc: <stable at vger.kernel.org>
> > > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> > 
> > Could you provide some background as to why this is -stable only in the
> > commit message?
> 
> Multi-page bvec has been merged to linus tree already, so the following
> patch simply can fix the current issue without needing to limit the segment
> size for nvme-loop:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-March/023105.html

Can you resend the patch with this needed information in it?  Also, I
don't understand what you are referring to with that url, why can't we
just use that patch?

thanks,

greg k-h
