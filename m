From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:19:39 +0100
Subject: [PATCH 02/15] block: add a rq_integrity_vec helper
In-Reply-To: <SN6PR04MB4527A9C0E360C5991F9E00A6865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-3-hch@lst.de>
 <SN6PR04MB4527A9C0E360C5991F9E00A6865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190327141939.GB26200@lst.de>

On Mon, Mar 25, 2019@05:10:20AM +0000, Chaitanya Kulkarni wrote:
> > +/*
> > + * Return the first bvec that contains integrity data.  In general only
> > + * drivers that are limited to a single integrity segment should use this
> > + * helper.
> > + */
> > +static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +{
> Wrt comment, should we add a check here to make sure underlaying driver
> has limited single integrity segment ?

I've added a WARN_ON_ONCE.
