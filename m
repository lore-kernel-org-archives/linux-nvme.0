From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Oct 2016 10:57:17 +0300
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
Message-ID: <cf452494-f485-56fd-6ca9-0b84627ab5da@grimberg.me>


> +	switch (ev->status) {
> +	case IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID:
> +		strlcpy(reason, "duplicate local comm id", sizeof(reason));
> +		break;
> +	case IB_CM_REJ_CONSUMER_DEFINED:
> +		if (ev->param.conn.private_data_len) {
> +			const struct nvme_rdma_cm_rej *rej =
> +				(const void *)ev->param.conn.private_data;
> +
> +			snprintf(reason, sizeof(reason), "status %d",
> +				 le16_to_cpu(rej->sts));
> +			/* XXX: Think of something clever to do here... */
> +		} else {
> +			strlcpy(reason, "no private data", sizeof(reason));
> +		}

Can you add "consumer defined" to the string so we know its an
application error reason?


Otherwise looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
