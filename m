Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BF0C54EBE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q65oXd5D1iLmsQxWkRlnOmmTkHDfVSuNIDDle6g1XFY=; b=UDUjYJQZx/GU1jBlxF9VEDU7Dz
	z7SuPCxxGiCei5zRw1W1i2MNRRzBXfSHAe36b0Cuaxjhmw5r9R9mR6IbtnTKjBvcQMhZ9c4rwgMjh
	4KrrVbOQzkHMkecUrCb78KnBql3/j3h+45xgWQ3Em9e0Y8kiOFLFn86tk/dLQsmE6aj09acLTglXj
	WMAHu+Fa7PlKPJCjiE4kdpbBPeldUjgfyYjUT1/41WqqFkoF7uCE/bfRBtf9+G5tNivs+0hkt/gND
	tsJe7+QnnDagWHC9oQXI9KhMS2thclec1OfyLrTDTS8DX/l1KMj+N4RZyC4tBObMl4/chyGxLYDay
	kR/HJMIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsh-00EQBM-5f; Sun, 08 Jan 2023 16:50:47 +0000
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsb-00EQ80-ED; Sun, 08 Jan 2023 16:50:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: replace the "bool vec" arguments with flags in the ioctl path
Date: Sun,  8 Jan 2023 17:50:32 +0100
Message-Id: <20230108165033.380842-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108165033.380842-1-hch@lst.de>
References: <20230108165033.380842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To prepare for passing down more information, replace the boolean
vec argument with a more extensible flags one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 53 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c12b7c445fc0b2..999ebc1b700056 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -8,6 +8,10 @@
 #include <linux/io_uring.h>
 #include "nvme.h"
 
+enum {
+	NVME_IOCTL_VEC		= (1 << 0),
+};
+
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		fmode_t mode)
 {
@@ -150,7 +154,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, void **metap, struct io_uring_cmd *ioucmd,
-		bool vec)
+		unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
@@ -163,7 +167,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(vec))
+		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
 			return -EINVAL;
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
@@ -172,8 +176,8 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
-				bufflen, GFP_KERNEL, vec, 0, 0,
-				rq_data_dir(req));
+				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
+				0, rq_data_dir(req));
 	}
 
 	if (ret)
@@ -203,9 +207,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, u64 ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
+		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
+		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
+		u64 *result, unsigned timeout, unsigned int flags)
 {
 	struct nvme_ctrl *ctrl;
 	struct request *req;
@@ -221,7 +225,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, meta_seed, &meta, NULL, vec);
+				meta_len, meta_seed, &meta, NULL, flags);
 		if (ret)
 			return ret;
 	}
@@ -304,10 +308,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
-	return nvme_submit_user_cmd(ns->queue, &c,
-			io.addr, length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
-			false);
+	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
+			meta_len, lower_32_bits(io.slba), NULL, 0, 0);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -360,9 +362,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len,
-			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout, false);
+			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
+			cmd.metadata_len, 0, &result, timeout, 0);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -373,8 +374,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd, bool vec,
-			fmode_t mode)
+		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
+		fmode_t mode)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
@@ -408,9 +409,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len,
-			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout, vec);
+			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
+			cmd.metadata_len, 0, &cmd.result, timeout, flags);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -643,7 +643,7 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, mode);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -670,6 +670,8 @@ struct nvme_user_io32 {
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, fmode_t mode)
 {
+	unsigned int flags = 0;
+
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -686,10 +688,11 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 #endif
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
-	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
+		flags |= NVME_IOCTL_VEC;
+		fallthrough;
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_user_cmd64(ns->ctrl, ns, argp, flags, mode);
 	default:
 		return -ENOTTY;
 	}
@@ -962,7 +965,7 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp, file->f_mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false, file->f_mode);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, file->f_mode);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp, file->f_mode);
 	case NVME_IOCTL_RESET:
-- 
2.35.1


