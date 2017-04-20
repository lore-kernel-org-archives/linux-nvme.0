From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 20:02:18 -0700
Subject: [PATCH 5/5] nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"
In-Reply-To: <cover.1492656278.git.luto@kernel.org>
References: <cover.1492656278.git.luto@kernel.org>
Message-ID: <26e5eaf26df9ccd3d7f952ced6d014183c68b532.1492656278.git.luto@kernel.org>

There's a report that it malfunctions with APST on.

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184

Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bec8c6973ae5..5249027a76ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1415,6 +1415,15 @@ struct nvme_core_quirk_entry {
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
