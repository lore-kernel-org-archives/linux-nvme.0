From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 10:38:45 +0200
Subject: [PATCH 1/3] nvme: also check for RESETTING state in
 nvmf_check_if_ready()
In-Reply-To: <20180607083847.51019-1-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
Message-ID: <20180607083847.51019-2-hare@suse.de>

When resetting the controller some transports go into 'RESETTING' state
before issuing the actual 'reset' command. So add the 'RESETTING' state
to nvmf_check_if_ready() to give them a chance to submit it.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index fa32c1216409..909dd337221a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 	case NVME_CTRL_DELETING:
+	case NVME_CTRL_RESETTING:
 		/*
 		 * This is the case of starting a new or deleting an association
 		 * but connectivity was lost before it was fully created or torn
-- 
2.12.3
