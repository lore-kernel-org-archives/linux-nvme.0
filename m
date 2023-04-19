Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96730C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nKd6U2hdN/wKqS9vBvVQ20kqKQoQ1wl1NRB1Zc7v3kA=; b=3k94g2dw3ZfuW0KN6Tua1r/l7V
	RTbngU+n2plJg0YZa/EtjV97fKLFi1WAsKV7dwr0KoKElNTnmwedjtAH9Yhd5hqt/NsQt4u4Gs0dv
	GcS7uJaY9KUMf/783EQ74EX85f10iiNVWSiQ99kYBx+8pR0e6SCV9TQfNXbU1kgGNxQ1/6unajRjJ
	iEtMn7UjRgOdUj3wCNU9Ho5boWO6j0FrcffZwxZWWYsr0ApmyfOwgvv6nWAZIC+mvYjNozO6rWdIL
	2+IXDfTejpg7xRZ46jcvvTtQDfwg/zqg267YmT+yCXXaHIGWQm/WrJ+KEEE819P2R2epr6/buk8wI
	jxBpNcdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54S-004wT6-2C;
	Wed, 19 Apr 2023 10:29:52 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54N-004wO2-2m
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:29:49 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f17fdb5062so4454835e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 03:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900186; x=1684492186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKd6U2hdN/wKqS9vBvVQ20kqKQoQ1wl1NRB1Zc7v3kA=;
        b=Wck0XxGoqIp7u0SElURlUXH+sm617QpZF9BJJ3XE7xFPwLfQw9bxQQrXep6nQXvsZ3
         w9NZIHKzQMwybRIXgolB5ydIL4fuhcX6EQ3khDSMwyArWVgqgcWYbvISvpwVsgLIo2i6
         qXJRBwAGhPKrDuW60R6ho3j7d8GPo1hoVx1QjVxeApo3EoBU9/e3NV8LNXepeNQWqYgN
         I2oF1Px/xj2R5HIaY7xEGw0UvSkqXn4xxTeYBd4cya4UUmEJb/ds4wmYAPpzVlvvWFx7
         pzbgeg7mtFnSYwf/hPZNl9y7rnhdEs3/gYBhOYYYrc7+jS85DXylLqqiQNLjsTRBetFr
         4zNA==
X-Gm-Message-State: AAQBX9e6G6e6icumB/eXXDIY2BayQLnHBA/OK4tFzzDbAi3jmPiTr4Z1
	eEs2Ab9QqoC7SCXstwZlmJg=
X-Google-Smtp-Source: AKy350aErSC14OPRodujGV1wZlb8N5UbI74LcJ0YjNUozDWCE+1E8pSWpErzfBHbk0EZjJSiWFZG6Q==
X-Received: by 2002:a5d:6a8c:0:b0:2f6:620f:92ca with SMTP id s12-20020a5d6a8c000000b002f6620f92camr4422121wru.23.1681900185844;
        Wed, 19 Apr 2023 03:29:45 -0700 (PDT)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6107000000b002fdeafcb132sm3552973wrt.107.2023.04.19.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:29:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	ming.lei@redhat.com
Subject: [PATCH 1/2] io_uring: Pass whole sqe to commands
Date: Wed, 19 Apr 2023 03:29:29 -0700
Message-Id: <20230419102930.2979231-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419102930.2979231-1-leitao@debian.org>
References: <20230419102930.2979231-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_032947_900373_564D1176 
X-CRM114-Status: GOOD (  18.31  )
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

Currently uring CMD operation relies on having large SQEs, but future
operations might want to use normal SQE.

The io_uring_cmd currently only saves the payload (cmd) part of the SQE,
but, for commands that use normal SQE size, it might be necessary to
access the initial SQE fields outside of the payload/cmd block.  So,
saves the whole SQE other than just the pdu.

This changes slightly how the io_uring_cmd works, since the cmd
structures and callbacks are not opaque to io_uring anymore. I.e, the
callbacks can look at the SQE entries, not only, in the cmd structure.

The main advantage is that we don't need to create custom structures for
simple commands.

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/ublk_drv.c  | 24 ++++++++++++------------
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/io_uring.h  |  2 +-
 io_uring/opdef.c          |  2 +-
 io_uring/uring_cmd.c      | 11 ++++++-----
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c73cc57ec547..ec23a3c9fac8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1263,7 +1263,7 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
-	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
+	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->sqe->cmd;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
@@ -1567,7 +1567,7 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 
 static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	int ublksrv_pid = (int)header->data[0];
 	struct gendisk *disk;
 	int ret = -EINVAL;
@@ -1630,7 +1630,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	cpumask_var_t cpumask;
 	unsigned long queue;
@@ -1681,7 +1681,7 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 
 static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
@@ -1844,7 +1844,7 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 
 static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 
 	pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len %u\n",
 			__func__, cmd->cmd_op, header->dev_id, header->queue_id,
@@ -1863,7 +1863,7 @@ static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 
 	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
@@ -1894,7 +1894,7 @@ static void ublk_ctrl_fill_params_devt(struct ublk_device *ub)
 static int ublk_ctrl_get_params(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
 	int ret;
@@ -1925,7 +1925,7 @@ static int ublk_ctrl_get_params(struct ublk_device *ub,
 static int ublk_ctrl_set_params(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
 	int ret = -EFAULT;
@@ -1983,7 +1983,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	int ret = -EINVAL;
 	int i;
 
@@ -2025,7 +2025,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
 
@@ -2092,7 +2092,7 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	char *dev_path = NULL;
@@ -2171,7 +2171,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
 	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e05156..351dff872fa0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -552,7 +552,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct io_uring_cmd *ioucmd, unsigned int issue_flags, bool vec)
 {
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	const struct nvme_uring_cmd *cmd = ioucmd->cmd;
+	const struct nvme_uring_cmd *cmd = (struct nvme_uring_cmd *)ioucmd->sqe->cmd;
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_uring_data d;
 	struct nvme_command c;
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 35b9328ca335..2dfc81dd6d1a 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -24,7 +24,7 @@ enum io_uring_cmd_flags {
 
 struct io_uring_cmd {
 	struct file	*file;
-	const void	*cmd;
+	const struct io_uring_sqe *sqe;
 	union {
 		/* callback to defer completions to task context */
 		void (*task_work_cb)(struct io_uring_cmd *cmd, unsigned);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index cca7c5b55208..3b9c6489b8b6 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -627,7 +627,7 @@ const struct io_cold_def io_cold_defs[] = {
 	},
 	[IORING_OP_URING_CMD] = {
 		.name			= "URING_CMD",
-		.async_size		= uring_cmd_pdu_size(1),
+		.async_size		= 2 * sizeof(struct io_uring_sqe),
 		.prep_async		= io_uring_cmd_prep_async,
 	},
 	[IORING_OP_SEND_ZC] = {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 5113c9a48583..5cb2e39e99f9 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -69,15 +69,16 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 int io_uring_cmd_prep_async(struct io_kiocb *req)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	size_t cmd_size;
+	size_t size = sizeof(struct io_uring_sqe);
 
 	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
 	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
 
-	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
+	if (req->ctx->flags & IORING_SETUP_SQE128)
+		size <<= 1;
 
-	memcpy(req->async_data, ioucmd->cmd, cmd_size);
-	ioucmd->cmd = req->async_data;
+	memcpy(req->async_data, ioucmd->sqe, size);
+	ioucmd->sqe = req->async_data;
 	return 0;
 }
 
@@ -103,7 +104,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		req->imu = ctx->user_bufs[index];
 		io_req_set_rsrc_node(req, ctx, 0);
 	}
-	ioucmd->cmd = sqe->cmd;
+	ioucmd->sqe = sqe;
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
 	return 0;
 }
-- 
2.34.1


