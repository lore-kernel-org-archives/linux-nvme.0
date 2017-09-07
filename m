From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 13:20:23 -0700
Subject: [PATCH 1/2] nvme: Add transport SGL definitions
In-Reply-To: <20170907202024.25207-1-jsmart2021@gmail.com>
References: <20170907202024.25207-1-jsmart2021@gmail.com>
Message-ID: <20170907202024.25207-2-jsmart2021@gmail.com>

Add the sgl type code for Transport SGL Data Block Descriptor.

Add the sgl sub type code 0x0A, used by FC Transport.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c46f42269021..823bf6f80dae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -471,12 +471,14 @@ enum nvme_opcode {
  *
  * @NVME_SGL_FMT_ADDRESS:     absolute address of the data block
  * @NVME_SGL_FMT_OFFSET:      relative offset of the in-capsule data block
+ * @NVME_SGL_FMT_TRANSPORT_A: transport defined format, value 0xA
  * @NVME_SGL_FMT_INVALIDATE:  RDMA transport specific remote invalidation
  *                            request subtype
  */
 enum {
 	NVME_SGL_FMT_ADDRESS		= 0x00,
 	NVME_SGL_FMT_OFFSET		= 0x01,
+	NVME_SGL_FMT_TRANSPORT_A	= 0x0A,
 	NVME_SGL_FMT_INVALIDATE		= 0x0f,
 };
 
@@ -490,12 +492,16 @@ enum {
  *
  * For struct nvme_keyed_sgl_desc:
  *   @NVME_KEY_SGL_FMT_DATA_DESC:	keyed data block descriptor
+ *
+ * Transport-specific SGL types:
+ *   @NVME_TRANSPORT_SGL_DATA_DESC:	Transport SGL data dlock descriptor
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		= 0x00,
 	NVME_SGL_FMT_SEG_DESC		= 0x02,
 	NVME_SGL_FMT_LAST_SEG_DESC	= 0x03,
 	NVME_KEY_SGL_FMT_DATA_DESC	= 0x04,
+	NVME_TRANSPORT_SGL_DATA_DESC	= 0x05,
 };
 
 struct nvme_sgl_desc {
-- 
2.13.1
