From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 14:55:07 +0200
Subject: [PATCH 7/9] nvmet: add minimal ANA support
In-Reply-To: <20180604122507.wnjpvl34i4cwqsy6@linux-x5ow.site>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-8-hch@lst.de>
 <20180604122507.wnjpvl34i4cwqsy6@linux-x5ow.site>
Message-ID: <20180604125507.GA30945@lst.de>

On Mon, Jun 04, 2018@02:25:07PM +0200, Johannes Thumshirn wrote:
> On Fri, Jun 01, 2018@09:11:26AM +0200, Christoph Hellwig wrote:
> > Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> > TP 4004.
> > 
> > Just add a default ANA group 1 that is optimized on all ports.  This is
> > (and will remain) the default assignment for any namespace not epxlicitly
> > assigned to another ANA group.  The ANA state can be manually changed
> > through the configfs interface, including the change state.
> > 
> > Includes fixes and improvements from Hannes Reinecke.
> 
> Hmm I somehow miss the increment of nvmet_ana_chgcnt, here. Am I just
> blind or is this intended?

It is inteded.  As of this patch we report an immutable ANA state,
so nvmet_ana_chgcnt will never change.

Dynamic configuration is only added in the next patch, which also
(hopefully) increments nvmet_ana_chgcnt in all the right places.
