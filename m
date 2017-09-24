From: hch@lst.de (Christoph Hellwig)
Date: Sun, 24 Sep 2017 16:53:41 +0200
Subject: [PATCH v2] nvme-fabrics: request transport module
In-Reply-To: <892afcbe-b947-af99-c640-58e84f26493d@wdc.com>
References: <1506258955-18109-1-git-send-email-sagi@grimberg.me>
 <892afcbe-b947-af99-c640-58e84f26493d@wdc.com>
Message-ID: <20170924145341.GA14806@lst.de>

On Sun, Sep 24, 2017@04:33:14PM +0200, Damien Le Moal wrote:
> > Help userspace to not make sure transport module is
> > loaded.
> > 
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> Shouldn't this read "Help userspace to make sure transport module is
> loaded." ?
> Extra "not"...

It should.  Be except for that typo the patch looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
