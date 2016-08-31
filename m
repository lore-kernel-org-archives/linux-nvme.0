From: keith.busch@intel.com (Keith Busch)
Date: Wed, 31 Aug 2016 10:54:41 -0400
Subject: [PATCH v2] nvme-cli/fabrics: Add nr_io_queues parameter to
 connect command
In-Reply-To: <1472499553.2816.31.camel@linux.intel.com>
References: <20160829155725.A031AE08C5@smtp.ogc.us>
 <1472496727.2816.27.camel@linux.intel.com>
 <019601d2022a$2017d340$604779c0$@opengridcomputing.com>
 <1472499553.2816.31.camel@linux.intel.com>
Message-ID: <20160831145441.GA5598@localhost.localdomain>

On Mon, Aug 29, 2016@12:39:13PM -0700, J Freyensee wrote:
> On Mon, 2016-08-29@14:18 -0500, Steve Wise wrote:
> > This patch follows the other existing parameters.??For instance:
> > trsvcid.??It is basically an unstructured string that is passed to
> > the driver and the driver does the enforcement/validation.
> 
> Oh yah, you are right, everything can be a string of variable length
> and gets converted accordingly...more coffee...
> 
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

Thanks, applied.
