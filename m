From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 17:47:01 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <1552924164.152266.21.camel@acm.org>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
Message-ID: <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>


> Hi Ming,
> 
> Just like the NVMeOF initiator driver, the SRP initiator driver uses an
> RDMA RC connection for all of its communication over the network. If
> communication between initiator and target fails the target driver will
> close the connection or one of the work requests that was posted by the
> initiator driver will complete with an error status (wc->status !=
> IB_WC_SUCCESS). In the latter case the function srp_handle_qp_err() will
> try to reestablish the connection between initiator and target after a
> certain delay:
> 
> 	if (delay > 0)
> 		queue_delayed_work(system_long_wq, &rport->reconnect_work,
> 				   1UL * delay * HZ);
> 
> SCSI timeouts may kick the SCSI error handler. That results in calls of
> the srp_reset_device() and/or srp_reset_host() functions. srp_reset_host()
> terminates all outstanding requests after having disconnected the RDMA RC
> connection. Disconnecting the RC connection first guarantees that there
> are no concurrent request completion calls from the regular completion
> path and from the error handler.

Hi Bart,

If I understand the race correctly, its not between the requests
completion and the queue pairs removal nor the timeout handler
necessarily, but rather it is between the async requests completion and
the tagset deallocation.

Think of surprise removal (or disconnect) during I/O, drivers
usually stop/quiesce/freeze the queues, terminate/abort inflight
I/Os and then teardown the hw queues and the tagset.

IIRC, the same race holds for srp if this happens during I/O:
1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() 
-> __rport_fail_io_fast()

2. complete all I/Os (async remotely via smp)

Then continue..

3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()

What is preventing (3) from happening before (2) if its async? I would
think that scsi drivers need the exact same thing...
