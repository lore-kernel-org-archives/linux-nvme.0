Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7427BEB3624
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KD/WfRuGbaSn+6cq0PfA2+nK80LzEXM/LyfAsAFa1e0=; b=agTUdyWWSebScsD/eY72FntuoI
	x5aEAzZMqZ+wohsKQaF1AGXZRIAeMRwrlUnUgeNyuTOvwOoO025nZ7nx8DSc0zHnFlSXNv/fr22pv
	SJKx/r+9nDp+FB47OAY/ddSeV5v7Pgs36fZmwxz2KtVGy4WhHzkMqYeW28/Vlboyvz4wkLq4LhCVV
	eTqIGV0WEgiHrhYk6kBszP7M/5Z9OEnQ/N8Zq/qotnWDxgP2vZPVkuZp82e3VC3IqZ+9VNyFuuaVV
	IHt9yrvft2o36QjbuLDybleesv6+IeQBkOS9uXvYRD8OticzDnJOGFUKqyuT1Pc3jkKdrkxYq9RKr
	wzzWAssA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75C-0000000DaqZ-49cu;
	Mon, 02 Mar 2026 17:29:26 +0000
Received: from mail-qv1-xf68.google.com ([2607:f8b0:4864:20::f68])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx759-0000000Dand-3Ba3
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:25 +0000
Received: by mail-qv1-xf68.google.com with SMTP id 6a1803df08f44-899f50ab3f2so2812876d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472562; x=1773077362; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD/WfRuGbaSn+6cq0PfA2+nK80LzEXM/LyfAsAFa1e0=;
        b=a4mAwnDIN2QytvtTMOl1fGppCi5uRM1NLJIeS7ewqpQKYIISF2lauW6CFvSqKs65Sp
         heBCa+fhfnEY1wDVHmDIDX+4VY9W3oPDZOW7cWrVP1UTRA9B+OPZ1JDyQE8RYNDE3/L3
         egzhMvY/+A8/Kj28lpzwbWypgniI/o0PdRBLnsB5toQVvEt7k3SwQSU9FL/TNDrysUCW
         ns7hbgZm2P1wL9ldoOjA7y9HA5kW6tDg8fkAPus1adPDTn10eR846mV07EQMFggkOdYz
         TzTwR/UocDdFMRxB1n4Qy5CTmSLFb/T7mBrQz4eJDN0ZqqaUzVy6acYgwzxdxbljXjca
         NsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472562; x=1773077362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KD/WfRuGbaSn+6cq0PfA2+nK80LzEXM/LyfAsAFa1e0=;
        b=TbgWSnE3P5lX7johBoaZif2FRU+9iAogdUnAz8YYXh0y23Wv5D6cvg/8PoIHPu5W4P
         dsIPLTHoshkeJ2JUmi/Ww8KhWllgaA8+2OcYWP4CyE9MeTM+VNFGTziaQU9icCpWkq0c
         G8YJof1a7l7rD1gxYAatFEMDGX+fXxiNOhZkVghrhL3CbmkaSdMYbxqCi+BJzCmMz7pI
         NXEQ8p+lcKwxUeJO/MdzX3UChpJu/y70GFxVmwXr6DYUcSRZKDmiPG5/lgSjQ6REnyXS
         GRdmaV94Svgy+g9Wr0hUBiWwraJqqhANvbctf9wmWyAu8G7RKNI8Wi2wUEUUI5mT7xrC
         Ob4g==
X-Forwarded-Encrypted: i=1; AJvYcCWcUIwKqiMrE/hAOMpnC6D7kv3L/7WzlId3zl2TWJQ4ia6hj/jh7M1w5V6KX29+cRZkvHVj1yr423Gj@lists.infradead.org
X-Gm-Message-State: AOJu0Yxi7pUwR8D4jJ0DcMC2Y7w1N6cskG1S++b1r5xNliOrfIdQ2KsE
	2FkEkA5QG5SolPqAlQIVpiqBBqmXRssLMFb3CQdeSjrsSYKsOvVZm+nWWCo3ZWDHL6yGxXyBf8B
	CuP+WEhwvq9ABkiP0y/Xcf/RjSolvpFOW3yP0
X-Gm-Gg: ATEYQzxWt9DuMutXofv/iriBeIJlB5zI4JMk0gInxYMKHNSoMC0CHxH9rE+aL1kZiju
	5YDr/GcLgtgX1Rs+UpEKKBKPiiPgLu6u/U0DRiFDJZETp9+hJLWxGaonTlQlwFFnvaPFBx6Lizb
	UUEpljUq/inL2heG/h3lWcWjDhhNAXzAVn8dg73imeKmPgzKUWnOnTgA+SJxJt+lI6lOikuQ9IL
	+5QQ0vpB964XIDCCP2GaoKBZRwXQCq0NP2TEa1D2bHykpZI2Gk4U+XWTw8uViTyqz6nR6Xlbwot
	YLfrtjn1ZpLZPmyl2lMT2bTszNhSAgKXpdOmPGz/EaIqEY7+rCXKn+sNcxcyQ/ZPLp3pyw8ldf2
	SAuJEQs92b5IdaH5byUz70jmZysar+llf/tVFx93hXVmM8HTccmGnDA==
X-Received: by 2002:a0c:e006:0:b0:89a:591:15a9 with SMTP id 6a1803df08f44-89a05911899mr16836046d6.6.1772472562007;
        Mon, 02 Mar 2026 09:29:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899eda739e2sm6897186d6.21.2026.03.02.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6A64F340316;
	Mon,  2 Mar 2026 10:29:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 63FE1E41FBD; Mon,  2 Mar 2026 10:29:21 -0700 (MST)
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
Subject: [PATCH v5 1/5] io_uring: add REQ_F_IOPOLL
Date: Mon,  2 Mar 2026 10:29:10 -0700
Message-ID: <20260302172914.2488599-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092923_822260_F2E6D756 
X-CRM114-Status: GOOD (  28.01  )
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

A subsequent commit will allow uring_cmds to files that don't implement
->uring_cmd_iopoll() to be issued to IORING_SETUP_IOPOLL io_urings. This
means the ctx's IORING_SETUP_IOPOLL flag isn't sufficient to determine
whether a given request needs to be iopolled.

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


