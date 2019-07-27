From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 03:41:55 +0900
Subject: [PATCH 4/4] nvme: lightnvm: trace opcode name of I/O commands for 2.0
In-Reply-To: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
Message-ID: <20190727184155.18014-5-minwoo.im.dev@gmail.com>

This patch adds opcode values which are defined in OCSSD 2.0 spec.  This
will make it printed a name of opcode rather than the raw value.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Matias Bj?rling <mb at lightnvm.io>
Cc: Javier Gonz?lez <javier at javigon.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 include/linux/nvme.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fddf4c776788..d1db459dbfc1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -566,6 +566,12 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+
+	/* OCSSD 2.0 */
+	nvme_nvm_cmd_vec_chunk_reset	= 0x90,
+	nvme_nvm_cmd_vec_chunk_write	= 0x91,
+	nvme_nvm_cmd_vec_chunk_read	= 0x92,
+	nvme_nvm_cmd_vec_chunk_copy	= 0x93,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
@@ -581,7 +587,11 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
+		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_reset),	\
+		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_write),	\
+		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_read),	\
+		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_copy))
 
 
 /*
-- 
2.17.1
