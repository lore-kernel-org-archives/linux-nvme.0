From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 21:15:16 +0200
Subject: blk-mq: fix racy updates of rq->errors
In-Reply-To: <20151012190522.GB31736@lst.de>
References: <20151006185442.GA19820@mwanda> <20151012190522.GB31736@lst.de>
Message-ID: <20151012191516.GA31985@lst.de>

On Mon, Oct 12, 2015@09:05:22PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 06, 2015@09:54:42PM +0300, Dan Carpenter wrote:
> >    622                  if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
> >    623                          if (cmd_rq->ctx == CMD_CTX_CANCELLED)
> >    624                                  status = -EINTR;
> > 
> > This looks like it's supposed to be a bitmap.
> 
> It's not - it's a value that can have either positive (nvme status codes)
> or negative Linux errnos.  It really should be an int just like req->errors
> was before.  I'll send a patch to Jens.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

And next time I'll wait with the signoff until I've tested and sent
the patch :)
