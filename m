From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 May 2019 08:16:50 +0200
Subject: [PATCH, RFC 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <SN6PR04MB45279ACEF3572C4F1F00ADF586320@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190508075508.28552-1-hch@lst.de>
 <20190508075508.28552-2-hch@lst.de>
 <SN6PR04MB45279ACEF3572C4F1F00ADF586320@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190509061650.GC15229@lst.de>

On Wed, May 08, 2019@06:51:51PM +0000, Chaitanya Kulkarni wrote:
> > +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->state == NVME_CTRL_DELETING ||
> > +		    ctrl->state == NVME_CTRL_DEAD)
> nvme_change_ctrl_state() is using spinlock to protect the ctrl->state.
> Do we need to protect above check with the spinlock ?

There isn't really any point in taking a lock for doing a read of
a single value from a less than register sized field.  As soon as we
drop the lock the value might change anyway.
