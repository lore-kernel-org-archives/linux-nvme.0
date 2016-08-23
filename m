From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 23 Aug 2016 11:58:56 -0500
Subject: nvme_rdma - leaves provider resources allocated
Message-ID: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>

Assume an nvme_rdma host has one attached controller in RECONNECTING state, and
that controller has failed to reconnect at least once and thus is in the
delay_schedule time before retrying the connection.  At that moment, there are
no cm_ids allocated for that controller because the admin queue and the io
queues have been freed.  So nvme_rdma cannot get a DEVICE_REMOVAL from the
rdma_cm.  This means if the underlying provider module is removed, it will be
removed with resources still allocated by nvme_rdma.  For iw_cxgb4, this causes
a BUG_ON() in gen_pool_destroy() because MRs are still allocated for the
controller.

Thoughts on how to fix this?

Thanks,

Steve.
