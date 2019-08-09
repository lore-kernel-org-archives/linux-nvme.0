From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  9 Aug 2019 15:12:05 -0700
Subject: [PATCH v5 1/7] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
In-Reply-To: <20190809221211.21157-1-sagi@grimberg.me>
References: <20190809221211.21157-1-sagi@grimberg.me>
Message-ID: <20190809221211.21157-2-sagi@grimberg.me>

NVME_SC_ABORT_REQ means that the request was aborted due to
an abort command received. In our case, this is a transport
cancellation, so host pathing error is much more appropriate.

Also, convert NVME_SC_HOST_PATH_ERROR to BLK_STS_TRANSPORT for
such that callers can understand that the status is a transport
related error. This will be used by the ns scanning code to
understand if it got an error from the controller or that the
controller happens to be unreachable by the transport.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6956041224ec..867c8977eb3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -228,6 +228,8 @@ static blk_status_t nvme_error_status(struct request *req)
 		return BLK_STS_PROTECTION;
 	case NVME_SC_RESERVATION_CONFLICT:
 		return BLK_STS_NEXUS;
+	case NVME_SC_HOST_PATH_ERROR:
+		return BLK_STS_TRANSPORT;
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -294,7 +296,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
-	nvme_req(req)->status = NVME_SC_ABORT_REQ;
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 	blk_mq_complete_request_sync(req);
 	return true;
 }
-- 
2.17.1
