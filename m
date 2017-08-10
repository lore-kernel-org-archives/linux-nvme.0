From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 11:06:04 +0200
Subject: [PATCH 1/2] nvmet_fc: add defer_req callback for deferment of
 cmd buffer return
In-Reply-To: <20170801221240.31723-2-jsmart2021@gmail.com>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-2-jsmart2021@gmail.com>
Message-ID: <20170810090604.65ccmgooqzilhkjq@infradead.org>

> @@ -463,9 +472,9 @@ static struct nvmet_fc_fcp_iod *
>  nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgt_queue *queue)
>  {
>  	static struct nvmet_fc_fcp_iod *fod;

This isn't new, but is this really supposed to be a static variable,
that is all instances of this code sharing it use the same?

After a short code inspection this looks like a nasty bug to me.
