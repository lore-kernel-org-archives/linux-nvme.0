From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 21 Feb 2018 10:26:53 +0100
Subject: [PATCH 15/20] nvme: make nvme_get_log_ext available
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519205218-26994-16-git-send-email-javier@cnexlabs.com>

Make nvme_get_log_ext available outside of core.c.

This is in preparation for using it in lightnvm.c

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.>
---
 drivers/nvme/host/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ca08f4993ba..505f797f8c6c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -396,6 +396,9 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		     u8 log_page, void *log, size_t size, size_t offset);
+
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.7.4
