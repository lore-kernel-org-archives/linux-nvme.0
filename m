From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 22 Oct 2016 00:51:18 +0300
Subject: [PATCH RFC v2 1/3] rdma_cm: add rdma_reject_msg() helper function
In-Reply-To: <1360f08b7c25f3befcd6836b47af81e2ecb51b75.1477003235.git.swise@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <1360f08b7c25f3befcd6836b47af81e2ecb51b75.1477003235.git.swise@opengridcomputing.com>
Message-ID: <0923e213-cef7-f470-d148-9a513d9c37b2@grimberg.me>


> +static const char * const ib_rej_reason_strs[] = {
> +	[IB_CM_REJ_NO_QP]			= "no qp",
> +	[IB_CM_REJ_NO_EEC]			= "no eec",
> +	[IB_CM_REJ_NO_RESOURCES]		= "no resources",
> +	[IB_CM_REJ_TIMEOUT]			= "timeout",
> +	[IB_CM_REJ_UNSUPPORTED]			= "unsupported",
> +	[IB_CM_REJ_INVALID_COMM_ID]		= "invalid comm id",
> +	[IB_CM_REJ_INVALID_COMM_INSTANCE]	= "invalid comm instance",
> +	[IB_CM_REJ_INVALID_SERVICE_ID]		= "invalid service id",
> +	[IB_CM_REJ_INVALID_TRANSPORT_TYPE]	= "invalid transport type",
> +	[IB_CM_REJ_STALE_CONN]			= "stale conn",
> +	[IB_CM_REJ_RDC_NOT_EXIST]		= "rdc not exist",
> +	[IB_CM_REJ_INVALID_GID]			= "invalid gid",
> +	[IB_CM_REJ_INVALID_LID]			= "invalid lid",
> +	[IB_CM_REJ_INVALID_SL]			= "invalid sl",
> +	[IB_CM_REJ_INVALID_TRAFFIC_CLASS]	= "invalid traffic class",
> +	[IB_CM_REJ_INVALID_HOP_LIMIT]		= "invalid hop limit",
> +	[IB_CM_REJ_INVALID_PACKET_RATE]		= "invalid packet rate",
> +	[IB_CM_REJ_INVALID_ALT_GID]		= "invalid alt gid",
> +	[IB_CM_REJ_INVALID_ALT_LID]		= "invalid alt lid",
> +	[IB_CM_REJ_INVALID_ALT_SL]		= "invalid alt sl",
> +	[IB_CM_REJ_INVALID_ALT_TRAFFIC_CLASS]	= "invalid alt traffic class",
> +	[IB_CM_REJ_INVALID_ALT_HOP_LIMIT]	= "invalid alt hop limit",
> +	[IB_CM_REJ_INVALID_ALT_PACKET_RATE]	= "invalid alt packet rate",
> +	[IB_CM_REJ_PORT_CM_REDIRECT]		= "port cm redirect",
> +	[IB_CM_REJ_PORT_REDIRECT]		= "port redirect",
> +	[IB_CM_REJ_INVALID_MTU]			= "invalid mtu",
> +	[IB_CM_REJ_INSUFFICIENT_RESP_RESOURCES]	= "insufficient resp resources",
> +	[IB_CM_REJ_CONSUMER_DEFINED]		= "consumer defined",
> +	[IB_CM_REJ_INVALID_RNR_RETRY]		= "invalid rnr retry",
> +	[IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID]	= "duplicate local comm id",
> +	[IB_CM_REJ_INVALID_CLASS_VERSION]	= "invalid class version",
> +	[IB_CM_REJ_INVALID_FLOW_LABEL]		= "invalid flow label",
> +	[IB_CM_REJ_INVALID_ALT_FLOW_LABEL]	= "invalid alt flow label",
> +};
> +
> +const char *__attribute_const__ ib_reject_msg(int reason)

Please call it ibcm_reject_msg()


> +const char *__attribute_const__ iw_reject_msg(int reason)

and this iwcm_reject_msg
