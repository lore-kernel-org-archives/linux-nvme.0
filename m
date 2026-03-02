Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9CAEB3626
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=; b=esRX4nwfpBTcgNu3Bd/sthzAdw
	xd3eRt60lz67PNYccoVOAzyAdskUavgGltjteninA8kJTndTYDW1Yk7jCgnSCB1Cap2g5Hh4Sy7OE
	dA86xF0qelqc+5HUt1IqpYd/w1F+9cylbZNgeCf/iOiZROVYole502z9eKzwZMyHGVCeo7tHvJfrY
	ZfIzLrXNCfAl+3ZQ8dSc4UKKJrLauL6404nSa87dmBPksXefifL4GAIrW56QZT9y5QRWxUTVT+q8T
	P9lY8moUi3SgnyDJcVJI5oblwextfu4To6d0/OStH+18Vi/5TBpUE/SK6qvlVadJJUGn3/MTewXCL
	8jmV/t8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75E-0000000Darh-0kAv;
	Mon, 02 Mar 2026 17:29:28 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75A-0000000Daox-277i
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:26 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-c70c38515d3so412776a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472563; x=1773077363; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=;
        b=VrGT+OMCEJMM+ypc2ZAShABOeuboDEZM0V0uQM4I11FNbe6K6Zu9iefOowROcUQSno
         +/6JP8Lm2VuVpJoWM8peot38cfx21XL59CdYz33V2Y03N5WLckai2rAWV++gjdKGPL48
         5uC1nhoLHTS0zdOQzg7ThS/PbSV9IveZUbckv6AXieNP0sEoJVBT2vowYagJFRuQRk7W
         LuxS9t5AzSxUxuyS0XI7B+rMI93r0i/F3W+zYZ6L8vAkO+6weTgTo1a3qqwoYCf7xtih
         nLseTIeYpvAKO5KDT9mDidARo6iWlgG3DsLlJwyxCno49Ge7UtSawttPwkUbnT4qvzCO
         cMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472563; x=1773077363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=;
        b=Q3d/fJzYnRIzVbhN3Yu7E7ecamy5dYWKAPisIZ/EN3sNBE4MHaJGQhPz5YdR+vdFn9
         f+Wqpp0I0dQVV+yqwwOvz7bbLl3/Fugadr7iqERybKBrHOAlem7/XRo3Ejn+/tKayLLY
         Kb+PGb992EHhCKDoZ32z89UuQMTuKlxEvFfpytkHzuVBaWOqGkwLL0vfJtEjUJTVTZwN
         3KhLy1AZtEmtum+pa7UJy/i+rvmPmFxh3DShTnhv7g8WTEphv3Yx9Qri9GN9wy8buhr0
         5Rk0GU88vtd5Ry6lWrSYh4A3oRazXRP+rscABhHRo5z13L61+4dgSt4NyXs0Y+UX0/Pn
         LSzg==
X-Forwarded-Encrypted: i=1; AJvYcCWM/unjWuUvp6PhcUe3GGtmb0eo6qUVA8GHYM1GX2IOVYOvT77kr6uo+g5WpNygkvsWud3SEU1QnUOb@lists.infradead.org
X-Gm-Message-State: AOJu0Yyeqc9xrhFRuY0fSwfeAgrCAa665SOBfOy+HmGoYYFxcaTEq8Dq
	Xa7GxmvYnn8lFv36MrPuSTK5pg9spFm8T/fWDeIEgdaSuGZ6H7ecWqsyb0S2Psz9lcbi2BPTAK7
	TSUKlcJC8MOobm9uBqd2a+KRJ83hBMsbH8IKRgw5gyoZqr8yBfMNR
X-Gm-Gg: ATEYQzwl8DGIFWxh18vlLxaJVplOabsQ3mIpAJqyXYEneQC6clGXsGt+4YGUrkKdbNW
	B8Cm8dUQCic00NwTHzZOdIoZ6yGmo9XTZyMML1YSRcVym2rRvNyeOcQ9zffNTge7cwCoxhDoLMt
	WzTnBsVd/hiqmGYYnuUlpJDwwKT8jgzKAcgWBDKAjgwZO1rN6iKpCxpXNL87IB0DClPiUrnSccs
	2qKqImPNIrq18eEE8EGMsGPDFz3y+a3ALM+oRNsf4YqF+Mu84aNI73Rfu0dibfimx7AhFm2wv7o
	zxM1FxDcvrZrLesm/522NMNnpJQIoVYPcjLcQxWNuNvwKgz9Y3MPnIUGKvZ1lLmsSjqk2w9+emz
	oYGqTsY6YKQOo5hBoJCxY3GLUg46IjqFS8z0+u58=
X-Received: by 2002:a17:90b:3949:b0:359:95ec:5a2f with SMTP id 98e67ed59e1d1-35995ec5c72mr1230896a91.6.1772472563254;
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359939787dasm287026a91.1.2026.03.02.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2FE0A340199;
	Mon,  2 Mar 2026 10:29:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2C3B1E41FBD; Mon,  2 Mar 2026 10:29:22 -0700 (MST)
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
Subject: [PATCH v5 4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Mon,  2 Mar 2026 10:29:13 -0700
Message-ID: <20260302172914.2488599-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092924_538829_91235E38 
X-CRM114-Status: GOOD (  16.06  )
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
that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll(). For these
uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
don't set REQ_F_IOPOLL, and don't set IO_URING_F_IOPOLL in issue_flags.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 io_uring/uring_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b651c63f6e20..7b25dcd9d05f 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -255,13 +255,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED))
 		issue_flags |= IO_URING_F_CQE32;
 	if (io_is_compat(ctx))
 		issue_flags |= IO_URING_F_COMPAT;
-	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (!file->f_op->uring_cmd_iopoll)
-			return -EOPNOTSUPP;
+	if (ctx->flags & IORING_SETUP_IOPOLL && file->f_op->uring_cmd_iopoll) {
 		req->flags |= REQ_F_IOPOLL;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once */
-- 
2.45.2


