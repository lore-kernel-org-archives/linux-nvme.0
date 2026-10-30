Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF7606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bzlMqsLQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ewLaeqEb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=; b=bzlMqsLQi0Yy/z
	AAGvfzX2GKISTc/vF8Va5syHU6dTzK9Yc5pNvpzNBcchzE+xHCrVQa/cMjqRjZs74Vaqdo8wcvLSs
	dW14/wfR4veeEcFj7RJWWC+Z1W0gecPtlV5n0wOR2504RM9IRiHo5UpcL0y4xOlg2z9FsVG6vKKlc
	70u5ismNCoxpbSf97ebQihXKxlibwuBMK8XM4eIF/nBbUjo6NXFtz4riCbjeBt562Wq5z4CWBmavC
	Y9zRH1z2EItKlNa8304RyynWBLBndffxdFF9BC7l5ccrtF8kqvSR41LkF35L9TLyLLbW+Z8p+HqK2
	PvNKMorJr3TpTMuaRWPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbhA-0000000Ad9X-0YVx;
	Fri, 30 Oct 2026 01:46:16 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbh6-0000000Ad68-1dZm
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:46:14 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-369f33df08eso525293eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324771; x=1793929571; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=;
        b=ewLaeqEbXHR2PwvvVygRGwHw7gNAOPk0f+zYEE7b+c/Lqfa/QqsBdw6P5GBu0QndWm
         ewBwGXXSZ2HW78CqKM6Sx3Qnzrez2FAfCgnz0PDrO5ahmzeUGNljGl0W+JTxDqYWjf6P
         vW5ussJC4agOXZ95nFLiCRbrIJo7kuUou/f6J7b6zycB1mAKhuMALf78N4HR40c7f4yI
         XeqJ9ZVrY+cmdWuOtURx9l1zhi2whEInHvsfFO5b3Ai05o0G2Bkqvib0/bKHydumKDnc
         CMMcoFq5FBS4uQR03caUnyXiLg3wxtfcZzOt85PRLphtc8cvjITnfT4BUgLDw9Sq7J+l
         G7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324771; x=1793929571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=;
        b=DqQ3Sd8vVPKwqXTXBc1STprLG8BT5dV9FFY9e9VBMJtWCyVppeLI1yy7SqbwPPJHmE
         m8GdOj8AxKoTtovWKVrTAGzyvAg835KZ6EbAgFBVyVnCVhl6nWNMtx84+oRHxr8HuB+y
         dczLkFAXbzioh3rG8Jg01Kmo0gRmB/I/XsKOhQ+GaIGGHKiDk3qzIWoEHAMwln/O0J96
         sygK54op0qVFw5Z892b3u4XeGHTbAWr6XZf9BoLuamRamBGd0zHK6eVhJ5XOuFh1bXGG
         KWC0HnRjYBOarYtzr+GT7n9OOE70XyJdgPmBq82Fa0qPet13QuTbTLK2R9KLeZ7Q1zKi
         zezQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPyZu5hUOv5l3tZtlgyW/rvxHOybPKgjKq2LenSHB/5xtoagRPSkIS6QQN7Gd7mtzLj31R5NhjfIf/@lists.infradead.org
X-Gm-Message-State: AFq9FYLY9sO+eOdw3BGUVyLGj4K2V/tNZCrdFmhP+MhlvUZnL99hXvHF
	HZudPyGk9tD+rZC8IOHpzssVpSQs3PkTo4j9syBt0TVyUJh5+seZ3WU=
X-Gm-Gg: AYBFou2cAJKnIeIzIDKljBe60JaGI+DrJFJjZLG7Kh84mztlAsfRxIlrfjeou14X10H
	4U3Cx6G0Z8twRXiQm9gbWSNgnU9TjmF3skxMwQVqsqETE+yEbgCbMq3/lOE2fxfFBLXVV/wPlw3
	NVpYgqXkgxl898tTozVf6vV2DGBwQ2d2Z2shpwaQf+h5o2m5zhCkcOZ3n3QwG5DzQaB1IfEunua
	uc6gfvOD7lsaP9oSP9Rd5UOPQiuuURveG9pD369Rdj9fn8YLpfhwK5n4DJ1or5ZO674d4oJPhLH
	Bh88JLIKAK8zFJSHyFIhN0gFnJooLlpzjL8pcsTGK2hrjSiNqaA86C0zTpcn1l0mAKJrfNtLdPR
	leye7yBTZtbFWiKp9XLNIoHpRKGwFdf3AvuLhurvNLW7QCqkXiW9HWzVHce+oQ+Hk9dnTyGCsCS
	7EQFi/YS66ZvPKlX9y13DG2yG2YW7cEM3gepjkbn2wApALCycFyfa+FHeugN/rncwd/jFfNADN0
	hymyT89FRWUGKsi/OBpocmEzQi8Pn9t9tz1F6TzY0WKNXBZrFiYqMhmeeflCjG6IL5nrwmdwZgF
	THdyMgn/dh94hxV0wHN6k9SMjJeQ1zsEn+rD5ta6XEmhHfnd5m3xdsmt9UoNtkdMv9ezH3J9nPX
	p/Y5jm/jvUydFrPSAtw==
X-Received: by 2002:a05:701b:4189:20b0:182:6c6c:d876 with SMTP id a92af1059eb24-1ac5cb1a331mr1177745c88.8.1793324770340;
        Thu, 29 Oct 2026 18:46:10 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:09 -0700 (PDT)
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
Subject: [PATCH v3 3/5] io_uring/uring_cmd: support dma-buf registered buffers
Date: Fri, 30 Oct 2026 07:15:38 +0530
Message-ID: <20261030014540.3065403-4-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184612_865894_75170FBA 
X-CRM114-Status: GOOD (  18.81  )
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
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
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
index d77a94d19cb5..446bc8a363e6 100644
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


