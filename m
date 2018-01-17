From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 17 Jan 2018 16:11:15 +0000
Subject: [PATCH 1/4] IB/core: add support for draining Shared receive
 queues
In-Reply-To: <1516197178-26493-2-git-send-email-maxg@mellanox.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-2-git-send-email-maxg@mellanox.com>
Message-ID: <1516205474.2820.5.camel@wdc.com>

On Wed, 2018-01-17@15:52 +0200, Max Gurtovoy wrote:
> +/*
> + * __ib_drain_srq() - Block until all Last WQE Reached event arrives, or
> + *                    timeout expires (best effort).
> + * @qp:               queue pair associated with SRQ to drain
> + *
> + * In order to avoid WQE and data segment leakage, one should destroy
> + * QP associated after performing the following:
> + *  - moving QP to err state
> + *  - wait for the Affiliated Asynchronous Last WQE Reached Event
> + *  - drain the CQ
> + */
> +static void __ib_drain_srq(struct ib_qp *qp)
> +{
> +	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
> +	struct ib_cq *cq;
> +	int ret;
> +
> +	if (!qp->srq) {
> +		WARN_ONCE(1, "QP 0x%p is not associated with SRQ\n", qp);
> +		return;
> +	}
> +
> +	ret = ib_modify_qp(qp, &attr, IB_QP_STATE);
> +	if (ret) {
> +		WARN_ONCE(ret, "failed to drain shared recv queue: %d\n", ret);
> +		return;
> +	}
> +
> +	if (ib_srq_has_cq(qp->srq->srq_type)) {
> +		cq = qp->srq->ext.cq;
> +	} else if (qp->recv_cq) {
> +		cq = qp->recv_cq;
> +	} else {
> +		WARN_ONCE(1, "QP 0x%p has no CQ associated with SRQ\n", qp);
> +		return;
> +	}
> +
> +	/*
> +         * ULP should invoke ib_notify_qp on IB_EVENT_QP_LAST_WQE_REACHED
> +         * arrival, otherwise timeout will expire and leakage may occur.
> +         * Use long timeout, for the buggy ULPs/HCAs that don't notify the
> +         * QP nor raising IB_EVENT_QP_LAST_WQE_REACHED event.
> +         */
> +	if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 0)
> +		ib_process_cq_direct(cq, -1);
> +}

Hello Max,

It seems weird to me that __ib_drain_srq() does not follow the same approach as
__ib_drain_rq(). Have you considered to post an additional receive work entry
on the SRQ and to wait until the completion for that work entry is signaled?
That would avoid that a completion has to be added in the ib_qp data structure
and would also avoid that all ULPs that use SRQs have to be modified.

Thanks,

Bart.
