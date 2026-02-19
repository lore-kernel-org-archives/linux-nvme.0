Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B467EE9A02C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EE7cGAhrUq0nrwHlvXRO9TAOek5hA0FaXj4t+R7Eq/M=; b=tpBIiKWlckeXpo94629eBkLAVU
	BheSkVw5FGaKiztUyKkZg4UuUZrb/LteweyN3p7JCbVe/qvgfzXK7P5xC7c9Izd0S2pTYHTnT2VLS
	ANrRS9U0ZYCR+isG/2S8txNASjCu93gBsjsmmz+mz5c06WjE6IYCDSBRaAukHuaYwcXJmVGdo4XCQ
	Ht9Y4ugLI4CW28whui3j3StH2VLkPsRC7B53uLPd0L0uR8R1F5fte9bh2q3rMAdREbrHpTiOEpRVZ
	wOhnTztdZSB+pg3yYcSrD9p0EmIwAvs1rzawDqh1c685ddmqDxYv9Zrt8DQKwBbVLhTf08DZZARhZ
	N0TZAKvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst54-0000000Ahbd-2KTj;
	Thu, 19 Feb 2026 01:43:50 +0000
Received: from mail-qt1-x864.google.com ([2607:f8b0:4864:20::864])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst50-0000000AhZZ-1J9Z
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 01:43:48 +0000
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-5032e59c8d3so371081cf.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771465425; x=1772070225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE7cGAhrUq0nrwHlvXRO9TAOek5hA0FaXj4t+R7Eq/M=;
        b=edeZBi2MJBQb5FhTn8uUHe0wrYxVwJPxSPjrBClGag2py+odHWGV0YDpzbNehSlojq
         Wt2iBRmmgyOp/QOqCtnYo+Zldzl8Oe3+8mrg+/O11/secVq4RjCyOiNUMXULdehniZCa
         yAzJpR52fim2eTju8NA1+cfWEHZhiTKRav8V/984/5DQi0biFJK20gSJeMDUn5KWVmjp
         eWeTL8ArMf9e+uI2lClL03x0kKkG2YR/ONC1Tq5+/40UVaBtXSmCjxAsjyxa3kPWKbtB
         lLzphxQ3nAYFYhgN/ZCiOksJLG+y0SJSTBFyy28PjAtQj6y6TgbRG/d/L33qOvQBGTTy
         YFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771465425; x=1772070225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EE7cGAhrUq0nrwHlvXRO9TAOek5hA0FaXj4t+R7Eq/M=;
        b=TBYiE38he113MO+si5qVldx0wHm1fV458A2AfICl1XdCSypq3WV0u10HLpuV82YkOz
         2iw4XNzhHXdmC8NSmqtgfv20GplSKBchTwhb+2Yyxos8mD7ZHlVg35It0Vi9wEUjHdL/
         5Eq/cC7+SQQ2/bW+VpdVAlrBkHqepIwpcLambY1YNc9E6TcYgqIsJP9XApuYt+vFtvtT
         JWZox8r7W56UYlZkPcYdZErue/8Ok1Jy6PNEI1HsPlDXSZWCTmfjumh+RG4p1UIN803K
         WxJ9GJUmMordwzJu69TDyXyxtrY9Mey1yRvoB6w4cY50shYqmdMizPGM1NqkOpyKxy4z
         JbAw==
X-Forwarded-Encrypted: i=1; AJvYcCUDM/NkHaw/DUQCJ4Kyhk/oDw1zCYKRAgwW8iNs+Gel5d0Wqvgoa0CoOCqSvySYuJTfSHSWxD/UCdeW@lists.infradead.org
X-Gm-Message-State: AOJu0YxLbil+PWEM1mHgK2rQGUATiddShgtLa9+hRNs2oOBia8Vg/5ru
	7ABMde/Xp+jkpjnQ9Rz/ePyjYFZ61WptBjeAfTLst5FxZCHi3tA8ON311y6PhyKfNsuZ0uccELC
	lvqQH26/MX4paSePx2SCftNkxHQ6/ZwPH+wL7y8tw31omlY9zWvNs
X-Gm-Gg: AZuq6aKzVwTacn8kdJOQTc0AzV4pEw8nJlVB5LS6VabNfYt2YkVpD8FHY5cmiK8RyHj
	1njNrwpmxgt0HHtsUZrLQiwEj4TOYqXKmDTCtpC7SBydZJdlhZWU3PwbbwQ0tVKLtq1wOLqBe1y
	kiy0J4oF6eMuS6U03YNM0UWBt1/Q2R1dwQ43qcymvj8I/D4CgMeUkc9N8SkmIwSxS1+tA2+KkxI
	xH0zB1XogsoeVagcTmXKM3ixMCZ+QN5Em/FwUF6L6nqQTTpdnUotJ9sK+s9KWPUxxjAtnCd/MxB
	sU6uBQe2Zrqkc/lT+PASfXd7VJfwBuAH7xBHUAwuY1jQV+0XhvHqmMSdy7I7wiUTWjHarMGpW3K
	YP5K0AhADmG+WDtuRcE4MuQb87A5pN99dsvm+C08=
X-Received: by 2002:a0c:f94d:0:b0:899:555c:cb2a with SMTP id 6a1803df08f44-899555ccc78mr42192476d6.3.1771465424856;
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cd37abfsm28345806d6.16.2026.02.18.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7602434076F;
	Wed, 18 Feb 2026 18:43:43 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 719CCE41D2F; Wed, 18 Feb 2026 18:43:43 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/4] io_uring: add REQ_F_IOPOLL
Date: Wed, 18 Feb 2026 18:43:32 -0700
Message-ID: <20260219014335.9061-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260219014335.9061-1-csander@purestorage.com>
References: <20260219014335.9061-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_174346_374415_DD9CF1E7 
X-CRM114-Status: GOOD (  27.86  )
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
---
 include/linux/io_uring_types.h |  3 +++
 io_uring/io_uring.c            |  9 ++++-----
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  5 +++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..4563e1fafdf0 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -541,10 +541,11 @@ enum {
 	REQ_F_BUFFERS_COMMIT_BIT,
 	REQ_F_BUF_NODE_BIT,
 	REQ_F_HAS_METADATA_BIT,
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
+	REW_F_IOPOLL_BIT,
 
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
+	REQ_F_IOPOLL		= IO_REQ_FLAG(REW_F_IOPOLL_BIT),
 };
 
 struct io_tw_req {
 	struct io_kiocb *req;
 };
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ccab8562d273..43059f6e10e0 100644
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


