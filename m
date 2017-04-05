From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Apr 2017 16:50:22 +0200
Subject: [PATCH 1/5] nvme: move ->retries setup to nvme_setup_cmd
In-Reply-To: <20170405144334.GO3941@linux-x5ow.site>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-2-hch@lst.de> <20170405144334.GO3941@linux-x5ow.site>
Message-ID: <20170405145022.GA5521@lst.de>

On Wed, Apr 05, 2017@04:43:34PM +0200, Johannes Thumshirn wrote:
> On Wed, Apr 05, 2017@04:18:52PM +0200, Christoph Hellwig wrote:
> > This way we get the behavior right for the non-PCIe transports.
> 
> Could you please share a bit of your minds inner workings for us mere mortals?

It's initialized to zero the first time the command is submitted
and will then be incremented when queueing a retry.
