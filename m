From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Sep 2017 15:45:25 +0300
Subject: [PATCH rfc] nvme-fabrics: request transport module
Message-ID: <1506257125-15257-1-git-send-email-sagi@grimberg.me>

Help userspace to not make sure transport module is
loaded.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
This is useful for having systemd nvmf auto discovery service

 drivers/nvme/host/fabrics.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6d68738f01ea..7d3381f05bf1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -551,6 +551,27 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
+static int nvmf_request_transport(struct nvmf_ctrl_options *opts)
+{
+	char *mod_name;
+	int ret;
+
+	if (!strcmp(opts->transport, "rdma"))
+		mod_name = "nvme-rdma";
+	else if (!strcmp(opts->transport, "fc"))
+		mod_name = "nvme-fc";
+	else if (!strcmp(opts->transport, "loop"))
+		mod_name = "nvme-loop";
+	else
+		return -EINVAL;
+
+	ret = request_module(mod_name) < 0;
+	if (ret)
+		pr_warn("Unable to request_module %s %d\n", mod_name, ret);
+
+	return ret;
+}
+
 static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
@@ -945,6 +966,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 	if (ret)
 		goto out_free_opts;
 
+	ret = nvmf_request_transport(opts);
+	if (ret)
+		goto out_free_opts;
+
 	/*
 	 * Check the generic options first as we need a valid transport for
 	 * the lookup below.  Then clear the generic flags so that transport
-- 
2.7.4
