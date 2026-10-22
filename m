Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FB606A323
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iCE7JaSA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6qQtQJl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FUBUxv2+cLHIibfRDgDVbzcbIlm0UwZa4nEXrVqB/pM=; b=iCE7JaSAWl/IDo
	np7T5/Qnp4BnxY7JybPZvpWPZC7HFaLnM5iYUFYLgbygB+XudI+XCGKNCd3xKnC7bNv8mFgvlth0P
	xpBG0ILVlALDLp7Sk3Bh4Ae2PlF3JkucCJuEvlHNQy73308GIXNq16BxQfF+Qm+cjZZDlklqjLQ8v
	4dwOX+fVe+NIRG/Zm8mGjV+wRadAVsIuEylsoadIqJjlFhEiGYG/M4jMhaa9f6//aPWjpWRIhp0Y3
	z23R7HIQDG6m2xqw6CUOkDaDS0KVDK6Ut2SeiR/O2h9jhs3Ij3HKvtbGovfU8xKIx88eKyd2p8E4Y
	4zgG59ZvC/HmhOmQI9pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3R-0000000EKkj-0maM;
	Thu, 22 Oct 2026 14:46:05 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3P-0000000EKk1-1EPS
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:46:04 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-33fb4680717so4677998eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680362; x=1793285162; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUBUxv2+cLHIibfRDgDVbzcbIlm0UwZa4nEXrVqB/pM=;
        b=J6qQtQJlJtEpyEsGoRluBm5a7rzDj/LWZ1wdlf5jpK0RBazExOz9P5k5ARCMGcIGaa
         /+ZuScfjJ7mqFtOh1NhaaVZmheZlA1s7JILvPZS3YqDJMG2CnI2rT1PiDe64X0CQwlvw
         fFfIsvnjtvlueeTS14OAN9S9X3hUerbshboSpnwy3eUMg07v63M+qIimWNxXlSNEBYBg
         JgkBkRYWJH284M0cHg1bzs49e8E8x7SXvYPgKeHcFZ9H+msPNfTeLPmPQeEEk/yVHNT+
         2TflUgVPpF0k35N9+r68W0sf58ndwfgXrK9Mfc4C/rpvDyBFgSF2MrXUqglfyrt3xgZt
         hIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680362; x=1793285162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FUBUxv2+cLHIibfRDgDVbzcbIlm0UwZa4nEXrVqB/pM=;
        b=ddojgO9x7Y7hLVerP7APH79xGEZHmvjGRTNjH5KjaH30mNG1+3+6IfXuZrZ74gC4C0
         agb8Wz30aYjbRNuh0rPO0AgqM4p7aCvljd2fDG0DHPD6NgPeuveMKpmjIKwlqbu6Va/2
         mTbuei+LSujXR8n6AEbPELO8/162LPkcwxrRUVqWh5/bcN9JQpmLZMSuX81sNdkz/6iF
         8limI1q7D8bBKNh8+pqJOwXO5WDdPQGs0IeNhI9Tfbol1RloVNa/7iTD2GfsHILfLNx8
         jwmqoQWMMEDUAp6X+J0MANp92D0ldC2nI/lX+5uuPW/keLPOHllAQlE/OuJNDBrDASrH
         F6uw==
X-Forwarded-Encrypted: i=1; AKwUvBwPbivAgWiI9HNb2S08PC5xSBx0UoqhvQTHte+LqbEDDgYpfCN8ez44LIxnIhWjtbvH0ReGD/lxeFCI@lists.infradead.org
X-Gm-Message-State: AFq9FYJLbUgkm3HS4VgxKSWt7ojMq3a81NRROEFHmPSts9j1NDvGf02e
	acsmCEmlg3kwbWW25v7Vqaxsn1XT4FAP0pYoLs5APSBeih+mOTd8pBM=
X-Gm-Gg: AYBFou063Luiwur6emzGAvjn+jSa1haWti2paRztRp5hvgH1HaTA7RPgPOVhu5fB8k6
	yg7e2+j0OOrr9sfZslQPHn1Ch0/712xe6AK+WGjpQ3MeUaA2OPIDCRuMfa7q/EWNYynLT6kUOpx
	WuHn7Qu41edt2+YwIQvdgmzTGH51eS5BaRyCmgF8+ju57iBwJO7+UJOB9v/54TdaeJCtXPwbytO
	Ezu7mnhtK05CrT5XjblPfWMut3Dk7nWRutnbF3cGaL9dx25mlihf1WYoae9iuDKHG0OmhkMNjGT
	HIfxkEylE7OIHX9VA+Iten06nvwAuztW1C6ON/pBY1WruKJk1XluP79PeTRG741OEd4CveGnI3a
	UzGyFTcush8eVNbGH0Q/CQhVMoOLv1HWy6IyawYQ4VfGb+WQR4yvTexr46SgHH3Ys35VOkso4Jy
	CzpPRcPRPTRCMfk3PZS5skRxpP5gCGrSzgwYXW0uqfuRYk3GEFdSSodiCxGQLflLmUkv/SnCYbo
	YtJz151z6BaxMdtxfmKPZiWjM5lxoc89JNwsP5apCStxjYqFGi6WNDJZBjv9eLnFBhm5OmERPjF
	RRjaEUt+q9EQc2d9cxGZ3Q5hTg3bWFrHtyMK0F5JHsk=
X-Received: by 2002:a05:701b:4584:b0:166:862b:9bcc with SMTP id a92af1059eb24-190a51e584cmr6626141c88.18.1792680361951;
        Thu, 22 Oct 2026 07:46:01 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:46:01 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v2 3/5] io_uring/uring_cmd: support dma-buf registered buffers
Date: Thu, 22 Oct 2026 20:14:54 +0530
Message-ID: <20261022144501.2478417-4-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074603_341076_6DEF7D3E 
X-CRM114-Status: GOOD (  19.08  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anuj Gupta <anuj20.g@samsung.com>

Let callers of io_uring_cmd_import_fixed() opt in to dma-buf registered
buffers with IO_URING_CMD_IMPORT_DMABUF, and attach the current map on
import.

The map has to be dropped at hardware completion rather than from
task_work. Add io_uring_cmd_hw_done() for drivers to call from end_io,
which drops the map and queues task_work, and warn if task_work is
queued with a map still attached.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/io_uring/cmd.h |  9 +++++++++
 io_uring/uring_cmd.c         | 28 ++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 23fb66a1e2c1..d4e17c2f59fd 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -12,6 +12,9 @@
 /* io_uring_cmd is being issued again */
 #define IORING_URING_CMD_REISSUE	(1U << 31)
 
+/* io_uring_cmd_import_fixed() flags */
+#define IO_URING_CMD_IMPORT_DMABUF	(1U << 0)
+
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
@@ -86,6 +89,8 @@ void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb);
 
 /*
  * Note: the caller should never hard code @issue_flags and only use the
@@ -145,6 +150,10 @@ static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
 }
+static inline void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+					io_req_tw_func_t task_work_cb)
+{
+}
 static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index c2bc9dd242ec..c89f154190b1 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -10,6 +10,7 @@
 
 #include "io_uring.h"
 #include "alloc_cache.h"
+#include "dma-buf.h"
 #include "rsrc.h"
 #include "kbuf.h"
 #include "uring_cmd.h"
@@ -28,6 +29,7 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
 
+	io_detach_dmabuf_map(req);
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
@@ -132,12 +134,26 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
+	/* the dma-buf map must be dropped first, see io_uring_cmd_hw_done() */
+	WARN_ON_ONCE(req->dmabuf_map);
 
 	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
+/*
+ * Queue completion in task context after dropping references that must be
+ * released at hardware completion rather than from task_work.
+ */
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb)
+{
+	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_hw_done);
+
 /*
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.
@@ -257,6 +273,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
+		io_detach_dmabuf_map(req);
 		ioucmd->flags |= IORING_URING_CMD_REISSUE;
 		return ret;
 	}
@@ -276,13 +293,20 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      unsigned int import_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	unsigned int flags = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
-	if (WARN_ON_ONCE(import_flags))
+	if (WARN_ON_ONCE(import_flags & ~IO_URING_CMD_IMPORT_DMABUF))
 		return -EINVAL;
+	if (import_flags & IO_URING_CMD_IMPORT_DMABUF)
+		flags |= IO_REGBUF_IMPORT_ALLOW_DMABUF;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
+	ret = io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, flags);
+	if (ret)
+		return ret;
+	return io_attach_dmabuf_map(req, iter, issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0


