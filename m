From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 4 Dec 2018 14:26:02 -0800
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <1543876976.185366.175.camel@acm.org>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
 <1543876976.185366.175.camel@acm.org>
Message-ID: <20181204222602.GA12719@infradead.org>

On Mon, Dec 03, 2018@02:42:56PM -0800, Bart Van Assche wrote:
> On Thu, 2018-11-29@09:18 -0800, Chaitanya Kulkarni wrote:
> >  static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
> >  {
> > -	struct nvme_command c = { };
> > +	struct nvme_command c;
> >  	int error;
> >  
> > +	memset(&c, 0, sizeof(c));
> 
> Please drop this and all similar changes. I think the preferred style in the Linux
> kernel for structure initialization is to use "= { }" instead of memset().

I defintively prefer it.  But I don't think changing things either
way is really worth the effort anyway unless you change the surrounding
code to start with.
