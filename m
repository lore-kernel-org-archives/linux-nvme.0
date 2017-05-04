From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 May 2017 13:21:22 +0200
Subject: [PATCH 10/11] nvme: queue ns scanning and async request from
 nvme_wq
In-Reply-To: <1493893995-27063-11-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-11-git-send-email-sagi@grimberg.me>
Message-ID: <20170504112122.GF9686@lst.de>

On Thu, May 04, 2017@01:33:14PM +0300, Sagi Grimberg wrote:
> To suppress the warning triggered by nvme_uninit_ctrl:
> kernel: [   50.350439] nvme nvme0: rescanning
> kernel: [   50.363351] ------------[ cut here]------------
> kernel: [   50.363396] WARNING: CPU: 1 PID: 37 at kernel/workqueue.c:2423 check_flush_dependency+0x11f/0x130
> kernel: [   50.363409] workqueue: WQ_MEM_RECLAIM
> nvme-wq:nvme_del_ctrl_work [nvme_core] is flushing !WQ_MEM_RECLAIM events:nvme_scan_work [nvme_core]
> 
> This was triggered with nvme-loop, but can happen with rdma/pci as well afaict.

Did you check that this won't create conflicts with other nvme
actions (e.g. reset)?  I remember some issues in the past, but I'd
have to look up the details.
