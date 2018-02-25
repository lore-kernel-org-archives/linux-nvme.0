From: alon@vastdata.com (Alon Horev)
Date: Sun, 25 Feb 2018 17:10:07 +0200
Subject: nvme-rdma corrupts memory upon timeout
Message-ID: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>

Hey,

We're running nvmf over a large cluster using RDMA. Sometimes, there's
some congestion that causes the nvme host driver to time out (we use a
4 second timeout).
Even though the host (initiator) times out and returns with an error
to userspace, we can see the buffer being written after the io
returned. This can obviously cause serious crashes and corruptions.
We suspect the same happens with writes but have yet to prove it.

We think we can spot the root cause: 'nvme_rdma_error_recovery'
handles the timeout in an asynchronous manner. It queues a task for
reconnecting the nvme device. Until that task is executed by the
worker thread the qp is open and a rdma write can get through. Does
this make sense?

Some additional information: we use a keepalive and reconnect timeout
of 1 second. ConnectX4 with OFED 4.1. I validated the code hasn't
changed in latest linux sources.

Thanks, Alon Horev
VastData
