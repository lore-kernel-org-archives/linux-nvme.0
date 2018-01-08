From: snitzer@redhat.com (Mike Snitzer)
Date: Mon, 8 Jan 2018 10:29:33 -0500
Subject: [PATCH 1/5] nvme: Add more command status translation
In-Reply-To: <20180108101937.GA5423@lst.de>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-2-keith.busch@intel.com>
 <20180108095512.GC4673@lst.de>
 <2beb72a9-8502-fec8-8892-208cbb0967ac@suse.com>
 <20180108101937.GA5423@lst.de>
Message-ID: <20180108152933.GA9920@redhat.com>

On Mon, Jan 08 2018 at  5:19am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Jan 08, 2018@11:09:03AM +0100, Hannes Reinecke wrote:
> > >>  	case NVME_SC_SUCCESS:
> > >>  		return BLK_STS_OK;
> > >>  	case NVME_SC_CAP_EXCEEDED:
> > >> +	case NVME_SC_LBA_RANGE:
> > >>  		return BLK_STS_NOSPC;
> > > 
> > > lba range isn't really enospc.  It is returned when the lba in
> > > the command is outside the logical size of the namespace.
> > > 
> > Isn't that distinction pretty academic?
> > The entire block-to-POSIX error mapping is pretty much ad-hoc anyway...
> 
> Yes, BLK_STS_NOSPC matters.  And the fix is pretty trivial, so there is
> no point in arguing.

No argument needed.  Definitely needs fixing.  Too many upper layers
consider BLK_STS_NOSPC retryable (XFS, ext4, dm-thinp, etc).  Which
NVME_SC_LBA_RANGE absolutely isn't.

When I backfilled NVME_SC_LBA_RANGE handling I categorized it as
BLK_STS_TARGET.  Do you have a better suggestion for how
NVME_SC_LBA_RANGE should be categorized?

Mike
