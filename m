From: hch@lst.de (hch@lst.de)
Date: Wed, 19 Apr 2017 08:14:44 +0200
Subject: scsi: introduce a new result field in struct scsi_request
In-Reply-To: <1492554858.2689.17.camel@sandisk.com>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-8-hch@bombadil.infradead.org>
 <1492554858.2689.17.camel@sandisk.com>
Message-ID: <20170419061444.GB6257@lst.de>

On Tue, Apr 18, 2017@10:34:20PM +0000, Bart Van Assche wrote:
> Did you perhaps intend "req->result" instead of "rq->result"?

Yes.

> Did you intend "war" or is that perhaps a typo?

I'll fix the comment.

> >  	trace_scsi_dispatch_cmd_done(cmd);
> > -	blk_mq_complete_request(cmd->request, cmd->request->errors);
> > +	blk_mq_complete_request(cmd->request, 0);
> >  }
> 
> Why has cmd->request->errors been changed into 0?

Because the argument is only used to set req->errors, which we won't
look at any more.
