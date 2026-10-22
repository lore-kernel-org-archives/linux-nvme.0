Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52491606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dwBpr2md;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcXu9hUS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=; b=dwBpr2md9YNQnB
	InJcTAhcEwg3pVPUSOUYZPM2O+01DyPaUGwxmTaow1UfvAwTKk4bGaxK7WIgDiR+WDo99WWFT1ndf
	u7i4Zv77FURzKQcfDD6We7z8ULJTI1AtHfOuWWAAYZz3Cs+xC/59yxCq21y5EZogQRdR+KbxmSoaE
	cRI13kLjkzBBkwi3Ua2l9i1yw5IkgzHAoUcxinCYhyfpLA5kcmaj6v0fvXFFX+MFblIcTyFJ0PgDc
	wois89nOU8Ak5PXQ01x0M2ospd1SQ8q9snmVyr1a8WxxE+qHzxoa/mUyA/+S1NDL5YsusvnfFNTIp
	R4def3FrMGByzKC/4ZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3D-0000000EKf1-3yaq;
	Thu, 22 Oct 2026 14:45:51 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3B-0000000EKdk-3pso
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:45:51 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-15dd124bbe7so3613796c88.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680349; x=1793285149; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=;
        b=ZcXu9hUSq75ulIL63IrQD8s8LvwUouEHxP0OX1UHAwPbWJPMDbX6O7dniNsvKr1ABT
         RZYpgd3elgpOtwWSJiFKWuDyb1MA0rdfi+A1V6YislNZIT0jbTULxJGMD2gY5WTgms3g
         73Hf9dtXh3ll4IXPr+HwUB0K/So/JS7VJ688EzYyEPR9Hmp2GERSwMx5vdC9I1NZiIR8
         FXh5MfmaaK84/NPuMLEG847aBRGAG7mM/XkB7xbmfrCcRKn28ntTmZdsIGCFXd7mzgWu
         3DhB99d2+Qslh8mbxPom8rZR95n9C+x+hrtfs6js3Ogs09axEqC2QxhnNGZJc2yOgPFv
         9eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680349; x=1793285149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=;
        b=Np3yyohl7mS7WIvUuWvCk07lh7Gy+YbwWC4XHb8LyKdJgxRjhM0bPCOQFONRFnKnIF
         ethGAXZcqUjwmE0Cbp3A6amFPZVo66eZuu8gZinB38Vo4Q3ha96luG7xzKgjEVnMjXAs
         FF7HsHMnhEzTZuqCJ1z9et2bSgEiCajHO9VQlGBfE8gH9CEE/JtsiznBCtpIDPT7AuUk
         sFd6xPRuYwY0OEcf0hn38lx7VDKdcDv9d4n1hn/Z8wrzJiZbsaN0G8oGXcSAY7u7Z167
         FO/YY8iye5lke/SCyh3cj6VRPc4IFxtrZH19Ld+cDyrM7pq7zvVTJus+ro26ZBjtMpl9
         CrKQ==
X-Forwarded-Encrypted: i=1; AKwUvByISJHxlMW9XC42gS5ckKyORrwySH6u7K/N2cFa/w7Uj4z3SIZsgBftGPMCp8YEndQQymVAvIUruhRy@lists.infradead.org
X-Gm-Message-State: AFq9FYJ3+lL9O4qgKeRFOhJcMeIbTXScOvejmRrA0Rb/5suoVwnRwEq0
	Tr8qOEI9DLupIvCXmpGUJbBH6aXg8jUOg56LXujN0gS8Guve8bSh0AA=
X-Gm-Gg: AYBFou0M8ID+ZDb7Mf4BIQsvawYT7oZdNoT48O/yiu3zwS9DFK6WHwjLsR1nswi4nTl
	VxgxKHRx91+XXuJp//yb9AUjLiIzNPYm8mCa+CM4krsaT50afvrU5t1MG0S960+8TMcYhxu4Mcp
	VZLnJBRnVW8TdPiwh86fUlUilJ7MziAhdp6w124NL5uOtcGTvfRsZWcY/PiqUUB84B1VWDWJKHt
	8Q/Ssw7BFNo9h5hpvMPeIFlSnmphAW6DceTQrbbvQi2HzmJPel1cuLlDGTjJ4llN2NT0yX8k9FR
	CRO0q3vXcfdJjQJZgVcPtSGPsHqpUhHXNIuAte6DFvN2jy75MjeNV4zPWLLdF8iEjbeBxg7CTt5
	CXFHErWH2ze5Z8KiMmKvvgXUCCtPaEXvHGyExpjIHY57cft9WZ8uk+oTJI5DJHa2+I/URiNvyWQ
	pJGb63QxGAi8VdXFI+Y6v001oQ/d/KTTtnLecCKL+q/YbUVE5cGTUSFYhlrry5CSJpxgzK16VQf
	c1zVCuoCYJz3FRId0RfmntysV2GPDCKI4FnXBaAnp2/Wp5c8IFHYd31LOaS6ZVTqR5NbLcwGfYa
	kqZzkaNWa4Tb2cGgPzr1s7rGZDu0UfRjhVP4ECKfuKijIoBJhmCMI2ME3HBbXOou
X-Received: by 2002:a05:701b:4284:10b0:14a:9dc3:dd11 with SMTP id a92af1059eb24-190a5999e7fmr7654858c88.18.1792680348543;
        Thu, 22 Oct 2026 07:45:48 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:47 -0700 (PDT)
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
Subject: [PATCH v2 1/5] io_uring/rsrc: pass import flags to io_import_reg_buf()
Date: Thu, 22 Oct 2026 20:14:52 +0530
Message-ID: <20261022144501.2478417-2-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074549_961414_3FF88C67 
X-CRM114-Status: GOOD (  14.22  )
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

Give io_import_reg_buf() the import flags argument and drop the
__io_import_reg_buf() variant, which only existed to pass them.

No functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 io_uring/net.c       |  6 +++---
 io_uring/rsrc.c      |  6 +++---
 io_uring/rsrc.h      | 13 +++----------
 io_uring/rw.c        |  5 +++--
 io_uring/uring_cmd.c |  2 +-
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 050ed274170a..63089744d43e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -644,7 +644,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 		if (unlikely(ret))
 			return ret;
 		req->flags &= ~REQ_F_IMPORT_BUFFER;
@@ -1216,7 +1216,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_DEST, issue_flags);
+					ITER_DEST, issue_flags, 0);
 		if (unlikely(ret)) {
 			kmsg->msg.msg_inq = -1;
 			sel.buf_list = NULL;
@@ -1509,7 +1509,7 @@ static int io_send_zc_import(struct io_kiocb *req,
 	if (!(sr->flags & IORING_SEND_VECTORIZED)) {
 		ret = io_import_reg_buf(notif, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 	} else {
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d64228b0e19e..1abfbb86dae8 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1365,9 +1365,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags)
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 418d236152ff..6226c7862d4e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -66,21 +66,14 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags);
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags);
 int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags,
 			unsigned import_flags);
 
-static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-				    u64 buf_addr, size_t len, int ddir,
-				    unsigned issue_flags)
-{
-	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
-}
-
 static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
 				    struct io_kiocb *req, struct iou_vec *vec,
 				    unsigned nr_iovs, unsigned issue_flags)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index d33b925a848e..71782a23e16b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -360,8 +360,9 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	int ret;
 
 	if (!io->bytes_done) {
-		ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-					  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
+		ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+					issue_flags,
+					IO_REGBUF_IMPORT_ALLOW_DMABUF);
 		if (ret)
 			return ret;
 		iov_iter_save_state(&io->iter, &io->iter_state);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 73b606899833..45c9c845f5d0 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -279,7 +279,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0


