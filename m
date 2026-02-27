Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CE91048921
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOsPp0sNuMqBvgksLLC7w2ENUHuNEhH517t3YeRJRmc=; b=oNs1oOEVyj7xH7craGCUBV6Kq9
	PbkE2J84svmE9tySM/H/y/3+uZ0UpUD20FulOeFK4YsOfCe5EE2z7+BTXW10mOKefDZIggP7RY/lf
	p9dlhduczudgsi/zf2cEUINMf+SK4MJWARpcD6UExldKXR5SJOJ1AtttDI+6R1iRTNkg6tNSy4hpt
	FhJ/oWBJFnKwbPrOT7FGrRsp4OXV5CQiX2QQZOMQ+32zYVJmL4HnXnZxbMkC8eeFQKIxnHB6Cf0c2
	lDHSokNdKKzjf60Ug1+wMyLdc3062K5ixElEsJtoiin5O+oVqO/4Stgw+k2K5Ho9eEjQbQCeBG9N3
	7DM1DjRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6Qb-00000009DpD-1IMt;
	Fri, 27 Feb 2026 22:35:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QW-00000009Dm8-3Ya8
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 22:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FOsPp0sNuMqBvgksLLC7w2ENUHuNEhH517t3YeRJRmc=; b=nYg/LghF5ziPyhgcjQ5MAQPez4
	aUs8aqxYQjYU/aDuI6zr30KBKVgR+l6RgBPS4fO3EVTy3MiKxOGJ+SpMhc/+1LtAFIoKpr5ITMUmL
	pqmU3oLAwRmS+V8leJ50OrOXUZ36kcBqT6dfKhrClZdRxJII/4If3vNqgKbtumVj7bMtITCl8PRl2
	nle8RJwk6YoJgh16ppFUDtimx67Q5di8Sg1vM4EjBCejLXRirMD+5YgyIlA4UjAGOUMiJM6z9piv6
	YL09sMSgDtC6IDetxbw3ljL/oSC/ta/hac76vkPrks115Vei7icYLyv8fZ60MUM9aLbemGDpmXcdb
	XUQhsQCw==;
Received: from mail-vk1-xa68.google.com ([2607:f8b0:4864:20::a68])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QQ-0000000E0gZ-39w5
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:15 +0000
Received: by mail-vk1-xa68.google.com with SMTP id 71dfb90a1353d-56a80383683so96460e0c.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231708; x=1772836508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOsPp0sNuMqBvgksLLC7w2ENUHuNEhH517t3YeRJRmc=;
        b=BICMKZeoWZ2FOFnUz8n+hFS5XahuRdN5T8oKyz9CP/AYa1ilv5Cx2+PwRjS2uQdk/v
         /joftS4OKXcAS+VjSSn6MDolffSa5CIHEABLAHAA4mJUDvXFPQFpnw6n1WW51vWIYVDv
         HD3dA81UZkUGaBQycdD5ioQioecjvSIWbSL3DisDFSMKKpxhJkzs2q/KSyp/qCekjPrj
         bZSaET0O8vNoAIQEku/VAyA7N/Tbc4yr0MuFtANnN1r4tVdZm0Te07qkB/K5pb2koq8y
         VfKV0PipMKZ98Wt8AnPcU3XrSv2aNO7nun0sGxh9/iDuqluT2spD+A6+pIAZUJhR+kUW
         7+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231708; x=1772836508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOsPp0sNuMqBvgksLLC7w2ENUHuNEhH517t3YeRJRmc=;
        b=gsgdv9/WZF9+pek6x+3A0+0RxYzENUPgRHeehzhup87AFJ4FUNoDkDcPJcXu9AQahq
         8i4peu5a9Szg/XhiMvL3N1WePduxW3SWREq1nx//Ma3P9yhxh0WaMNdVcjDpyOwImlKu
         DYftJWeCKPvMtQZEhVd6NrG4UYrTBzZFAYa6aPEXBqNDuKEdG2kIFoMZ3IeqfPHtnjV7
         jDiNh9Bc5ispdayu9bL6tTCEQuJpg15LtGHdAGFORS2+lpr4+KiteO6Pxjc901m99yce
         8Vker5a8Q13A4OiC/Pef1RBoBOkKk6aNO/IiRvuUrXf9poeUrR5RcO1pL4YoTsV3QmSm
         2ipg==
X-Forwarded-Encrypted: i=1; AJvYcCWmTpSMtYnCu+aHY1pHHx7mkCq1ZOaCxejdKKS1QaKRw4MTEAe2FmWqK/7fL8jNZZWE/jDR5qfpqNPz@lists.infradead.org
X-Gm-Message-State: AOJu0YyRNpbHcvWNOeEfc2fozKeMmimIJzivXwhCLBNj9JJA8x5+hIRh
	1Kvt2Fb8X29cdZ6h9nT94TsEU039o6UpQnMnD4Uf5TbcP6HN59PUnSsjESLW/X0BFOzGb2zM1dI
	u2krDPWvWK9tRSofYb7wahWi39dk0KgxF89+viIr0BqFtde9ATXxL
X-Gm-Gg: ATEYQzxfeDVzhzZ6mEN1zhzofQwiYcJ30MhlzmDMszBy9SQ81V3nWJGyyhhXXpjVrS6
	3RmIZrYvJV+tFZJUQtS7HXB8yDeyc/PXZDBvwwFBvaBiPNwrqlZ3PCa3nJDcYURLEDbq2MeRKc5
	Lf64D5Oyc27cxQrIlWDTF0mACyXQYa2VIe42xJYC130MvQ1mCMWqhW+BkhXBOYp+IsytygjkLTb
	YtssWSzeRwF1d/70Qe/A8s9D/mfXz9/B1Wvvyrscs2wqGT5O4VC8u/gRlAFZ430zC6w3Aan0yuC
	lOOBtYWwiLheEpddWrkZOZ9DiAHAQZvuDBVHnYDhUxmRy8thQgew9gRHqN/Kw4xM8rym8chZk/e
	ZFhvUrljv2gW+//mHg2MPS6wrtBjsjkXN90dtJhk=
X-Received: by 2002:a05:6122:6217:b0:566:3608:f8db with SMTP id 71dfb90a1353d-56aa0a96612mr1226798e0c.2.1772231708429;
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56a91e287fbsm859123e0c.3.2026.02.27.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B6F3C340B96;
	Fri, 27 Feb 2026 15:35:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B285EE420D8; Fri, 27 Feb 2026 15:35:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/5] io_uring: add REQ_F_IOPOLL
Date: Fri, 27 Feb 2026 15:34:59 -0700
Message-ID: <20260227223504.1162421-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227223504.1162421-1-csander@purestorage.com>
References: <20260227223504.1162421-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_223511_354576_BA1915B5 
X-CRM114-Status: GOOD (  27.53  )
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

A subsequent commit will allow uring_cmds to commands that don't
implement ->uring_cmd_iopoll() to be issued to IORING_SETUP_IOPOLL
io_urings. This means the ctx's IORING_SETUP_IOPOLL flag isn't
sufficient to determine whether a given request needs to be iopolled.
Introduce a request flag REQ_F_IOPOLL set in ->issue() if a request
needs to be iopolled to completion. Set the flag in io_rw_init_file()
and io_uring_cmd() for requests issued to IORING_SETUP_IOPOLL ctxs. Use
the request flag instead of IORING_SETUP_IOPOLL in places dealing with a
specific request.

A future possibility would be to add an option to enable/disable iopoll
in the io_uring SQE instead of determining it from IORING_SETUP_IOPOLL.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/io_uring_types.h |  3 +++
 io_uring/io_uring.c            |  9 ++++-----
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  5 +++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..d74b2a8c7305 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -541,10 +541,11 @@ enum {
 	REQ_F_BUFFERS_COMMIT_BIT,
 	REQ_F_BUF_NODE_BIT,
 	REQ_F_HAS_METADATA_BIT,
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
+	REQ_F_IOPOLL_BIT,
 
 	/* not a real bit, just to check we're not overflowing the space */
 	__REQ_F_LAST_BIT,
 };
 
@@ -632,10 +633,12 @@ enum {
 	 * For SEND_ZC, whether to import buffers (i.e. the first issue).
 	 */
 	REQ_F_IMPORT_BUFFER	= IO_REQ_FLAG(REQ_F_IMPORT_BUFFER_BIT),
 	/* ->sqe_copy() has been called, if necessary */
 	REQ_F_SQE_COPIED	= IO_REQ_FLAG(REQ_F_SQE_COPIED_BIT),
+	/* request must be iopolled to completion (set in ->issue()) */
+	REQ_F_IOPOLL		= IO_REQ_FLAG(REQ_F_IOPOLL_BIT),
 };
 
 struct io_tw_req {
 	struct io_kiocb *req;
 };
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index aa95703165f1..e7f392e962bd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -354,11 +354,10 @@ static struct io_kiocb *__io_prep_linked_timeout(struct io_kiocb *req)
 }
 
 static void io_prep_async_work(struct io_kiocb *req)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
-	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!(req->flags & REQ_F_CREDS)) {
 		req->flags |= REQ_F_CREDS;
 		req->creds = get_current_cred();
 	}
@@ -376,11 +375,11 @@ static void io_prep_async_work(struct io_kiocb *req)
 
 		/* don't serialize this request if the fs doesn't need it */
 		if (should_hash && (req->file->f_flags & O_DIRECT) &&
 		    (req->file->f_op->fop_flags & FOP_DIO_PARALLEL_WRITE))
 			should_hash = false;
-		if (should_hash || (ctx->flags & IORING_SETUP_IOPOLL))
+		if (should_hash || (req->flags & REQ_F_IOPOLL))
 			io_wq_hash_work(&req->work, file_inode(req->file));
 	} else if (!req->file || !S_ISBLK(file_inode(req->file)->i_mode)) {
 		if (def->unbound_nonreg_file)
 			atomic_or(IO_WQ_WORK_UNBOUND, &req->work.flags);
 	}
@@ -1417,11 +1416,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
 		ret = 0;
 
 		/* If the op doesn't have a file, we're not polling for it */
-		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
+		if ((req->flags & REQ_F_IOPOLL) && def->iopoll_queue)
 			io_iopoll_req_issued(req, issue_flags);
 	}
 	return ret;
 }
 
@@ -1433,11 +1432,11 @@ int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw)
 	int ret;
 
 	io_tw_lock(req->ctx, tw);
 
 	WARN_ON_ONCE(!req->file);
-	if (WARN_ON_ONCE(req->ctx->flags & IORING_SETUP_IOPOLL))
+	if (WARN_ON_ONCE(req->flags & REQ_F_IOPOLL))
 		return -EFAULT;
 
 	ret = __io_issue_sqe(req, issue_flags, &io_issue_defs[req->opcode]);
 
 	WARN_ON_ONCE(ret == IOU_ISSUE_SKIP_COMPLETE);
@@ -1531,11 +1530,11 @@ void io_wq_submit_work(struct io_wq_work *work)
 		 * We can get EAGAIN for iopolled IO even though we're
 		 * forcing a sync submission from here, since we can't
 		 * wait for request slots on the block side.
 		 */
 		if (!needs_poll) {
-			if (!(req->ctx->flags & IORING_SETUP_IOPOLL))
+			if (!(req->flags & REQ_F_IOPOLL))
 				break;
 			if (io_wq_worker_stopped())
 				break;
 			cond_resched();
 			continue;
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1a5f262734e8..3bdb9914e673 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -502,11 +502,11 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!S_ISBLK(mode) && !S_ISREG(mode))
 		return false;
 	if ((req->flags & REQ_F_NOWAIT) || (io_wq_current_is_worker() &&
-	    !(ctx->flags & IORING_SETUP_IOPOLL)))
+	    !(req->flags & REQ_F_IOPOLL)))
 		return false;
 	/*
 	 * If ref is dying, we might be running poll reap from the exit work.
 	 * Don't attempt to reissue from that path, just let it fail with
 	 * -EAGAIN.
@@ -638,11 +638,11 @@ static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 			ret = -EINTR;
 			break;
 		}
 	}
 
-	if (req->ctx->flags & IORING_SETUP_IOPOLL)
+	if (req->flags & REQ_F_IOPOLL)
 		io_complete_rw_iopoll(&rw->kiocb, ret);
 	else
 		io_complete_rw(&rw->kiocb, ret);
 }
 
@@ -652,11 +652,11 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned final_ret = io_fixup_rw_res(req, ret);
 
 	if (ret >= 0 && req->flags & REQ_F_CUR_POS)
 		req->file->f_pos = rw->kiocb.ki_pos;
-	if (ret >= 0 && !(req->ctx->flags & IORING_SETUP_IOPOLL)) {
+	if (ret >= 0 && !(req->flags & REQ_F_IOPOLL)) {
 		u32 cflags = 0;
 
 		__io_complete_rw_common(req, ret);
 		/*
 		 * Safe to call io_end from here as we're inline
@@ -874,10 +874,11 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 		req->flags |= REQ_F_NOWAIT;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		if (!(kiocb->ki_flags & IOCB_DIRECT) || !file->f_op->iopoll)
 			return -EOPNOTSUPP;
+		req->flags |= REQ_F_IOPOLL;
 		kiocb->private = NULL;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once*/
@@ -961,11 +962,11 @@ static int __io_read(struct io_kiocb *req, struct io_br_sel *sel,
 	if (ret == -EAGAIN) {
 		/* If we can poll, just do that. */
 		if (io_file_can_poll(req))
 			return -EAGAIN;
 		/* IOPOLL retry should happen for io-wq threads */
-		if (!force_nonblock && !(req->ctx->flags & IORING_SETUP_IOPOLL))
+		if (!force_nonblock && !(req->flags & REQ_F_IOPOLL))
 			goto done;
 		/* no retry on NONBLOCK nor RWF_NOWAIT */
 		if (req->flags & REQ_F_NOWAIT)
 			goto done;
 		ret = 0;
@@ -1186,11 +1187,11 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	/* no retry on NONBLOCK nor RWF_NOWAIT */
 	if (ret2 == -EAGAIN && (req->flags & REQ_F_NOWAIT))
 		goto done;
 	if (!force_nonblock || ret2 != -EAGAIN) {
 		/* IOPOLL retry should happen for io-wq threads */
-		if (ret2 == -EAGAIN && (req->ctx->flags & IORING_SETUP_IOPOLL))
+		if (ret2 == -EAGAIN && (req->flags & REQ_F_IOPOLL))
 			goto ret_eagain;
 
 		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)) {
 			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
 						req->cqe.res, ret2);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ee7b49f47cb5..b651c63f6e20 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -108,11 +108,11 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 	 * Doing cancelations on IOPOLL requests are not supported. Both
 	 * because they can't get canceled in the block stack, but also
 	 * because iopoll completion data overlaps with the hash_node used
 	 * for tracking.
 	 */
-	if (ctx->flags & IORING_SETUP_IOPOLL)
+	if (req->flags & REQ_F_IOPOLL)
 		return;
 
 	if (!(cmd->flags & IORING_URING_CMD_CANCELABLE)) {
 		cmd->flags |= IORING_URING_CMD_CANCELABLE;
 		io_ring_submit_lock(ctx, issue_flags);
@@ -165,11 +165,11 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
 		io_req_set_cqe32_extra(req, res2, 0);
 	}
 	io_req_uring_cleanup(req, issue_flags);
-	if (req->ctx->flags & IORING_SETUP_IOPOLL) {
+	if (req->flags & REQ_F_IOPOLL) {
 		/* order with io_iopoll_req_issued() checking ->iopoll_complete */
 		smp_store_release(&req->iopoll_completed, 1);
 	} else if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
 		if (WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED))
 			return;
@@ -258,10 +258,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	if (io_is_compat(ctx))
 		issue_flags |= IO_URING_F_COMPAT;
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		if (!file->f_op->uring_cmd_iopoll)
 			return -EOPNOTSUPP;
+		req->flags |= REQ_F_IOPOLL;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once */
 			req->flags &= ~REQ_F_IOPOLL_STATE;
-- 
2.45.2


