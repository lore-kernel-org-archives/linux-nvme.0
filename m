From: luto@kernel.org (Andy Lutomirski)
Date: Fri,  3 Feb 2017 13:44:37 -0800
Subject: [PATCH v3 1/2] nvme: Add a quirk mechanism that uses identify_ctrl
In-Reply-To: <cover.1486158145.git.luto@kernel.org>
References: <cover.1486158145.git.luto@kernel.org>
Message-ID: <d1d0474866948b17deadf6e5b9d3d7149b23db1a.1486158145.git.luto@kernel.org>

Currently, all NVMe quirks are based on PCI IDs.  Add a mechanism to
define quirks based on identify_ctrl's vendor id, model number,
and/or firmware revision.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a3c3e32a704..d393d64955cb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1196,6 +1196,50 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+struct nvme_core_quirk_entry {
+	/*
+	 * NVMe model and firmware strings are padded with spaces.  For
+	 * simplicity, strings in the quirk table are padded with NULLs
+	 * instead.
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
@@ -1230,6 +1274,24 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	if (!ctrl->identified) {
+		/*
+		 * Check for quirks.  Quirk can depend on firmware version,
+		 * so, in principle, the set of quirks present can change
+		 * across a reset.  As a possible future enhancement, we
+		 * could re-scan for quirks every time we reinitialize
+		 * the device, but we'd have to make sure that the driver
+		 * behaves intelligently if the quirks change.
+		 */
+
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
@@ -1272,6 +1334,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	kfree(id);
+
+	ctrl->identified = true;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aead6d08ed2c..9dccf7127cce 100644
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
