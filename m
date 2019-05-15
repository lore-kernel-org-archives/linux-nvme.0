From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 May 2019 10:36:21 -0600
Subject: [PATCH 2/6] nvme-pci: Don't disable on timeout in reset state
In-Reply-To: <20190515163625.21776-1-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
Message-ID: <20190515163625.21776-2-keith.busch@intel.com>

The driver doesn't dispatch commands that it needs to wait for in the reset
state anymore. If a timeout occurs in this state, the reset work is
already disabling the controller, so just reset the request's timer.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d4e442160048..c72755311ffa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1298,13 +1298,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		shutdown = true;
 		/* fall through */
 	case NVME_CTRL_CONNECTING:
-	case NVME_CTRL_RESETTING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, shutdown);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
+	case NVME_CTRL_RESETTING:
+		return BLK_EH_RESET_TIMER;
 	default:
 		break;
 	}
-- 
2.14.4
