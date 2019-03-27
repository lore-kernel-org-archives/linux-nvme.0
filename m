From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:16:33 +0100
Subject: [PATCH 01/15] block: add a req_bvec helper
In-Reply-To: <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-2-hch@lst.de>
 <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190327141633.GA26200@lst.de>

On Mon, Mar 25, 2019@05:07:44AM +0000, Chaitanya Kulkarni wrote:
> > +static inline struct bio_vec req_bvec(struct request *rq)
> > +{
> > +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
> > +		return rq->special_vec;
> Quick question here mostly for my understanding, do we also have to 
> check here for nr_phys_segments for the operations such as write-zeroes ? OR
> 
> this may never get called in write-zeroes context ? OR
> not applicable ?

We assume the caller checks that we have nr_phys_segments.  I'll
add a commen to document that.
