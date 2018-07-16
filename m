From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 13:53:43 +0300
Subject: [PATCH rfc 2/2] nvmet: add nvmet ctrl logging helpers
In-Reply-To: <20180716105343.29699-1-sagi@grimberg.me>
References: <20180716105343.29699-1-sagi@grimberg.me>
Message-ID: <20180716105343.29699-3-sagi@grimberg.me>

prettify ctrl related logging when we have multiple ports in
the system. Now ctrl logging helpers will use the format
"nvmet ctrlX: ...".

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c   | 11 +++++------
 drivers/nvme/target/core.c        | 20 ++++++++++----------
 drivers/nvme/target/discovery.c   | 13 +++++++------
 drivers/nvme/target/fabrics-cmd.c | 15 ++++++++-------
 drivers/nvme/target/io-cmd-bdev.c |  5 +++--
 drivers/nvme/target/nvmet.h       | 17 +++++++++++++++++
 drivers/nvme/target/rdma.c        | 26 ++++++++++++++++----------
 7 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 837bbdbfaa4b..46e2fb9c8bc7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,8 +45,8 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
 	if (!ns) {
-		pr_err("nvmet : Could not find namespace id : %d\n",
-				le32_to_cpu(req->cmd->get_log_page.nsid));
+		ctrl_err(req->sq->ctrl, "Could not find namespace id : %d\n",
+			le32_to_cpu(req->cmd->get_log_page.nsid));
 		return NVME_SC_INVALID_NS;
 	}
 
@@ -571,8 +571,7 @@ static void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
-		ctrl->cntlid, ctrl->kato);
+	ctrl_dbg(ctrl, "update keep-alive timer for %d secs\n", ctrl->kato);
 
 	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 	nvmet_req_complete(req, 0);
@@ -660,7 +659,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	}
 
-	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-	       req->sq->qid);
+	ctrl_err(req->sq->ctrl, "unhandled cmd %d on qid %d\n",
+		cmd->common.opcode, req->sq->qid);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..fbb71d005ea1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -268,16 +268,14 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvmet_ctrl, ka_work);
 
-	pr_err("ctrl %d keep-alive timer (%d seconds) expired!\n",
-		ctrl->cntlid, ctrl->kato);
+	ctrl_err(ctrl, "keep-alive timer (%d seconds) expired!\n", ctrl->kato);
 
 	nvmet_ctrl_fatal_error(ctrl);
 }
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
-	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
-		ctrl->cntlid, ctrl->kato);
+	ctrl_dbg(ctrl, "start keep-alive timer for %d secs\n", ctrl->kato);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
@@ -285,7 +283,7 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
-	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
+	ctrl_dbg(ctrl, "stop keep-alive\n");
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
@@ -786,14 +784,16 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		ctrl_err(req->sq->ctrl,
+			"got cmd %d while CC.EN == 0 on qid = %d\n",
+			cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		ctrl_err(req->sq->ctrl,
+			"got cmd %d while CSTS.RDY == 0 on qid = %d\n",
+			cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 	return 0;
@@ -997,7 +997,7 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	struct nvmet_ctrl *ctrl =
 			container_of(work, struct nvmet_ctrl, fatal_err_work);
 
-	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
+	ctrl_err(ctrl, "fatal error occurred!\n");
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eae29f493a07..960031608f93 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -186,9 +186,10 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("got cmd %d while not ready\n",
+	if (unlikely(!(ctrl->csts & NVME_CSTS_RDY))) {
+		ctrl_err(ctrl, "got cmd %d while not ready\n",
 		       cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
@@ -202,7 +203,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			req->execute = nvmet_execute_get_disc_log_page;
 			return 0;
 		default:
-			pr_err("unsupported get_log_page lid %d\n",
+			ctrl_err(ctrl, "unsupported get_log_page lid %d\n",
 			       cmd->get_log_page.lid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
@@ -214,16 +215,16 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 				nvmet_execute_identify_disc_ctrl;
 			return 0;
 		default:
-			pr_err("unsupported identify cns %d\n",
+			ctrl_err(ctrl, "unsupported identify cns %d\n",
 			       cmd->identify.cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	default:
-		pr_err("unsupported cmd %d\n", cmd->common.opcode);
+		ctrl_err(ctrl, "unsupported cmd %d\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-	pr_err("unhandled cmd %d\n", cmd->common.opcode);
+	ctrl_err(ctrl, "unhandled cmd %d\n", cmd->common.opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d84ae004cb85..3a2722d483d7 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -87,7 +87,8 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_prop_get;
 		break;
 	default:
-		pr_err("received unknown capsule type 0x%x\n",
+		ctrl_err(req->sq->ctrl,
+			"received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
@@ -104,11 +105,11 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
 	if (old) {
-		pr_warn("queue already connected!\n");
+		ctrl_warn(ctrl, "queue already connected!\n");
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
 	}
 	if (!sqsize) {
-		pr_warn("queue size zero!\n");
+		ctrl_warn(ctrl, "queue size zero!\n");
 		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
 
@@ -165,8 +166,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
-		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
+	ctrl_info(ctrl, "subsystem %s to host %s.\n",
+		ctrl->subsys->subsysnqn, ctrl->hostnqn);
 	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
@@ -210,7 +211,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
-		pr_warn("invalid queue id (%d)\n", qid);
+		ctrl_warn(ctrl, "invalid queue id (%d)\n", qid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		req->rsp->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
 		goto out_ctrl_put;
@@ -223,7 +224,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 	}
 
-	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
+	ctrl_dbg(ctrl, "adding queue %d.\n", qid);
 
 out:
 	kfree(d);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e0b0f7df70c2..d4e7b071dce4 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -234,8 +234,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-		       req->sq->qid);
+		ctrl_err(req->sq->ctrl,
+			"unhandled cmd %d on qid %d\n", cmd->common.opcode,
+			req->sq->qid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6811258ab8ff..73751ded2174 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -280,6 +280,13 @@ struct nvmet_req {
 	printk(KERN_WARNING "nvmet port%d: " fmt, \
 		le32_to_cpu((port)->disc_addr.portid), ##a)
 
+#define ctrl_err(ctrl, fmt, a...)		\
+	printk(KERN_ERR "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
+#define ctrl_info(ctrl, fmt, a...)		\
+	printk(KERN_INFO "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
+#define ctrl_warn(ctrl, fmt, a...)		\
+	printk(KERN_WARNING "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
+
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #include <linux/dynamic_debug.h>
 #define port_dbg(port, fmt, a...)				\
@@ -289,12 +296,22 @@ do {								\
 		printk(KERN_DEBUG "nvmet port%d: " fmt, 	\
 			le32_to_cpu((port)->disc_addr.portid), ##a);\
 } while (0)
+#define ctrl_dbg(ctrl, fmt, a...)				\
+do {								\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
+		printk(KERN_DEBUG "nvmet ctrl%d: " fmt, 	\
+			(ctrl)->cntlid, ##a);			\
+} while (0)
 #elif defined(DEBUG)
 #define port_dbg(port, fmt, a...)				\
 	printk(KERN_DEBUG "nvmet port%d: " fmt, 	\
 		le32_to_cpu((port)->disc_addr.portid)
+#define ctrl_dbg(ctrl, fmt, a...)				\
+	printk(KERN_DEBUG "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
 #else
 #define port_dbg(port, fmt, a...) {}
+#define ctrl_dbg(ctrl, fmt, a...) {}
 #endif
 
 extern struct workqueue_struct *buffered_io_wq;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 71bf6bf57be9..b14227e6e11f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -554,7 +554,8 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 		DMA_TO_DEVICE);
 
 	if (unlikely(ib_post_send(cm_id->qp, first_wr, &bad_wr))) {
-		pr_err("sending cmd response failed\n");
+		ctrl_err(req->sq->ctrl,
+			"sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
 	}
 }
@@ -576,7 +577,8 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvmet_req_uninit(&rsp->req);
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
-			pr_info("RDMA READ for CQE 0x%p failed with status %s (%d).\n",
+			ctrl_err(queue->nvme_sq.ctrl,
+				"RDMA READ for CQE 0x%p failed with status %s (%d).\n",
 				wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
 			nvmet_rdma_error_comp(queue);
 		}
@@ -620,7 +622,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
 	if (off + len > rsp->queue->dev->inline_data_size) {
-		pr_err("invalid inline data offset!\n");
+		ctrl_err(rsp->cmd->queue->nvme_sq.ctrl,
+			"invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 	}
 
@@ -677,7 +680,8 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 		case NVME_SGL_FMT_OFFSET:
 			return nvmet_rdma_map_sgl_inline(rsp);
 		default:
-			pr_err("invalid SGL subtype: %#x\n", sgl->type);
+			ctrl_err(rsp->cmd->queue->nvme_sq.ctrl,
+				"invalid SGL subtype: %#x\n", sgl->type);
 			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		}
 	case NVME_KEY_SGL_FMT_DATA_DESC:
@@ -687,11 +691,13 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 		case NVME_SGL_FMT_ADDRESS:
 			return nvmet_rdma_map_sgl_keyed(rsp, sgl, false);
 		default:
-			pr_err("invalid SGL subtype: %#x\n", sgl->type);
+			ctrl_err(rsp->cmd->queue->nvme_sq.ctrl,
+				"invalid SGL subtype: %#x\n", sgl->type);
 			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		}
 	default:
-		pr_err("invalid SGL type: %#x\n", sgl->type);
+		ctrl_err(rsp->cmd->queue->nvme_sq.ctrl,
+			"invalid SGL type: %#x\n", sgl->type);
 		return NVME_SC_SGL_INVALID_TYPE | NVME_SC_DNR;
 	}
 }
@@ -702,9 +708,9 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 
 	if (unlikely(atomic_sub_return(1 + rsp->n_rdma,
 			&queue->sq_wr_avail) < 0)) {
-		pr_debug("IB send queue full (needed %d): queue %u cntlid %u\n",
-				1 + rsp->n_rdma, queue->idx,
-				queue->nvme_sq.ctrl->cntlid);
+		ctrl_dbg(queue->nvme_sq.ctrl,
+			"IB send queue full (needed %d): queue %u\n",
+			1 + rsp->n_rdma, queue->idx);
 		atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
 		return false;
 	}
@@ -1022,7 +1028,7 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
-	pr_debug("freeing queue %d\n", queue->idx);
+	ctrl_dbg(queue->nvme_sq.ctrl, "freeing queue %d\n", queue->idx);
 
 	nvmet_sq_destroy(&queue->nvme_sq);
 
-- 
2.14.1
