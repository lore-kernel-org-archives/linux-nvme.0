From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 18 Mar 2019 08:49:24 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190318151618.GA20371@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p>
Message-ID: <1552924164.152266.21.camel@acm.org>

On Mon, 2019-03-18@23:16 +0800, Ming Lei wrote:
> I am not familiar with SRP, could you explain what SRP initiator driver
> will do when the controller is in bad state? Especially about dealing with
> in-flight IO requests under this situation.

Hi Ming,

Just like the NVMeOF initiator driver, the SRP initiator driver uses an
RDMA RC connection for all of its communication over the network. If
communication between initiator and target fails the target driver will
close the connection or one of the work requests that was posted by the
initiator driver will complete with an error status (wc->status !=
IB_WC_SUCCESS). In the latter case the function srp_handle_qp_err() will
try to reestablish the connection between initiator and target after a
certain delay:

	if (delay > 0)
		queue_delayed_work(system_long_wq, &rport->reconnect_work,
				   1UL * delay * HZ);

SCSI timeouts may kick the SCSI error handler. That results in calls of
the srp_reset_device() and/or srp_reset_host() functions. srp_reset_host()
terminates all outstanding requests after having disconnected the RDMA RC
connection. Disconnecting the RC connection first guarantees that there
are no concurrent request completion calls from the regular completion
path and from the error handler.

Bart.
