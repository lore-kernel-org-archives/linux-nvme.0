From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Tue, 15 Nov 2016 23:06:58 -0800
Subject: [PATCH 3/5] nvme.h: add Write Zeroes definitions
Message-ID: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>

Add the command structure, optional command set support (ONCS) bit and
a new error code for the Write Zeroes command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 include/linux/nvme.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9f3b488..5bf1d2d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -242,6 +242,7 @@ enum {
  NVME_CTRL_ONCS_COMPARE = 1 << 0,
  NVME_CTRL_ONCS_WRITE_UNCORRECTABLE = 1 << 1,
  NVME_CTRL_ONCS_DSM = 1 << 2,
+ NVME_CTRL_ONCS_WRITE_ZEROES = 1 << 3,
  NVME_CTRL_VWC_PRESENT = 1 << 0,
 };

@@ -558,6 +559,23 @@ struct nvme_dsm_range {
  __le64 slba;
 };

+struct nvme_write_zeroes_cmd {
+ __u8 opcode;
+ __u8 flags;
+ __u16 command_id;
+ __le32 nsid;
+ __u64 rsvd2;
+ __le64 metadata;
+ union nvme_data_ptr dptr;
+ __le64 slba;
+ __le16 length;
+ __le16 control;
+ __le32 dsmgmt;
+ __le32 reftag;
+ __le16 apptag;
+ __le16 appmask;
+};
+
 /* Admin commands */

 enum nvme_admin_opcode {
@@ -857,6 +875,7 @@ struct nvme_command {
  struct nvme_download_firmware dlfw;
  struct nvme_format_cmd format;
  struct nvme_dsm_cmd dsm;
+ struct nvme_write_zeroes_cmd write_zeroes;
  struct nvme_abort_cmd abort;
  struct nvme_get_log_page_command get_log_page;
  struct nvmf_common_command fabrics;
@@ -947,6 +966,7 @@ enum {
  NVME_SC_BAD_ATTRIBUTES = 0x180,
  NVME_SC_INVALID_PI = 0x181,
  NVME_SC_READ_ONLY = 0x182,
+ NVME_SC_ONCS_NOT_SUPPORTED = 0x183,

  /*
  * I/O Command Set Specific - Fabrics commands:
-- 
1.8.3.1
