From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 25 Oct 2016 19:34:56 +0300
Subject: [PATCH v3 5/6] ib_iser: log the connection reject message
In-Reply-To: <11419a4af998b6d28df0040efbbf149e44cf1fe5.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <11419a4af998b6d28df0040efbbf149e44cf1fe5.1477336045.git.swise@opengridcomputing.com>
Message-ID: <cdc591a8-457c-a051-1bc7-00e13b28f7f7@grimberg.me>

> +	case RDMA_CM_EVENT_REJECTED:
> +		iser_info("Connection rejected: %s\n",
> +			 rdma_reject_msg(cma_id, event->status));
> +		/*FALLTHROUGH*/

NIT: /* FALLTHROUGH */

Otherwise:

Acked-by: Sagi Grimberg <sagi at grimberg.me>
