From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 14:51:12 -0500
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <012601d22afd$5a310460$0e930d20$@opengridcomputing.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
 <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
 <31822981-0032-98aa-6570-450351020463@sandisk.com>
 <012601d22afd$5a310460$0e930d20$@opengridcomputing.com>
Message-ID: <015101d22b0b$4f493c80$eddbb580$@opengridcomputing.com>

> 
> > On 10/20/2016 10:45 AM, Steve Wise wrote:
> > > I agree.  What if we add a helper function in the core to map the
> >  > event->status value to something human readable?  That would at
> >  > least push this into the core.   The nvme host really doesn't do
> >  > anything other than display a different message...
> > >
> > > Something like rdma_event_msg(), but using event->status.
> >
> > Hello Steve,
> >
> > It won't be possible to let rdma_event_msg() decode the NVME_RDMA_CM_*
> > status unless a callback function that performs such decoding is passed
> > to rdma_event_msg(). Since such an approach would work for translating a
> > status into a message but not for any more advanced CM status handling
> > my preference is to unify the calling conventions for IB/RoCE and iWARP
> > CM reject callbacks.
> 
> I think for this particular case, mapping event->status to a string is all
> that nvme needs.  And having a status to string mapping would be easy to do
> in the core.  I agree though, that unifying the status codes is a "good
> thing".

What about something along these lines? (untested and mangled by my emailer, but you get the point)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5f65a78..40a2a6f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -101,6 +101,67 @@ const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 }
 EXPORT_SYMBOL(rdma_event_msg);

+static const char * const ib_rej_reason_strs[] = {
+       [IB_CM_REJ_NO_QP]                       = "no qp",
+       [IB_CM_REJ_NO_EEC]                      = "no eec",
+       [IB_CM_REJ_NO_RESOURCES]                = "no resources",
+       [IB_CM_REJ_TIMEOUT]                     = "timeout",
+       [IB_CM_REJ_UNSUPPORTED]                 = "unsupported",
+       [IB_CM_REJ_INVALID_COMM_ID]             = "invalid comm id",
+       [IB_CM_REJ_INVALID_COMM_INSTANCE]       = "invalid comm instance",
+       [IB_CM_REJ_INVALID_SERVICE_ID]          = "invalid service id",
+       [IB_CM_REJ_INVALID_TRANSPORT_TYPE]      = "invalid transport type",
+       [IB_CM_REJ_STALE_CONN]                  = "stale conn",
+       [IB_CM_REJ_RDC_NOT_EXIST]               = "rdc not exist",
+       [IB_CM_REJ_INVALID_GID]                 = "invalid gid",
+       [IB_CM_REJ_INVALID_LID]                 = "invalid lid",
+       [IB_CM_REJ_INVALID_SL]                  = "invalid sl",
+       [IB_CM_REJ_INVALID_TRAFFIC_CLASS]       = "invalid traffic class",
+       [IB_CM_REJ_INVALID_HOP_LIMIT]           = "invalid hop limit",
+       [IB_CM_REJ_INVALID_PACKET_RATE]         = "invalid packet rate",
+       [IB_CM_REJ_INVALID_ALT_GID]             = "invalid alt gid",
+       [IB_CM_REJ_INVALID_ALT_LID]             = "invalid alt lid",
+       [IB_CM_REJ_INVALID_ALT_SL]              = "invalid alt sl",
+       [IB_CM_REJ_INVALID_ALT_TRAFFIC_CLASS]   = "invalid alt traffic class",
+       [IB_CM_REJ_INVALID_ALT_HOP_LIMIT]       = "invalid alt hop limit",
+       [IB_CM_REJ_INVALID_ALT_PACKET_RATE]     = "invalid alt packet rate",
+       [IB_CM_REJ_PORT_CM_REDIRECT]            = "port cm redirect",
+       [IB_CM_REJ_PORT_REDIRECT]               = "port redirect",
+       [IB_CM_REJ_INVALID_MTU]                 = "invalid mtu",
+       [IB_CM_REJ_INSUFFICIENT_RESP_RESOURCES] = "insufficient resp resources",
+       [IB_CM_REJ_CONSUMER_DEFINED]            = "consumer defined",
+       [IB_CM_REJ_INVALID_RNR_RETRY]           = "invalid rnr retry",
+       [IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID]     = "duplicate local comm id",
+       [IB_CM_REJ_INVALID_CLASS_VERSION]       = "invalid class version",
+       [IB_CM_REJ_INVALID_FLOW_LABEL]          = "invalid flow label",
+       [IB_CM_REJ_INVALID_ALT_FLOW_LABEL]      = "invalid alt flow label",
+};
+
+static const char * const iw_rej_reason_strs[] = {
+       [ECONNRESET]                            = "reset by remote host",
+       [ECONNREFUSED]                          = "refused by remote application",
+       [ETIMEDOUT]                             = "setup timeout",
+};
+
+const char *__attribute_const__ rdma_reject_status_msg(struct rdma_cm_id *cm_id, int reason)
+{
+       size_t index = reason;
+
+       if (rdma_protocol_ib(cm_id->device, cm_id->port_num))
+               return (index < ARRAY_SIZE(ib_rej_reason_strs) && ib_rej_reason_strs[index]) ?
+                       ib_rej_reason_strs[index] : "unrecognized reason";
+
+       if (rdma_protocol_iwarp(cm_id->device, cm_id->port_num)) {
+
+               /* iWARP uses negative errnos */
+               index = -index;
+               return (index < ARRAY_SIZE(iw_rej_reason_strs) && iw_rej_reason_strs[index]) ?
+                       iw_rej_reason_strs[index] : "unrecognized reason";
+       }
+       return "unrecognized reason";
+}
+EXPORT_SYMBOL(rdma_reject_status_msg);
+
 static void cma_add_one(struct ib_device *device);
 static void cma_remove_one(struct ib_device *device, void *client_data);
