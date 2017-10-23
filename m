From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 23 Oct 2017 14:05:08 +0300
Subject: [PATCH v2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20171023082805.GA25383@infradead.org>
References: <20171020161253.29296-1-jsmart2021@gmail.com>
 <20171023082805.GA25383@infradead.org>
Message-ID: <a1123d71-51f8-1d72-3e5d-67f23634543a@grimberg.me>


> The whole point of the flush_work suggestion was that we should not
> require offloading the deleting to another workqueue for it.

Regardless of flush_work or cancel_work_sync, its a deadlock
in fc.

in rdma/loop we always call ->free_ctrl from a different context.

In rdma we do that from the rdma_cm context, in loop we schedule
host side delete on nvme_wq, in fc apparently we can get to
free_ctrl directly from that context.

If fatal_err_work calls ->delete_ctrl() and that in turn gets to put the
last reference on the ctrl it will end up in ->free_ctrl() under
fatal_err_work context which will then try to flush fatal_err_work.
