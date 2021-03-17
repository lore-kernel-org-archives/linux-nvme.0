Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F470C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC0064F26
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0064F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b8QpRVvNw0L8lacDKbQ6Sz+bG+quVKSiAFNL3V4NtxE=; b=j65C27AVULkAredXS3hwxk6XE
	TgcBR5kkAU/EH3t3xY9mLBXFUBhJJ2PuQuASDxpE1T85pV8sVOb4vFGSN06aAaeII5MwzZ0HH9U5P
	DTPjdqQ1R1ymiI9HYeommaIjNyMkM3p/Tolz4m3PN75l12dlVwlRpynNm/hcuYlNnDgx2/GvgOoXg
	zDako5X+ixXddyG8YMD6ooKC0Vc1ShvEzhBViMUZ0/lrlbADrFVWZ0JokQcdjVgbZv7jBVmxbO51n
	PYaR2P3ibrXeNNMuMMP/uxgBOrRjjjXjDWdTmhfGe2l986293Z/Xi8DbPnazahjwR3E8dCJPzmy6v
	rmJMnK+Xg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeNn-004087-Sr; Wed, 17 Mar 2021 22:11:16 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeN9-004025-4I
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:37 +0000
Received: by mail-io1-xd2d.google.com with SMTP id f19so191068ion.3
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mlCtvo7lnB0iAIDh/6KjoQhNocbRJDB6XHzCDEgRB0w=;
 b=fU9Nrq8cIE72vpfIlhgUuwx9MC0tESqrlAxAXSLPJgynmr3bCkNd8noZEn94+qHmrX
 g9AgcaaORwbWIS0kcNkXrTc6AM0vhSPmg9j/xv/ekA70ETtb+okKP8gD94Lixdx0bKcU
 rHGbPs3ccBKYi9QEQYVJ+FAqjruZeQBnOqxu3s77F3xzDRy0mMwJiNUt3XF2wjQYp6Pf
 dwvN5wJtgp14rHR4Et6TZvIBYLDIdWxOKKD+1vn+NcpZ6n/Gvok0gKLImDMEmEgOYdm8
 grZoiVXPV6UBakadT2c03nlEV9U7y+6WmLrIZU9CuGtCjYZIxnXje8Y/71HkQsBokAP4
 docw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mlCtvo7lnB0iAIDh/6KjoQhNocbRJDB6XHzCDEgRB0w=;
 b=s6kyGZMRskZ/2TmgbYXcPsfb9eU7zPxc3Bc3IPZxPnl8dl9UllslHeMyBj0Tl6Kt7D
 9aAurtjRPZIfka61NdeG//g5Nwx0xsK5AJZ33/y0jIzl01KzM0PRE+QEqbXxmOQEWwlX
 x8h3mSd0PdnV471hAoOA2ndRlz/2i38zhoEuT/JWrDoOegZ7joMY8qFoJtjONTmizTke
 TiuFcj23gA3J84Yl3rRL2Df1pzmYtO+Vf41w2j2Fd2PJK5bDUXFwjE9nDp3pV/DgEEvB
 DPHU//k4Q8BOZH0LdA7HnXUiSkadAKSU6/1+Wm7MmiZGnrt+vG1ykAAHxIp6T9vDFYQ1
 BJLg==
X-Gm-Message-State: AOAM532PFX1Ng2604At8UB6w91ZMthHSyaOz1uBji8phQPvQU64gx8lo
 VceVZCd5fxzkDhg7VC/b4dMG4Q==
X-Google-Smtp-Source: ABdhPJzrqcljJAwZRk9AlgC4IvsN9M92EA+nzgGjKYMBnJK3aj5MHuhLqgSE3epnUfPK5gkWJtwUZg==
X-Received: by 2002:a6b:3c1a:: with SMTP id k26mr8272711iob.113.1616019033900; 
 Wed, 17 Mar 2021 15:10:33 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] io_uring: add infrastructure around io_uring_cmd_sqe
 issue type
Date: Wed, 17 Mar 2021 16:10:21 -0600
Message-Id: <20210317221027.366780-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221035_453980_8F8ECFD7 
X-CRM114-Status: GOOD (  18.92  )
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

Define an io_uring_cmd_sqe struct that passthrough commands can use,
and define an array that has offset information for the two members
that we care about (user_data and personality). Then we can init the
two command types in basically the same way, just reading the user_data
and personality at the defined offsets for the command type.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 57 +++++++++++++++++++++++++++--------
 include/uapi/linux/io_uring.h | 10 ++++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 416e47832468..a4699b066172 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -824,6 +824,22 @@ struct io_defer_entry {
 	u32			seq;
 };
 
+struct sqe_offset {
+	unsigned char		user_data;
+	unsigned char		personality;
+};
+
+static struct sqe_offset sqe_offsets[] = {
+	{
+		.user_data	= offsetof(struct io_uring_sqe, user_data),
+		.personality	= offsetof(struct io_uring_sqe, personality)
+	},
+	{
+		.user_data	= offsetof(struct io_uring_cmd_sqe, user_data),
+		.personality	= offsetof(struct io_uring_cmd_sqe, personality)
+	}
+};
+
 struct io_op_def {
 	/* needs req->file assigned */
 	unsigned		needs_file : 1;
@@ -844,6 +860,8 @@ struct io_op_def {
 	unsigned		plug : 1;
 	/* size of async data needed, if any */
 	unsigned short		async_size;
+	/* offset definition for user_data/personality */
+	unsigned short		offsets;
 };
 
 static const struct io_op_def io_op_defs[] = {
@@ -988,6 +1006,9 @@ static const struct io_op_def io_op_defs[] = {
 	},
 	[IORING_OP_RENAMEAT] = {},
 	[IORING_OP_UNLINKAT] = {},
+	[IORING_OP_URING_CMD] = {
+		.offsets		= 1,
+	},
 };
 
 static bool io_disarm_next(struct io_kiocb *req);
@@ -6384,16 +6405,21 @@ static inline bool io_check_restriction(struct io_ring_ctx *ctx,
 }
 
 static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
-		       const struct io_uring_sqe *sqe)
+		       const struct io_uring_sqe_hdr *hdr)
 {
 	struct io_submit_state *state;
+	const struct io_op_def *def;
 	unsigned int sqe_flags;
+	const __u64 *uptr;
+	const __u16 *pptr;
 	int personality, ret = 0;
 
-	req->opcode = READ_ONCE(sqe->hdr.opcode);
+	req->opcode = READ_ONCE(hdr->opcode);
+	def = &io_op_defs[req->opcode];
 	/* same numerical values with corresponding REQ_F_*, safe to copy */
-	req->flags = sqe_flags = READ_ONCE(sqe->hdr.flags);
-	req->user_data = READ_ONCE(sqe->user_data);
+	req->flags = sqe_flags = READ_ONCE(hdr->flags);
+	uptr = (const void *) hdr + sqe_offsets[def->offsets].user_data;
+	req->user_data = READ_ONCE(*uptr);
 	req->async_data = NULL;
 	req->file = NULL;
 	req->ctx = ctx;
@@ -6419,11 +6445,11 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (unlikely(!io_check_restriction(ctx, req, sqe_flags)))
 		return -EACCES;
 
-	if ((sqe_flags & IOSQE_BUFFER_SELECT) &&
-	    !io_op_defs[req->opcode].buffer_select)
+	if ((sqe_flags & IOSQE_BUFFER_SELECT) && !def->buffer_select)
 		return -EOPNOTSUPP;
 
-	personality = READ_ONCE(sqe->personality);
+	pptr = (const void *) hdr + sqe_offsets[def->offsets].personality;
+	personality = READ_ONCE(*pptr);
 	if (personality) {
 		req->work.creds = xa_load(&ctx->personalities, personality);
 		if (!req->work.creds)
@@ -6436,17 +6462,15 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * Plug now if we have more than 1 IO left after this, and the target
 	 * is potentially a read/write to block based storage.
 	 */
-	if (!state->plug_started && state->ios_left > 1 &&
-	    io_op_defs[req->opcode].plug) {
+	if (!state->plug_started && state->ios_left > 1 && def->plug) {
 		blk_start_plug(&state->plug);
 		state->plug_started = true;
 	}
 
-	if (io_op_defs[req->opcode].needs_file) {
+	if (def->needs_file) {
 		bool fixed = req->flags & REQ_F_FIXED_FILE;
 
-		req->file = io_file_get(state, req, READ_ONCE(sqe->hdr.fd),
-					fixed);
+		req->file = io_file_get(state, req, READ_ONCE(hdr->fd), fixed);
 		if (unlikely(!req->file))
 			ret = -EBADF;
 	}
@@ -6461,7 +6485,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	struct io_submit_link *link = &ctx->submit_state.link;
 	int ret;
 
-	ret = io_init_req(ctx, req, sqe);
+	ret = io_init_req(ctx, req, &sqe->hdr);
 	if (unlikely(ret)) {
 fail_req:
 		io_req_complete_failed(req, ret);
@@ -9915,6 +9939,7 @@ static int __init io_uring_init(void)
 #define BUILD_BUG_SQE_ELEM(eoffset, etype, ename) \
 	__BUILD_BUG_VERIFY_ELEMENT(struct io_uring_sqe, eoffset, etype, ename)
 	BUILD_BUG_ON(sizeof(struct io_uring_sqe) != 64);
+	BUILD_BUG_ON(sizeof(struct io_uring_cmd_sqe) != 64);
 	BUILD_BUG_SQE_ELEM(0,  __u8,   hdr.opcode);
 	BUILD_BUG_SQE_ELEM(1,  __u8,   hdr.flags);
 	BUILD_BUG_SQE_ELEM(2,  __u16,  hdr.ioprio);
@@ -9943,6 +9968,12 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(40, __u16,  buf_index);
 	BUILD_BUG_SQE_ELEM(42, __u16,  personality);
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
+#define BUILD_BUG_SQEC_ELEM(eoffset, etype, ename) \
+	__BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
+	BUILD_BUG_SQEC_ELEM(8,				__u64,	user_data);
+	BUILD_BUG_SQEC_ELEM(18,				__u16,	personality);
+	BUILD_BUG_SQEC_ELEM(sqe_offsets[1].user_data,	__u64,	user_data);
+	BUILD_BUG_SQEC_ELEM(sqe_offsets[1].personality,	__u16,	personality);
 
 	BUILD_BUG_ON(ARRAY_SIZE(io_op_defs) != IORING_OP_LAST);
 	BUILD_BUG_ON(__REQ_F_LAST_BIT >= 8 * sizeof(int));
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 5609474ccd9f..165ac406f00b 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -74,6 +74,15 @@ struct io_uring_sqe {
 	};
 };
 
+struct io_uring_cmd_sqe {
+	struct io_uring_sqe_hdr	hdr;
+	__u64			user_data;
+	__u16			op;
+	__u16			personality;
+	__u32			len;
+	__u64			pdu[5];
+};
+
 enum {
 	IOSQE_FIXED_FILE_BIT,
 	IOSQE_IO_DRAIN_BIT,
@@ -148,6 +157,7 @@ enum {
 	IORING_OP_SHUTDOWN,
 	IORING_OP_RENAMEAT,
 	IORING_OP_UNLINKAT,
+	IORING_OP_URING_CMD,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
