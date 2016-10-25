From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 11:04:55 -0500
Subject: [PATCH v3 6/6] rds_rdma: log the connection reject message
In-Reply-To: <928b6e33-992b-8b88-e224-224f19566623@oracle.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <21c48d771ab8a9d37ec19ea5f7a48ed5b84c8984.1477336045.git.swise@opengridcomputing.com>
 <928b6e33-992b-8b88-e224-224f19566623@oracle.com>
Message-ID: <00f201d22ed9$86ebb1a0$94c314e0$@opengridcomputing.com>



> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at oracle.com]
> Sent: Tuesday, October 25, 2016 10:52 AM
> To: Steve Wise; dledford at redhat.com; sean.hefty at intel.com
> Cc: linux-rdma at vger.kernel.org; bart.vanassche at sandisk.com; linux-
> nvme at lists.infradead.org; sagi at grimberg.me; hch at lst.de; axboe at fb.com
> Subject: Re: [PATCH v3 6/6] rds_rdma: log the connection reject message
> 
> On 10/24/2016 12:07 PM, Steve Wise wrote:
> > Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> > ---
> >  net/rds/rdma_transport.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
> > index 345f090..6bd2814 100644
> > --- a/net/rds/rdma_transport.c
> > +++ b/net/rds/rdma_transport.c
> > @@ -100,11 +100,14 @@ int rds_rdma_cm_event_handler(struct rdma_cm_id
> *cm_id,
> >  		trans->cm_connect_complete(conn, event);
> >  		break;
> >
> > +	case RDMA_CM_EVENT_REJECTED:
> > +		rdsdebug("Connection rejected: %s\n",
> > +			 rdma_reject_msg(cm_id, event->status));
> For current code above is fine but I will need the other helper
> while adding few connection cases where ARI field carries information
> for the reason for the reject.
> 
> I assume, rdma_consumer_reject_data() is meant to be used for that ?

Yep.  You can see the nvme_rdma patch in this series for an example.

> 
> The patch looks fine to me.
> FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar at oracle.com>
