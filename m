From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Oct 2015 14:44:02 +0000 (UTC)
Subject: [PATCH 2/8] nvme: use the block layer for userspace	passthrough
 metadata
In-Reply-To: <20151015052732.GA21725@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>
 <20151015052732.GA21725@lst.de>
Message-ID: <alpine.LNX.2.00.1510151442300.27742@localhost.lm.intel.com>

There's not much, so here's all the fixes for the whole series in
one diff:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f056513..eb9e25a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -139,6 +139,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
  {
  	bool write = cmd->common.opcode & 1;
  	struct request *req;
+	struct nvme_ns *ns = q->queuedata;
  	struct bio *bio = NULL;
  	void *meta = NULL;
  	int ret;
@@ -156,6 +157,11 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
  			goto out;
  		bio = req->bio;

+		bio->bi_bdev = bdget_disk(ns->disk, 0);
+		if (!bio->bi_bdev) {
+			ret = -ENODEV;
+			goto out_unmap;
+		}
  		if (meta_buffer) {
  			struct bio_integrity_payload *bip;

@@ -188,10 +194,11 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
  				ret = -ENOMEM;
  				goto out_free_meta;
  			}
+			req->cmd_flags |= REQ_INTEGRITY;
  		}
  	}

-	blk_execute_rq(req->q, NULL, req, 0);
+	blk_execute_rq(req->q, ns->disk, req, 0);
  	ret = req->errors;
  	if (result)
  		*result = (u32)(uintptr_t)req->special;
@@ -203,8 +210,11 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
   out_free_meta:
  	kfree(meta);
   out_unmap:
-	if (bio)
+	if (bio) {
+		if (bio->bi_bdev)
+			bdput(bio->bi_bdev);
  		blk_rq_unmap_user(bio);
+	}
   out:
  	blk_mq_free_request(req);
  	return ret;
@@ -958,7 +968,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
  		goto out_release_instance;
  	}
  	get_device(ctrl->device);
-	dev_set_drvdata(ctrl->device, dev);
+	dev_set_drvdata(ctrl->device, ctrl);

  	ret = device_create_file(ctrl->device, &dev_attr_reset_controller);
  	if (ret)
@@ -1011,7 +1011,7 @@ int __init nvme_core_init(void)
  	return result;
  }

-void __exit nvme_core_exit(void)
+void nvme_core_exit(void)
  {
  	unregister_blkdev(nvme_major, "nvme");
  	class_destroy(nvme_class);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5d45ca2..45bea69 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -164,6 +164,6 @@ int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
  int nvme_sg_get_version_num(int __user *ip);

  int __init nvme_core_init(void);
-void __exit nvme_core_exit(void);
+void nvme_core_exit(void);

  #endif /* _NVME_H */
--
