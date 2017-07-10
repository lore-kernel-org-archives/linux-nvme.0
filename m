From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 08:59:02 +0300
Subject: [PATCH 2/7] nvme/fc: Fix admin queue depth setup
In-Reply-To: <1499444581-28268-3-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-3-git-send-email-keith.busch@intel.com>
Message-ID: <aef1f200-336f-fdf4-36bc-fe13bfd67474@grimberg.me>

> The NVME_FC_AQ_BLKMQ_DEPTH is one less than what we actually want the
> admin queue's depth to be since it subtracts the AEN entry.
> 
> We also need to subtract 1 from the blk-mq depth to always leave an
> empty queue entry, and to not collide command id with the AEN request.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

nvme-loop needs the same patch.
