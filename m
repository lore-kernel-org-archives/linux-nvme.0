From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 18 Jan 2018 18:04:25 +0000
Subject: [PATCH 2/4] nvmet-rdma: notify QP on Last WQE Reached event
 arrival
In-Reply-To: <02bf01d38fa9$05254550$0f6fcff0$@opengridcomputing.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-3-git-send-email-maxg@mellanox.com>
 <02bf01d38fa9$05254550$0f6fcff0$@opengridcomputing.com>
Message-ID: <1516298665.2676.27.camel@wdc.com>

On Wed, 2018-01-17@09:37 -0600, Steve Wise wrote:
> > 
> > In order to avoid resource leakage for QP associated with
> > a Shared Receive Queue (SRQ), notify it on Last WQE Reached
> > event arrival.
> > 
> > Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> > ---
> >  drivers/nvme/target/rdma.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 4991290..99a14a7 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -1151,6 +1151,9 @@ static void nvmet_rdma_qp_event(struct ib_event
> > *event, void *priv)
> >  	case IB_EVENT_COMM_EST:
> >  		rdma_notify(queue->cm_id, event->event);
> >  		break;
> > +	case IB_EVENT_QP_LAST_WQE_REACHED:
> > +		ib_notify_qp(queue->cm_id->qp, event->event);
> > +		break;
> >  	default:
> >  		pr_err("received IB QP event: %s (%d)\n",
> >  		       ib_event_msg(event->event), event->event);
> 
> I wonder if this could be handled in ib_dispatch_event() for all ULPS?

As far as I can see all ib_dispatch_event() calls for IB_EVENT_QP_LAST_WQE_REACHED
set element.qp in struct ib_event. So I'd also like to see this proposal to be 
explored further.

Thanks,

Bart.
