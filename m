Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD77104891D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=; b=Qe7RbQ83etedsorrPnORkqwOxq
	hCL2xLmlmTngsNCrb/y6iOoEmecQzKzmtSZ1ql/FglJvYNb/9el8J0pDkKWcPQ/Op/3/YBKqKVNfM
	kw7W3E3OU606hVzvVdUWAvOPPAajASWELR+6NLT0o6ENNipRbuPXimBJvOc/pbdQa3It0xgEAG/VG
	ffWDdTfBfEN0jjkxuwGOL9KvnUu/H5djyuQtDUpQD/ro2E8D31swZ4GlLDWtvGdvKsDKlBnYtQLt+
	DJciY2wsy4nY3BAmTsoVnxfuIlRoNTBAKg7LD+LW1yWIwZCwwjld/MbE8Ik9czgfkUudirVZNRm/s
	rTkuTeSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QX-00000009Dmw-2bTx;
	Fri, 27 Feb 2026 22:35:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QV-00000009Dly-47Bm
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 22:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=; b=BJhxfL2dU77sExPOOipfvOtnsY
	ksDWchDqHExTkYbw4rkhP891VQTHqR8QFQBeSwXJTOD6sqLuKo47Ra8w9vRC7bWD8qEg7mPzb0jbT
	srkJ9cvOkx4KVgqSrU+qo582Kscse2dVm8JLso1IsHJM6uSPdREae2E7p8pjyUreEHnhaGrdKaHep
	7xm3M1vPKIXPJ6GVRXc6LArzattqVNvekH8cutfz33vmY9tF5q8YpTDCdM/W5HMpvOYHUoNK8KBc9
	umFDrPHqfMQk0+e3kO9Fi2QJ67NruN4O2auoQN6LTbyLarpWHzcgDlhgqRqq6KMjCnwM9K85IjuuH
	5sIOU7Og==;
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QQ-0000000E0gW-2gDW
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:13 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-2ad46422a5aso2661545ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231708; x=1772836508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=;
        b=K4Tz19+N7HM3wjdZP2TOEeUmR1ANAixbXiJUR9+Sm4cuFA2qXH19ETvp/npCS+0gWu
         V75BpQBTmQagBoQJ9nDl7Vv+UpYx4n+DAqaevVZEYERcssOHQ48ArQs5PeHaessVVu3E
         FqM7+gUtqR+n7jL06CXhYVrynJpeiZjLHah3D7sKQuYwzj7tytZ1DCwDgK0flyljqmVU
         c0QwNmWT889PJ8tads941WKbehtwE8hEM6CGQAEY7i73MA/ruH+9GRXpFvuFCDS7HQWA
         bdF5uizi82f9peXr5FfagriNthmuRzzuV6IsX0KWxOxD7/mvo1Q3mOksCmN4QjC3JY1J
         /NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231708; x=1772836508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVH9fXQsVA7juGOEz+1dE42o2vyEutyAkezbvq+KUlE=;
        b=jEwVKoraiiluhHHmUHYiecOC9Fpm4d305c9JWHV23/YVfP3HFY9WMAJG3xsj4vvQi7
         npZECXGXMoIrLWd/JehN5DVeSGXM0B1N44kZdjQIM0eNBcmgbaVo6fSRQ+DLwl2A4VXv
         llY6qldbtypImOPyJgJbXSEaDrY7E7UoDoq2vw+ZP4q1POemHQ+rP6goy0aoulwhX5Au
         O7QSotf1fxNTwv1RkddB6aLE8fqtgAvBUPoArULSNKzr2CYAvGzV2+B5wkV45r6EFik6
         2suwfMnzEkbezpvTO6NOT//bfpedImx+USwgfUD3IPXnKqsUvAQpU/5ecxQKBtLtBfHT
         dXEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9zQs0XSG0BXldl/6GwMAOJj41ydS4l5KgJ0Z7/eKhJ2KXohJiuW97VMt44XILyIAhGaAwAAliFV6s@lists.infradead.org
X-Gm-Message-State: AOJu0YzQo3T5pxv2bDpszvD2hDcLnsO6kjkpUXXCiQefnmqbC+bP2+TC
	uAYoFqSUdKeC1Tm5g+iqv0yCOljUMJayE1/tCyBNRLInLVlOQCffGFrcjQJrZbuRQqRrs/pY+ts
	1MbQOq8YtBKx+Uw6x/aba4D67D8R11alto+7F
X-Gm-Gg: ATEYQzyFNoyOe1HLWUnF2sSQfDAop+yB7qVd0qwtpnq6EApt8rySsp8Ujh2Z8sSbGRx
	xMnh4GTxyLr2oLMbQuPzW9tdROYNCZd4x777hw46Yo51o1YcsMcSCZGm9PemagG4mrzXD4eezOc
	jEIG/eg5P0lXh3+NEF/ik2xMU0Dyim8sNk/IS1oS5T12A/uDZWVWbWcfvy9vvYhN+PhJVXiYP/X
	4Yef/R2UHszC2kxjBmPdhfXB3WCUB/vNNQW5dFaqWNq7+DSYBMGmzfsFNfwiVh9Pep1D+bVZZlM
	fSNNuepMFcgX1qwu7cPF0wYMxSlXFv7ykBTnVOPEV2L9DTW1NEJKGXdKB+5BMfEA7hS4RprHuSX
	oydAChJyWrYM14Ms3c+rBLwltpafsNrKcPWJtem/WXY0Y/E/DEjgpEA==
X-Received: by 2002:a17:902:e847:b0:2a7:cbe3:a6e3 with SMTP id d9443c01a7336-2ae2e3e0d9bmr31622965ad.2.1772231708194;
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5eec86sm7901965ad.41.2026.02.27.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E9C1534179D;
	Fri, 27 Feb 2026 15:35:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E5700E420D8; Fri, 27 Feb 2026 15:35:06 -0700 (MST)
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
Subject: [PATCH v4 2/5] io_uring: remove iopoll_queue from struct io_issue_def
Date: Fri, 27 Feb 2026 15:35:00 -0700
Message-ID: <20260227223504.1162421-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227223504.1162421-1-csander@purestorage.com>
References: <20260227223504.1162421-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_223511_190054_08A43DBE 
X-CRM114-Status: GOOD (  17.58  )
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


