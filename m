From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 4 Jun 2018 14:25:07 +0200
Subject: [PATCH 7/9] nvmet: add minimal ANA support
In-Reply-To: <20180601071128.7630-8-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-8-hch@lst.de>
Message-ID: <20180604122507.wnjpvl34i4cwqsy6@linux-x5ow.site>

On Fri, Jun 01, 2018@09:11:26AM +0200, Christoph Hellwig wrote:
> Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> TP 4004.
> 
> Just add a default ANA group 1 that is optimized on all ports.  This is
> (and will remain) the default assignment for any namespace not epxlicitly
> assigned to another ANA group.  The ANA state can be manually changed
> through the configfs interface, including the change state.
> 
> Includes fixes and improvements from Hannes Reinecke.

Hmm I somehow miss the increment of nvmet_ana_chgcnt, here. Am I just
blind or is this intended?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
