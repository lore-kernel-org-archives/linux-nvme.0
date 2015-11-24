From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Nov 2015 16:32:35 +0100
Subject: [PATCH 06/47] blk-mq: add a flags parameter to
 blk_mq_alloc_request
In-Reply-To: <x49io4r2zmt.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-7-git-send-email-hch@lst.de>
 <x49io4r2zmt.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20151124153235.GA5939@lst.de>

On Tue, Nov 24, 2015@10:19:54AM -0500, Jeff Moyer wrote:
> >  drivers/block/mtip32xx/mtip32xx.c |    2 +-
> >  drivers/nvme/host/core.c          | 1172 +++++++++++++++++++++++++++++++++++++
> 
> Christoph, I think you included a bit too much in this patch!  ;-)

Oops, looks like once of these weird git-rebase failure cases that
are totally non-obvious.  I'll push out another rebase with these
issues fixed after a few more review comments come in.
