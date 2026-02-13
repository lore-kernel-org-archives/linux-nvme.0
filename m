Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A038EF48C2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 03:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDAVuczYme2L/3ZbykT5XhXGRZz1afWAoembS53B+4k=; b=ct6aDTCFlcQsSmXy2TvpuqMwt7
	SUmaONm9Mc1R1XSgRYpPXhGj5GjVp3yQRAvqox34bkPDZuHcj8DLypdsylkdX9EtCWpctXAcjqtlV
	iC9yVKwMabsgUsGKg3FipGGFfegiuc1Kiqglp0aD8tg7ii+BUvMpnryOY8uO/Ucd+5D0wtT9XPI5Z
	6EF54gtZbLt2p1cUxxusopLcOHxyy6cqp+Uvxz3peoOtFvLwXLEMNVHzf0/7UYiWeiI3nzKKZSYV+
	PSwqtFdicShrb93LfHy1mSRpAqEx7qARoGP3Z8n2liC4CZTLLo4yZbg3x4L69QKcZGDpYeRPwi7Xq
	3BWEMWMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkP-00000002uGE-1npV;
	Fri, 13 Feb 2026 03:21:37 +0000
Received: from mail-yw1-x1164.google.com ([2607:f8b0:4864:20::1164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkI-00000002uE4-0lMg
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 03:21:32 +0000
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-79652789a0cso819767b3.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770952888; x=1771557688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDAVuczYme2L/3ZbykT5XhXGRZz1afWAoembS53B+4k=;
        b=Kkd62mMKidxDmP2hJKnNAEyWYjPXVLaoy+n9zmIPyLdGdaDGMwV3IjoAJkGtEAhJS3
         JSHwyMAoMGehzeRx8E16A9FezBWaZq5SLRF4g9o3CX71mo/xNwbC8RKU6N4ZWaeHcr3N
         yMtuYpfHNw/hu9wb3gSejwQNsHxDwPEreCn+Zi0O4J24lZe62lpAu5D1EFYOBFL0G2dH
         DSgSTv7EbIY9MZoQ5i896G+lk3StyJAejo61mgcNjCx4T6ef8CZtqbrJW/ve0u5YwTjl
         XoGstURYejOQpaQ/MRR0keXrGiGYP53oFShnqhquWzGK7CxXJDspIbvlBryErXZJZ/O6
         gjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952888; x=1771557688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDAVuczYme2L/3ZbykT5XhXGRZz1afWAoembS53B+4k=;
        b=hLBYdct6eq6nPThftfimzHIR78C2RkhOQ3cW13EYaNgU6d7xS1C96Ea/mDIOgbOkO/
         87MANscP0ogkzL/HB6QARiy1ce6sJMgetOhZDTugZelTKHNzFcIVCGLyYsXW8ou06mK7
         tqi/vuPiwE20MiuDDtiBQ+tRZDxMFH8783+LZOkcFKRpojF/K1c55kqNAG7/UtuUjZEP
         tbbaLSMK4Lt7k+wLjVbGta4pPSgdEnPUYQLn7KJvp/j4rDv9VDdVGgfO20HmEMapTG30
         XdyM9NNBxhw7tXAIttO/OvTthgXw7amf52dWs3bMm9vb9GFDtqS1bTYGXEUlMo0CoFg5
         qzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSW+9DHoy1+JnqYlzEaOLKn1jwaW8W5qSoaWawDLCTxsr3nv+/ymRU5kXYEXz6oxNBOT7jNlMg+axF@lists.infradead.org
X-Gm-Message-State: AOJu0YyN2vunMoLTNmAN4i+FECVcAvOxEoAswDmboxuJ2D6mUe8hQV+Q
	a76AUtvUbmrxp4T1NbO+P0eyZ8DR+uLVNFvIfNcBk5BSIyKQrXX7MhuWNXn52ww6268uOOE0GqF
	1V8Lf4UBGtrrFNLFnZ+tmluYACDLpEgOQDABu
X-Gm-Gg: AZuq6aLYd/D6o/zP0cJlDAgSo48P17r+i774XnFgdUgYaXs4UV8DNaFpLspOzVhHmmX
	WhipFmJROXm9dZIE00VpJWDMVD/bdv/zljEbXynwyJNVf0IVK511JIs/GWwcG848M/x35bZIk/L
	k8rXhIHQs/4xEhHqKM3zmydUR4XFpBoH0GjHIhy2P1iw9IzFDp6RhsTb6hsX5LNtiot3HWG8GNo
	aD8RntVx34ARLN0MZmGwcwQyfq+6Xwem+nYG+rntO+np67c8alTFOqEzoQ5Xvtm5aoiyS6rzF/o
	sAs37NLOft6XPvFMSI1JuzcEHI1mkcMTu+PxF2sraum2IkAE35h76aaeTYQgBlrta11rfU5qnJm
	3WWSLL0dznwsZ5rCI7gRoYYKP+hAux8UI94gjNlKaobMPceIcaYWvGw==
X-Received: by 2002:a05:690e:bcc:b0:64a:dafd:2d5b with SMTP id 956f58d0204a3-64c14d8e089mr1001606d50.3.1770952888480;
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64afc969f13sm637387d50.11.2026.02.12.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E0187342181;
	Thu, 12 Feb 2026 20:21:27 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA782E41DCC; Thu, 12 Feb 2026 20:21:27 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Thu, 12 Feb 2026 20:21:18 -0700
Message-ID: <20260213032119.1125331-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260213032119.1125331-1-csander@purestorage.com>
References: <20260213032119.1125331-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_192130_235300_7C5319D0 
X-CRM114-Status: GOOD (  21.11  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll(). For these
uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
don't insert the request into iopoll_list, and take the
io_req_complete_defer() or io_req_task_work_add() path in
__io_uring_cmd_done() instead of setting the iopoll_completed flag. Also
allow io_uring_cmd_mark_cancelable() to be called on these uring_cmds.
Assert that io_uring_cmd_mark_cancelable() is only called on
non-IORING_SETUP_IOPOLL io_urings or uring_cmds to files that don't
implement ->uring_cmd_iopoll().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c  |  4 +++-
 io_uring/uring_cmd.c | 11 +++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c45af82dda3d..4e68a5168894 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1417,11 +1417,13 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
 		ret = 0;
 
 		/* If the op doesn't have a file, we're not polling for it */
-		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
+		if ((req->ctx->flags & IORING_SETUP_IOPOLL) &&
+		    def->iopoll_queue && (!io_is_uring_cmd(req) ||
+					  req->file->f_op->uring_cmd_iopoll))
 			io_iopoll_req_issued(req, issue_flags);
 	}
 	return ret;
 }
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ee7b49f47cb5..8df52e8f1c1b 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -108,12 +108,12 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 	 * Doing cancelations on IOPOLL requests are not supported. Both
 	 * because they can't get canceled in the block stack, but also
 	 * because iopoll completion data overlaps with the hash_node used
 	 * for tracking.
 	 */
-	if (ctx->flags & IORING_SETUP_IOPOLL)
-		return;
+	WARN_ON_ONCE(ctx->flags & IORING_SETUP_IOPOLL &&
+		     req->file->f_op->uring_cmd_iopoll);
 
 	if (!(cmd->flags & IORING_URING_CMD_CANCELABLE)) {
 		cmd->flags |= IORING_URING_CMD_CANCELABLE;
 		io_ring_submit_lock(ctx, issue_flags);
 		hlist_add_head(&req->hash_node, &ctx->cancelable_uring_cmd);
@@ -165,11 +165,12 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
 		io_req_set_cqe32_extra(req, res2, 0);
 	}
 	io_req_uring_cleanup(req, issue_flags);
-	if (req->ctx->flags & IORING_SETUP_IOPOLL) {
+	if (req->ctx->flags & IORING_SETUP_IOPOLL &&
+	    req->file->f_op->uring_cmd_iopoll) {
 		/* order with io_iopoll_req_issued() checking ->iopoll_complete */
 		smp_store_release(&req->iopoll_completed, 1);
 	} else if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
 		if (WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED))
 			return;
@@ -255,13 +256,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED))
 		issue_flags |= IO_URING_F_CQE32;
 	if (io_is_compat(ctx))
 		issue_flags |= IO_URING_F_COMPAT;
-	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (!file->f_op->uring_cmd_iopoll)
-			return -EOPNOTSUPP;
+	if (ctx->flags & IORING_SETUP_IOPOLL && file->f_op->uring_cmd_iopoll) {
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once */
 			req->flags &= ~REQ_F_IOPOLL_STATE;
-- 
2.45.2


