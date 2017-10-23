From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Oct 2017 07:50:13 -0700
Subject: [PATCH v2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <a1123d71-51f8-1d72-3e5d-67f23634543a@grimberg.me>
References: <20171020161253.29296-1-jsmart2021@gmail.com>
 <20171023082805.GA25383@infradead.org>
 <a1123d71-51f8-1d72-3e5d-67f23634543a@grimberg.me>
Message-ID: <20171023145013.GA3017@infradead.org>

On Mon, Oct 23, 2017@02:05:08PM +0300, Sagi Grimberg wrote:
> Regardless of flush_work or cancel_work_sync, its a deadlock
> in fc.
> 
> in rdma/loop we always call ->free_ctrl from a different context.
> 
> In rdma we do that from the rdma_cm context, in loop we schedule
> host side delete on nvme_wq, in fc apparently we can get to
> free_ctrl directly from that context.

Yes, nvmet_fc_delete_ctrl -> nvmet_fc_delete_target_assoc ->
nvmet_fc_delete_target_queue.

> If fatal_err_work calls ->delete_ctrl() and that in turn gets to put the
> last reference on the ctrl it will end up in ->free_ctrl() under
> fatal_err_work context which will then try to flush fatal_err_work.

Yes, and the way I understand flush_work that is perfectly fine for
flush_work, just not for cancel_work_sync.
