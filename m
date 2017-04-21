From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 21 Apr 2017 16:19:24 -0700
Subject: [PATCH 3/3] nvme: Add nvme_core.force_apst to ignore the NO_APST quirk
In-Reply-To: <cover.1492816561.git.luto@kernel.org>
References: <cover.1492816561.git.luto@kernel.org>
Message-ID: <13c7ac4b73ad6773b2b71cc317a8af73108bff34.1492816561.git.luto@kernel.org>

We're probably going to be stuck quirking APST off on an over-broad
range of devices for 4.11.  Let's make it easy to override the quirk
for testing.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05ba4f8bb73b..5249027a76ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -62,6 +62,10 @@ module_param(default_ps_max_latency_us, ulong, 0644);
 MODULE_PARM_DESC(default_ps_max_latency_us,
 		 "max power saving latency for new devices; use PM QOS to change per device");
 
+static bool force_apst;
+module_param(force_apst, bool, 0644);
+MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -1504,6 +1508,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		}
 	}
 
+	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
+		dev_warn(ctrl->dev, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
+		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
+	}
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
@@ -1526,7 +1535,16 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->npss = id->npss;
 	prev_apsta = ctrl->apsta;
-	ctrl->apsta = (ctrl->quirks & NVME_QUIRK_NO_APST) ? 0 : id->apsta;
+	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
+		if (force_apst && id->apsta) {
+			dev_warn(ctrl->dev, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
+			ctrl->apsta = 1;
+		} else {
+			ctrl->apsta = 0;
+		}
+	} else {
+		ctrl->apsta = id->apsta;
+	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
 	if (ctrl->ops->is_fabrics) {
-- 
2.9.3
