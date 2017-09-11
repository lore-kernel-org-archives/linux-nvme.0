From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Sep 2017 13:57:25 +0200
Subject: [PATCH] string.h: un-fortify memcpy_and_pad
In-Reply-To: <1505123078.4683.5.camel@suse.de>
References: <20170831182101.0e4ad9a2@canb.auug.org.au>
 <20170906123657.25534-1-mwilck@suse.com> <1505123078.4683.5.camel@suse.de>
Message-ID: <20170911115725.GB21472@lst.de>

> Hello Stephen and Christoph,
> 
> my broken patch 01f33c336e2d is in Linus' tree and causing compiler
> warnings there. Could you please take care that this fix is pulled in
> on top of it? Or should I take another action myself?

string.h is a bit of a maintainers no mans land.  Given that the
problematic commit came in through the nvme tree I've applied your
patch and will sned it to Jens with the next batch of nvme updates
tonight.
