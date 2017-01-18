From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 17 Jan 2017 17:54:19 -0800
Subject: [PATCH 2/3] nvme: Add a quirk mechanism that uses identify_ctrl
In-Reply-To: <cover.1484703713.git.luto@kernel.org>
References: <cover.1484703713.git.luto@kernel.org>
Message-ID: <66c502d8607570266163224149b1e7f613c65a45.1484703713.git.luto@kernel.org>

Currently, all NVMe quirks are based on PCI IDs.  Add a mechanism to
define quirks based on identify_ctrl's vendor id, model number,
and/or firmware revision.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4e177f042ed..be887dc2ffc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1316,6 +1316,49 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	}
 }
 
+struct nvme_core_quirk_entry {
+	/*
+	 * Careful: the strings are padded with spaces.  Strings in the
+	 * table should be padded with spaces, too.
+	 */
+	u16 vid;
+	const char *mn;
+	const char *fr;
+	unsigned long quirks;
+};
+
+static const struct nvme_core_quirk_entry core_quirks[] = {
+};
+
+/* match is null-terminated but idstr is space-padded. */
+static bool string_matches(const char *idstr, const char *match, size_t len)
+{
+	size_t matchlen;
+
+	if (!match)
+		return true;
+
+	matchlen = strlen(match);
+	WARN_ON_ONCE(matchlen > len);
+
+	if (memcmp(idstr, match, matchlen))
+		return false;
+
+	for (; matchlen < len; matchlen++)
+		if (idstr[matchlen] != ' ')
+			return false;
+
+	return true;
+}
+
+static bool quirk_matches(const struct nvme_id_ctrl *id,
+			  const struct nvme_core_quirk_entry *q)
+{
+	return q->vid == le16_to_cpu(id->vid) &&
+		string_matches(id->mn, q->mn, sizeof(id->mn)) &&
+		string_matches(id->fr, q->fr, sizeof(id->fr));
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -1351,6 +1394,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	if (!ctrl->identified) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
+			if (quirk_matches(id, &core_quirks[i]))
+				ctrl->quirks |= core_quirks[i].quirks;
+		}
+	}
+
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
@@ -1404,6 +1456,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	else if (!ctrl->apsta && prev_apsta)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
+	ctrl->identified = true;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 38df1745ccc8..1e9aa7482b75 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -111,6 +111,7 @@ enum nvme_ctrl_state {
 
 struct nvme_ctrl {
 	enum nvme_ctrl_state state;
+	bool identified;
 	spinlock_t lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
-- 
2.9.3
