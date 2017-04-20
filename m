From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 09:11:16 -0700
Subject: [PATCH v2 2/2] nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"
In-Reply-To: <cover.1492704577.git.luto@kernel.org>
References: <cover.1492704577.git.luto@kernel.org>
Message-ID: <69c1adef0d725e43212383b318c039f85a793b1d.1492704577.git.luto@kernel.org>

There's a report that it malfunctions with APST on.

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184

Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d618b20ce6c6..1fbcdcdada78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1395,6 +1395,15 @@ struct nvme_core_quirk_entry {
 };
 
 static const struct nvme_core_quirk_entry core_quirks[] = {
+	{
+		/*
+		 * This Toshiba device seems to die using any APST states.  See:
+		 * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184/comments/11
+		 */
+		.vid = 0x1179,
+		.mn = "THNSF5256GPUK TOSHIBA",
+		.quirks = NVME_QUIRK_NO_APST,
+	}
 };
 
 /* match is null-terminated but idstr is space-padded. */
-- 
2.9.3
