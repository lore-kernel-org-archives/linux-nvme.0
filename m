From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 15:03:13 -0600
Subject: [PATCHv3 5/9] nvme-pci: End IO requests in CONNECTING state
In-Reply-To: <20180524204722.GB29048@lst.de>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-6-keith.busch@intel.com>
 <20180524204722.GB29048@lst.de>
Message-ID: <20180524210313.GL11037@localhost.localdomain>

On Thu, May 24, 2018@10:47:22PM +0200, Christoph Hellwig wrote:
> On Thu, May 24, 2018@02:34:56PM -0600, Keith Busch wrote:
> > IO is always quiesced in the CONNECTING state, so any any timeout for an
> > IO command had already been completed.
> > 
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > ---
> >  drivers/nvme/host/pci.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 6be88f662e7d..54e22b964385 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1227,6 +1227,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	 */
> >  	switch (dev->ctrl.state) {
> >  	case NVME_CTRL_CONNECTING:
> > +		/*
> > +		 * IO is never dispatched from the connecting state. If an IO
> > +		 * queue timed out here, the block layer missed the completion
> > +		 * the driver already requested, so return handled.
> > +		 */
> > +		if (nvmeq->qid)
> > +			return BLK_EH_HANDLED;
> 
> How can we hit this case?  This just looks a lot like papering
> over the real issue..

It'll most likley never really happen. The conditions are a pretty obscure
timeout handling cases mixed with other errors that could theoretically
hit it, requiring two or more namespaces.

The real fix, IMO, is wahat the blk-mq timeout enhancements are working
toward, so I've no problem dropping this patch.
