Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48827EB3624
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=; b=wwPAr0M6HJAIULyFInEW0dTCYf
	fidZQ05PDp+LDG45PEQNChLyGjsTaYCX4tufl8Wt17gS8wkQQ/PIIymIzsTkFlGXBKIQUwV1DokRW
	4QVewL9kRmYyr1heVQ2O6Nifdg0dp9fbamcpiBTrfjNBm5SlnXLyuyFc4YWQftbWlkZ2hVxndvXQ9
	HFUakBywmJZsZ17dahKVvPghhhypBDZE3Rl6On/rTF2ybS7c0nmli3KCcmSQKxP1jdzaDye8BBBrx
	C394YfWy0x1G+nyqGyTJwyPQflW0rbFu9XQ9f9AXLgciZC6eyNXhtJ7np6o43kNYQZwcqtXzEJHL+
	TEq3gwHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75D-0000000Daqr-2JaK;
	Mon, 02 Mar 2026 17:29:27 +0000
Received: from mail-pf1-x461.google.com ([2607:f8b0:4864:20::461])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx759-0000000Dane-3PVv
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:26 +0000
Received: by mail-pf1-x461.google.com with SMTP id d2e1a72fcca58-824a8039d9fso266384b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472563; x=1773077363; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=;
        b=SBrxgm+zglvjSt2//6euNprAjEiK9sWXGyal1mHNPnVheqcOSUvjCsgWtq22BEpNgV
         Qew0kmsmobNeFLUXdiKVXeRHPj85uKU6t5M1g7j5XOqXMrdXhoYeu7LMSMLq3x+dGIf/
         PtTh4ELpgsK/UfTVIzB8HxU17rPtghKl1SEVkKxT7TzU0BvDRa9RavMCUDapw2Xe1bAy
         /Gmpa9+FQafWMjZ41lD+/M1qGhnVO1zx5O8lKETEJjCRasOewE3z2NhW5tdhKje/E6hE
         qqvgskWaUrksGciym9k0ffQ3oRu6SHnYMzZXdzSoQG/wMX5PYoFbxa2ot87nVRzLNgYB
         OgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472563; x=1773077363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=;
        b=JD0Weqf/pdeqwIK1SiD3UKbvvvfsrLOtYdlSX3yRnx628n5uE+e/lbS4hKqwmLatnZ
         f0hub83k6WOhrFg/+85InECZ/8XQuq/8GUMRJj+Kl2q1npOUh+CsYGspk31LiUecSrJn
         v1D/mD1xRAmZmSw4MJmOeb/47b2RLWJ2+OVPbarz8muNBArQgX28fov6u0jfm/WMwgCg
         H/FQVSFosz/5cup0+z261r/4UbV2wdP2xTXSbEaBF0IRaB/EA2Z58tRQe3w0zlBOFmLA
         UEJcG8LvBiw0TBzsxXelKvBNLZL6TwrNhZDcK1UfVBqL2Yr11B3VPX5VHB7/aLUWn3rW
         FvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW83blW3dKYkELVdME0qNVANkpzwiq25gCVDpEdKUcq/VK2i8bVY8SNUW6eTCwzJMv3wVvlg1U/2jLf@lists.infradead.org
X-Gm-Message-State: AOJu0YyqSQ0PVcXRMQjQ3AG9feiCI+PKB2oOuQ8ShZ65B+0EM4cKGyC1
	e6VJXSeR2n17stc58WoqK6KusY4DzPqvuwl7yzqitJZ90GlExisR26DDg1sXSLRBLqqZRGzAdXs
	pebz0hR7DI13mmkm5BFvpLyXb4Lnqze2n31lv
X-Gm-Gg: ATEYQzygJK2lw5Y4smWGTJtnxcCPsshcOW5nyErZ//xoHXzHgMfuWk6j+AFM7K4FD+Q
	6Xk3jk8ZPYgjmmB0vCaGB7R8AgXauNZjVaHtV5jHdEzjBF9DNYKFRDX3mHdSY2bMlrr0EvMppRE
	gC1yKC2ZPnNYBQWYoW14z6M1ZxfyPcWbrO7GT0NaVZ4rhJqIwgK7GIlNWRTAU4dmODDDKN3elwG
	JEg/QgS1BMnwGgfd5PuXpqfVSE2Vorgwzdt/VAdKYXozT4bnGOwXi+x3S147vfm7hH2AoJot3tm
	ft3PLWDGakmRYcRROuYQ+Wk+pypdGK8KqIPjj8PMYtpdjiJTZFB8LvU1rwCLC8ji0Ufj9ptSjKZ
	4xJ2xI7WD/v9ogUSRxenVCla08bjSFyeDnVQllCBNQmM8e11wdat03A==
X-Received: by 2002:a17:902:ec84:b0:2ad:c1fa:ceee with SMTP id d9443c01a7336-2ae2e4fe432mr94384075ad.7.1772472562651;
        Mon, 02 Mar 2026 09:29:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb16ae40sm16178815ad.13.2026.03.02.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C2CED3404C4;
	Mon,  2 Mar 2026 10:29:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BED93E41FBD; Mon,  2 Mar 2026 10:29:21 -0700 (MST)
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
Subject: [PATCH v5 2/5] io_uring: remove iopoll_queue from struct io_issue_def
Date: Mon,  2 Mar 2026 10:29:11 -0700
Message-ID: <20260302172914.2488599-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092923_845645_C096BB07 
X-CRM114-Status: GOOD (  18.00  )
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
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 io_uring/io_uring.c |  3 +--
 io_uring/opdef.c    | 10 ----------
 io_uring/opdef.h    |  2 --
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e7f392e962bd..46f39831d27c 100644
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
index 645980fa4651..c3ef52b70811 100644
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


