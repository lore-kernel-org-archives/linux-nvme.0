From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 16 Aug 2016 09:22:09 -0700
Subject: [PATCH v2 3/5] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <06a25d8a-1215-b117-bfee-aa28c071956d@grimberg.me>
References: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471279659-25951-4-git-send-email-james_p_freyensee@linux.intel.com>
 <06a25d8a-1215-b117-bfee-aa28c071956d@grimberg.me>
Message-ID: <1471364529.21107.7.camel@linux.intel.com>

On Tue, 2016-08-16@11:56 +0300, Sagi Grimberg wrote:
> > 
> > diff --git a/drivers/nvme/target/rdma.c
> > b/drivers/nvme/target/rdma.c
> > index e06d504..68b7b04 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -1004,11 +1004,11 @@ nvmet_rdma_parse_cm_connect_req(struct
> > rdma_conn_param *conn,
> > ?	queue->host_qid = le16_to_cpu(req->qid);
> > 
> > ?	/*
> > -	?* req->hsqsize corresponds to our recv queue size
> > -	?* req->hrqsize corresponds to our send queue size
> > +	?* req->hsqsize corresponds to our recv queue size plus 1
> > +	?* req->hrqsize corresponds to our send queue size plus 1
> > ?	?*/
> > -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> > -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> > +	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
> > +	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 1;
> > 
> > ?	if (!queue->host_qid && queue->recv_queue_size >
> > NVMF_AQ_DEPTH)
> > ?		return NVME_RDMA_CM_INVALID_HSQSIZE;
> > 
> 
> In order to keep bisectability this patch should come first.
> Otherwise
> in prior patches the host sends smaller queue then it actually uses.

Bisectability is a pretty big word for me :-P. ?Joke aside, I
understand, I can make this the first patch.

> 
> So this patch should come first, and only then we make the host
> send sqsize-1.
