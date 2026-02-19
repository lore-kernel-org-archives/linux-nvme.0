Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A46BE9A055
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUz10elldwZxLQFWq4Cian3B5sXmfA0qWI2X4aUf25A=; b=oVs964T2S36J4fHyP6vtTNKfR+
	dRlO4JikWTh0RIEvibZ2hLAf9NkRrLNvolWo54SlTC738U8mvrjQOQGvqP0KAzLZoBOIRg0HuYKWh
	mZ5fTePteJ5NCxpBNy7jMBuQ9srscdd3Ofv4sI+Pi1nEG1ofHR4pqyctD+J10JsF5q8BjG6aiH0//
	2m8tYIOEq6jBhH3MrDGVtVahFTAHTawDb6ZHV9WWJKJfOghdWzmNiUKbBzLVjUQIo/x1ceQ1aBcv3
	JgLbJZtcxflxN7CZRbOfSxjxCYJaEK0uiyZBSqqcGjQvOcFazVtX4RSPBBGmsvODoGW8y8fZeezVe
	H4Xmqncg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k7-0000000Bh2F-0462;
	Thu, 19 Feb 2026 17:23:11 +0000
Received: from mail-pg1-x562.google.com ([2607:f8b0:4864:20::562])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k2-0000000Bgzz-36Dk
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 17:23:08 +0000
Received: by mail-pg1-x562.google.com with SMTP id 41be03b00d2f7-c6e8f82065eso164498a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771521786; x=1772126586; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUz10elldwZxLQFWq4Cian3B5sXmfA0qWI2X4aUf25A=;
        b=XHTZOtY83pR6ZVBGvUpMrPdsAN83CHu4Wx3SiZQ8Kiq1Vqy21rpHC0iGBV3aQqoUqL
         VgGZ/uCz8DVi7eiRFTQilnDearGdvX80K7LXTDLaiiIdtyFZpP5uL2c0WnvVaxY3sUa7
         7LXnTpcKsM1l7yEPBwxHibiGpdrzeyycRkbA25f8vfy6Q3UzwafkdFT8OMAGIAqxJMOQ
         SDuypZsac3RseonkY6yu5SGfdapOtGYTr199ZgU/12hXIWLO5WotCryD4RY4H55ZKd+H
         AoEXfKTegwOCuJBBhcaYlJuxr0hn51xzQFFPsF+pdnYIT2T5ntaPv34wV/CF/MphfCnv
         WRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521786; x=1772126586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUz10elldwZxLQFWq4Cian3B5sXmfA0qWI2X4aUf25A=;
        b=QvTGtsMsuZQjNSl2co80bsKt2mZbB+zKVlPFCjDE4hFI9qY7I6rphZTTv8roULuz/R
         96DGskyWs1QT5BPBIwjwypN85ErSgw/21//Gpm8HF+XnY3mCzyNh9ZKAejjub829ACun
         wCunFCymL74U15ceoxvlLZaDlNV3f6kHpMlaeumCgA+1FXg6wb7gVGADXumQYXXwDV06
         UsrAZ0Md2C/c7i+y0NGa86KF+UnSoWPABOUNfYO8BjA4D+3NQUEb08paPTE+WKiZD5LH
         gJbqXIcusBtjMWPpdMhRz43y8LrVvBD1DqF1/Qbt4JR6m21CkO8trjLr03t67yy5l9cC
         hqdA==
X-Forwarded-Encrypted: i=1; AJvYcCVepSqZRpEUkB9/1nE2UnjQbBFD1UUtGsWmOlWtlDgUyRoF3uPYWaaedfmu7eCDh80/mQOsCtR3vrjM@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7tLbld44xZFkMvgnrWgfk9kV5pwHqXj3uMqbLh5eQXAmB+MjO
	eOfwbhBFx1hnoP4YfS0mHsjbgKfpvQ7h74an2IlTtjrJa0mD9svZ42k3V+sFa1rbkwzjsa4uzx1
	8MvpwVq0FeXVCTsEMrY9DMbGre8FwnjwLYdKxTQV0u0/yQ23+wQNJ
X-Gm-Gg: AZuq6aKLJ2+ZKGHbccehsjpoKWgctQhfJpgVIjpXWq656WUyAROkEWqVryJ4XfVkczv
	nHTWihRex+8zQWLF7KzniAEITpyY6jvRdFlev1EwndZ3BPwo8AMNZyQA+yhFp158H1+DJjo0xCI
	0TXEpCfsHSyLK0n1hE6IP47rVdF4gSQRF2udLvC7ROXbMnaXZCiPVO7hoXyUfrWrTFcmPYqxISy
	l7HWgWfndpXvzosaSblymx9KS4h+jiF3mANGIZO+tUZw+GZSUdaq7K23msbytETFJMHS8pwHM1I
	g1PFGTdfIg8CD2wvQkWwJej5rheW1BPw2NdXiJYrXoDCc/kuI667wujHgT/bOQ39zw5KLR0k+wy
	SeC/CZirNe0gQTbVwVImTe745HAOBdNAOGwaSuzE=
X-Received: by 2002:a17:90b:2cc5:b0:356:1f2b:7e9b with SMTP id 98e67ed59e1d1-356a6e38413mr14529793a91.0.1771521785723;
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3589d81739csm95093a91.4.2026.02.19.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EA2563420F0;
	Thu, 19 Feb 2026 10:23:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E3B5AE41AE3; Thu, 19 Feb 2026 10:23:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/4] io_uring: remove iopoll_queue from struct io_issue_def
Date: Thu, 19 Feb 2026 10:22:25 -0700
Message-ID: <20260219172228.429479-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260219172228.429479-1-csander@purestorage.com>
References: <20260219172228.429479-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_092306_814434_CDC08119 
X-CRM114-Status: GOOD (  17.94  )
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

The opcode iopoll_queue flag is now redundant with REQ_F_IOPOLL. Only
io_{read,write}{,_fixed}() and io_uring_cmd() set the REQ_F_IOPOLL flag,
and the opcodes with these ->issue() implementations are precisely the
ones that set iopoll_queue. So don't bother checking the iopoll_queue
flag in io_issue_sqe(). Remove the unused flag from struct io_issue_def.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c |  3 +--
 io_uring/opdef.c    | 10 ----------
 io_uring/opdef.h    |  2 --
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 43059f6e10e0..2be46e11e1a7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1415,12 +1415,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
 		ret = 0;
 
-		/* If the op doesn't have a file, we're not polling for it */
-		if ((req->flags & REQ_F_IOPOLL) && def->iopoll_queue)
+		if (req->flags & REQ_F_IOPOLL)
 			io_iopoll_req_issued(req, issue_flags);
 	}
 	return ret;
 }
 
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 91a23baf415e..4b3fb19b0cde 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -65,11 +65,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.buffer_select		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.vectored		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_readv,
 		.issue			= io_read,
 	},
@@ -80,11 +79,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollout		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.vectored		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_writev,
 		.issue			= io_write,
 	},
@@ -100,11 +98,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollin			= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_read_fixed,
 		.issue			= io_read_fixed,
 	},
 	[IORING_OP_WRITE_FIXED] = {
@@ -114,11 +111,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollout		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_write_fixed,
 		.issue			= io_write_fixed,
 	},
 	[IORING_OP_POLL_ADD] = {
@@ -248,11 +244,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.buffer_select		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_read,
 		.issue			= io_read,
 	},
 	[IORING_OP_WRITE] = {
@@ -262,11 +257,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollout		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_write,
 		.issue			= io_write,
 	},
 	[IORING_OP_FADVISE] = {
@@ -421,11 +415,10 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_URING_CMD] = {
 		.buffer_select		= 1,
 		.needs_file		= 1,
 		.plug			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.async_size		= sizeof(struct io_async_cmd),
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
 	[IORING_OP_SEND_ZC] = {
@@ -554,11 +547,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollin			= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.vectored		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_readv_fixed,
 		.issue			= io_read,
 	},
@@ -569,11 +561,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.pollout		= 1,
 		.plug			= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.vectored		= 1,
 		.async_size		= sizeof(struct io_async_rw),
 		.prep			= io_prep_writev_fixed,
 		.issue			= io_write,
 	},
@@ -591,11 +582,10 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_URING_CMD128] = {
 		.buffer_select		= 1,
 		.needs_file		= 1,
 		.plug			= 1,
 		.iopoll			= 1,
-		.iopoll_queue		= 1,
 		.is_128			= 1,
 		.async_size		= sizeof(struct io_async_cmd),
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
diff --git a/io_uring/opdef.h b/io_uring/opdef.h
index faf3955dce8b..667f981e63b0 100644
--- a/io_uring/opdef.h
+++ b/io_uring/opdef.h
@@ -23,12 +23,10 @@ struct io_issue_def {
 	unsigned		pollin : 1;
 	unsigned		pollout : 1;
 	unsigned		poll_exclusive : 1;
 	/* skip auditing */
 	unsigned		audit_skip : 1;
-	/* have to be put into the iopoll list */
-	unsigned		iopoll_queue : 1;
 	/* vectored opcode, set if 1) vectored, and 2) handler needs to know */
 	unsigned		vectored : 1;
 	/* set to 1 if this opcode uses 128b sqes in a mixed sq */
 	unsigned		is_128 : 1;
 
-- 
2.45.2


