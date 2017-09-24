From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Sep 2017 16:15:55 +0300
Subject: [PATCH v2] nvme-fabrics: request transport module
Message-ID: <1506258955-18109-1-git-send-email-sagi@grimberg.me>

Help userspace to not make sure transport module is
loaded.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- got rid of redundant module name resolution code and ignore request_module
  retcode

 drivers/nvme/host/fabrics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6d68738f01ea..ef38552911d4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -945,6 +945,9 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 	if (ret)
 		goto out_free_opts;
 
+
+	request_module("nvme-%s", opts->transport);
+
 	/*
 	 * Check the generic options first as we need a valid transport for
 	 * the lookup below.  Then clear the generic flags so that transport
-- 
2.7.4
