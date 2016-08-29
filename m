From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 29 Aug 2016 12:39:13 -0700
Subject: [PATCH v2] nvme-cli/fabrics: Add nr_io_queues parameter to
 connect command
In-Reply-To: <019601d2022a$2017d340$604779c0$@opengridcomputing.com>
References: <20160829155725.A031AE08C5@smtp.ogc.us>
 <1472496727.2816.27.camel@linux.intel.com>
 <019601d2022a$2017d340$604779c0$@opengridcomputing.com>
Message-ID: <1472499553.2816.31.camel@linux.intel.com>

On Mon, 2016-08-29@14:18 -0500, Steve Wise wrote:
> > 
> > On Mon, 2016-08-29@08:53 -0700, Steve Wise wrote:
> > > 
> > > Added 'nr-io-queues' to 'connect' command so users can specify
> > > the
> > > number
> > > of io queues to allocate.
> > > 
> > > usage examples:
> > > 
> > > nvme connect --transport=rdma --nr-io-queues=8 --trsvcid=4420 --
> > > traddr=10.0.1.14 --nqn=test-nvme
> > > nvme connect -t rdma -i 8 -s 4420 -a 10.0.1.14 -n test-nvme
> > > 
> > > Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> > > ---
> > > 
> > > Changes since v1:
> > > 
> > > -Q -> -i
> > > nr_io_queues -> nr-io-queues
> > > 
> > > ---
> > > ?fabrics.c | 11 +++++++++++
> > > ?1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/fabrics.c b/fabrics.c
> > > index 942e987..18e961c 100644
> > > --- a/fabrics.c
> > > +++ b/fabrics.c
> > > @@ -50,6 +50,7 @@ struct config {
> > > ?	char *traddr;
> > > ?	char *trsvcid;
> > > ?	char *hostnqn;
> > > +	char *nr_io_queues;
> > 
> > I just noticed that the 'nr_io_queues' parameter type used in the
> > host
> > driver code fabrics.c is unsigned int.??Would there be a truncation
> > problem here, like say someone wants to do:
> > 
> > nvme connect --nr-io-queues=256
> > 
> > ??
> > 
> 
> Truncation problem???How so???
> 
> This patch follows the other existing parameters.??For instance:
> trsvcid.??It is basically an unstructured string that is passed to
> the driver and the driver does the enforcement/validation.

Oh yah, you are right, everything can be a string of variable length
and gets converted accordingly...more coffee...

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> ?
> Steve.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
