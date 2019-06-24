From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Jun 2019 13:05:19 -0700
Subject: [PATCH nvme-cli 1/3] nvme-cli: Restore support for older gcc versions
In-Reply-To: <20190624200521.28191-1-bvanassche@acm.org>
References: <20190624200521.28191-1-bvanassche@acm.org>
Message-ID: <20190624200521.28191-2-bvanassche@acm.org>

Older versions of gcc do not support initializing another than the first
member of a union in an initializer. Rewrite some code such that support
for older gcc versions is restored.

Fixes: 301e263c34e8 ("nvme-cli: Rework the code for getting and setting NVMf properties")
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-ioctl.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 57fae22e1e37..524502bf4bed 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -576,16 +576,16 @@ static void nvme_to_passthru_cmd(struct nvme_passthru_cmd *pcmd,
 int nvme_get_property(int fd, int offset, uint64_t *value)
 {
 	struct nvme_passthru_cmd pcmd;
-	struct nvme_command gcmd = {
-		.prop_get = {
-			.opcode	= nvme_fabrics_command,
-			.fctype	= nvme_fabrics_type_property_get,
-			.offset	= cpu_to_le32(offset),
-			.attrib = is_64bit_reg(offset),
-		}
+	struct nvmf_property_get_command pg = {
+		.opcode	= nvme_fabrics_command,
+		.fctype	= nvme_fabrics_type_property_get,
+		.offset	= cpu_to_le32(offset),
+		.attrib = is_64bit_reg(offset),
 	};
+	struct nvme_command gcmd;
 	int err;
 
+	gcmd.prop_get = pg;
 	nvme_to_passthru_cmd(&pcmd, &gcmd);
 	err = nvme_submit_admin_passthru(fd, &pcmd);
 	if (!err) {
@@ -635,17 +635,17 @@ int nvme_get_properties(int fd, void **pbar)
 
 int nvme_set_property(int fd, int offset, uint64_t value)
 {
-	struct nvme_command scmd = {
-		.prop_set = {
-			.opcode	= nvme_fabrics_command,
-			.fctype	= nvme_fabrics_type_property_set,
-			.offset	= cpu_to_le32(offset),
-			.value = cpu_to_le64(value),
-			.attrib = is_64bit_reg(offset),
-		}
+	struct nvmf_property_set_command ps = {
+		.opcode	= nvme_fabrics_command,
+		.fctype	= nvme_fabrics_type_property_set,
+		.offset	= cpu_to_le32(offset),
+		.value = cpu_to_le64(value),
+		.attrib = is_64bit_reg(offset),
 	};
+	struct nvme_command scmd;
 	struct nvme_passthru_cmd pcmd;
 
+	scmd.prop_set = ps;
 	nvme_to_passthru_cmd(&pcmd, &scmd);
 	return nvme_submit_admin_passthru(fd, &pcmd);
 }
-- 
2.22.0.410.gd8fdbe21b5-goog
