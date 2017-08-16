From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 16 Aug 2017 00:53:43 -0700
Subject: [PATCH 1/2] nvmet_fc: add defer_req callback for deferment of
 cmd buffer return
In-Reply-To: <20170810090604.65ccmgooqzilhkjq@infradead.org>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-2-jsmart2021@gmail.com>
 <20170810090604.65ccmgooqzilhkjq@infradead.org>
Message-ID: <20170816075343.GA30644@infradead.org>

On Thu, Aug 10, 2017@11:06:04AM +0200, Christoph Hellwig wrote:
> > @@ -463,9 +472,9 @@ static struct nvmet_fc_fcp_iod *
> >  nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgt_queue *queue)
> >  {
> >  	static struct nvmet_fc_fcp_iod *fod;
> 
> This isn't new, but is this really supposed to be a static variable,
> that is all instances of this code sharing it use the same?
> 
> After a short code inspection this looks like a nasty bug to me.

James, can you look into this asap?
