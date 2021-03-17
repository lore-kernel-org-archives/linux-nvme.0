Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BCC64E89
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BCC64E89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bwikhO9gHYJ+ppljkemy16E7wmUMJtgbA/jtc3Y49ak=; b=QkUqatmLMS6EJPkkUAP/iQe0f
	kjEC0KVpjCFUfDZ4R+VcVlFAX03tmy1Fj2x0is/i57sAsxZdiFF/SDZDh0sBZ+0EjCaBpEdGUWL5j
	vuTQ5+yCYPH8nTtum467dW2fxxDeFNAIH3fo1XLu8TFdoIz/q0RpO84WQ9jench79g3crY+X0hKOn
	jRyn+IpjOQtbimqTobXL4VISThXzuV++ZIFpeD8MD2RlfCCHMYbUZTFoaFU38OhO0ZpqK478X7fVu
	CtKeewWnIP15XTBqtPXp9nENzNrCKZ2xRfLH2P0UR0kvDYk9JAxn20wqh3jHSJy8UWW1uDymoa0DZ
	+bd5UVEbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeNz-00409z-SB; Wed, 17 Mar 2021 22:11:28 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeNA-00402d-Nf
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:39 +0000
Received: by mail-il1-x12a.google.com with SMTP id l5so3025212ilv.9
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INWD228NDqgvD4EQCIgWqmgA38TSZn5zi4fEppVIAaE=;
 b=JUuWX7jXSv7otlp/27lCUgHF6L3SHeEVV0M7xfAPdMkGPo+7qq8uuY5NGNUt60M/4e
 lAFtN8vfKmVH6pdcJdzGyn9nMEgtUlIHdTFBGIv+EN6DWz4HS+XWpSYuO5TwEIP00s8l
 uIuv0qD6KQLoiS7I4WAAoLavcT78MHOY3ONW800NQElifiBRzRTFeE6e1O6oAFqDBayR
 IjVnYkcnW+Fz26SddIbxHn1iYHeAcctlczlBFhNcZLl91rstJ1bgenA4xaLcDv1Btlhv
 ey87Y6vA0V4MPDONB6LHjRkhmtYOaVl+vex9qIitod9nJ9Y2+8q0A10Q53367jzwZ3dX
 L3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=INWD228NDqgvD4EQCIgWqmgA38TSZn5zi4fEppVIAaE=;
 b=V+dz6dfdU9m+Z1DvYw4fydHoFSY7QfvORfUwjkstEvzDnu3p7PrZckwEg3JXStrg6P
 efCg4fuDvY1mlTNA31lEzvawDRCx6bv4/oHoaFlbehiQVMhx45NU+lGOyfZCOQKmnIdS
 GeAMXJoFfvfTJy1ro+6Al8t5nQ2ZSPCMgut20KN6AYxnTv3F4oMydApkxHta1X8RnFOj
 2DRFspEd6wri8ARydR/RM5eaMpky+r1fvtQ7spQZ631QuF075WtK3Y7DIDNaHvLqWxQm
 5LvYCepx7qiN02h9KXWgyB45epvyV96rKIFGLumGu4QfCTSA1z3NS6E+X3NHVNTY7ZwC
 Gdfw==
X-Gm-Message-State: AOAM530qwAS65Ej+dTCnopukIuuo6jwxPJ9XXUvscVZ3F9EA8Qe+RowP
 AjweQrRHWV/o+oOtpN2PwU/mvg==
X-Google-Smtp-Source: ABdhPJy/mUmlue3lytLdRDmQyub1t+nKmUYu879MJQ25ta1InhoMKLytKtK/XjYEVz3he9ghS2AyUg==
X-Received: by 2002:a92:d5d2:: with SMTP id d18mr8389631ilq.50.1616019035543; 
 Wed, 17 Mar 2021 15:10:35 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] io_uring: add support for IORING_OP_URING_CMD
Date: Wed, 17 Mar 2021 16:10:23 -0600
Message-Id: <20210317221027.366780-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221037_348751_2C052063 
X-CRM114-Status: GOOD (  17.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a file private kind of request. io_uring doesn't know what's
in this command type, it's for the file_operations->uring_cmd()
handler to deal with.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c            | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/io_uring.h | 16 ++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fecf10e0625f..a66f953f71d4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -770,6 +770,7 @@ struct io_kiocb {
 		struct io_shutdown	shutdown;
 		struct io_rename	rename;
 		struct io_unlink	unlink;
+		struct io_uring_cmd	uring_cmd;
 		/* use only after cleaning per-op data, see io_clean_op() */
 		struct io_completion	compl;
 	};
@@ -1002,6 +1003,7 @@ static const struct io_op_def io_op_defs[] = {
 	[IORING_OP_RENAMEAT] = {},
 	[IORING_OP_UNLINKAT] = {},
 	[IORING_OP_URING_CMD] = {
+		.needs_file		= 1,
 		.offsets		= 1,
 	},
 };
@@ -3565,6 +3567,53 @@ static int io_unlinkat(struct io_kiocb *req, unsigned int issue_flags)
 	return 0;
 }
 
+/*
+ * Called by consumers of io_uring_cmd, if they originally returned
+ * -EIOCBQUEUED upon receiving the command.
+ */
+void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
+{
+	struct io_kiocb *req = container_of(cmd, struct io_kiocb, uring_cmd);
+
+	if (ret < 0)
+		req_set_fail_links(req);
+	io_req_complete(req, ret);
+}
+EXPORT_SYMBOL(io_uring_cmd_done);
+
+static int io_uring_cmd_prep(struct io_kiocb *req,
+			     const struct io_uring_sqe *sqe)
+{
+	const struct io_uring_cmd_sqe *csqe = (const void *) sqe;
+	struct io_uring_cmd *cmd = &req->uring_cmd;
+
+	if (!req->file->f_op->uring_cmd)
+		return -EOPNOTSUPP;
+
+	cmd->op = READ_ONCE(csqe->op);
+	cmd->len = READ_ONCE(csqe->len);
+
+	/*
+	 * The payload is the last 40 bytes of an io_uring_cmd_sqe, with the
+	 * type being defined by the recipient.
+	 */
+	memcpy(&cmd->pdu, &csqe->pdu, sizeof(cmd->pdu));
+	return 0;
+}
+
+static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct file *file = req->file;
+	int ret;
+
+	ret = file->f_op->uring_cmd(&req->uring_cmd, issue_flags);
+	/* queued async, consumer will call io_uring_cmd_done() when complete */
+	if (ret == -EIOCBQUEUED)
+		return 0;
+	io_uring_cmd_done(&req->uring_cmd, ret);
+	return 0;
+}
+
 static int io_shutdown_prep(struct io_kiocb *req,
 			    const struct io_uring_sqe *sqe)
 {
@@ -5858,6 +5907,8 @@ static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return io_renameat_prep(req, sqe);
 	case IORING_OP_UNLINKAT:
 		return io_unlinkat_prep(req, sqe);
+	case IORING_OP_URING_CMD:
+		return io_uring_cmd_prep(req, sqe);
 	}
 
 	printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
@@ -6114,6 +6165,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	case IORING_OP_UNLINKAT:
 		ret = io_unlinkat(req, issue_flags);
 		break;
+	case IORING_OP_URING_CMD:
+		ret = io_uring_cmd(req, issue_flags);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 9761a0ec9f95..fd5c8ca40a70 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -30,7 +30,20 @@ struct io_uring_task {
 	struct callback_head	task_work;
 };
 
+/*
+ * Note that the first member here must be a struct file, as the
+ * io_uring command layout depends on that.
+ */
+struct io_uring_cmd {
+	struct file	*file;
+	__u16		op;
+	__u16		unused;
+	__u32		len;
+	__u64		pdu[5];	/* 40 bytes available inline for free use */
+};
+
 #if defined(CONFIG_IO_URING)
+void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret);
 struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_task_cancel(void);
 void __io_uring_files_cancel(struct files_struct *files);
@@ -52,6 +65,9 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
+static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
+{
+}
 static inline struct sock *io_uring_get_socket(struct file *file)
 {
 	return NULL;
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
