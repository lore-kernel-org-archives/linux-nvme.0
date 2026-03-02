Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61173EB3625
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJYfmLiCMCsowVS6yyBvopz5p0Wjd6fpqKLBR9qiyiM=; b=bW6KN5fXOTzbX3UT+CvNq0be1F
	R0G9iErn56cAm5b4rcBW9pCjER4H9Kk0/nXDByzzSTuw3vYu1GZaSeaxpZuMcgk8BPLXxHvfMWz74
	f4L+nKyZ9oHwq68xvS22Oa7XeTjMjCMsb+qqVzH8xoi5jHwRDYD6vOpt1PkIJka0LsKxrefpE4xgF
	zpNUMPHe9r0uX9x9ydmpirDZ3Xg6GcgMaGsc0Sz4imLIJ1vmqFwLvOuhgpE8aicw+NcIY6wKhiLRL
	ftmBlgAtf0++uoYgnn/zYdA5vw8O6pcXbN53SXFvz7MKuQq3VFdqdeh9cfb2/+Gk6lJthFkTvn8/C
	A1GZdrUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75D-0000000DarO-3grC;
	Mon, 02 Mar 2026 17:29:27 +0000
Received: from mail-pl1-x663.google.com ([2607:f8b0:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75A-0000000Dao3-0Zuq
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:26 +0000
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-2a9633ef0d6so6806165ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472563; x=1773077363; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJYfmLiCMCsowVS6yyBvopz5p0Wjd6fpqKLBR9qiyiM=;
        b=O0/SJ0S9V7dvhi7v2nWxcz7HcxVos30Q46ZX4IcV4PgGT7OvM2JOIP9EFEKWj4UBJf
         pziFsSiTONBM3siwSiEYbO9gOEgu/U/GHRer7vDUzDWHal6Re2upwbOGub3aIGF5iewr
         orfd+E/D+n79eOWZJXgaHSrVal0IFfV1t8i9pJjn0uQRx1zs3TPyL5dP0A+rst8vVu3t
         VGJc24jkxXvvXIAvymuef0NAE4I/ZO4ng/muCAundZqL0oJ2r5k5lGB2FxDeCgKcxEqW
         FyR+EnnoZsVii3xbJCTmn+R00n6hMr80qyg1CHqnkq29mSvIroQvyiF9x4TZwXJLRK/+
         AaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472563; x=1773077363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJYfmLiCMCsowVS6yyBvopz5p0Wjd6fpqKLBR9qiyiM=;
        b=qOLmGb7fpXsdeB4Z+8IuatKEJUX9vQfggNwuo/0Qnqv+jPaoDg41ow1iD9EZPvMXM+
         vgaxOwY9jEJwD0T4j2mWHc2dGcksr/RqNBJv79A7Pe2bZkJ25Tmt3RonZWCKJJRWj5vf
         ElatGnhDOT580rzEwyh4pU6PZ4RqsmswECmt5J36RBmsWOnx3ZJIKQAJzyxQcuR/8hSo
         sVPJ2vtowMYRcfBl1sdZVEPPrj4KjMajIitdftFCPXGGzGokWoePF6ch0amJdJFb2Fy6
         X7x1ZOviFzUl/nl1tO/GX6ALtVWFIB8u0NnDeqisFxhrUHCrEvZvWoj15wwgTcqdAEfL
         peaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWRdc7i3LxVhRzf4Px2DeSg57PcEpC9QkBnmBkHsbADwQNxlynmBW7IyCMpHOQksiyL3FZXm4YmxCc@lists.infradead.org
X-Gm-Message-State: AOJu0YwUoGY+tWwypW5Hn58QvZwpm4aSs5fAPF34+DYWl3Mi/a8fruPP
	/+Tt3Lbbo6rPvUCbH2aokZGCwgeKx5aPUQDojYGCo90ZrEuwpmg8wn+1PD5sI9u4IGLkyHcwRyY
	CXnKa3tiRvAGP3J1kPjG73dxgv+dcNcsOrOS+
X-Gm-Gg: ATEYQzwwacCE09wHbMaMvRdGHHo6l4GVBlZBAoBrwOZ1sX26nbzcvXXxnLTXEj+xifx
	WEIHlkE5apTWQH3i/VlhY90ah9D4hw7COkcwf0lHdtNiBg53xMPFB+1Nnc5gAAY67XRJXkJT6TG
	wrzAD5TaE7BNJNtAz3LJhnm2yFpbs2TDsngjW0vguM7RDA3MeSBOTLUPmZVwkwhS8yDEVC00TBQ
	ASpy1W1H++OiYASkpmBlVDaNBYqLKnh+cs1TgpIogUmPVPGeZZkN47OEogHVTdY3qhk+KL5mDxZ
	uYkJRQf7Xe6JHSnNzzjKidSQgZXuFW0yWEFAC9MaWYmd2cVdl5RDwnbJYKjD02hiHyEjubTH2US
	da3irsH6LGXfUDYd3dZDAYD2prJGRKsp8JMtvIYPb6dJngfU1utO7Gg==
X-Received: by 2002:a17:90b:3c09:b0:359:8d95:4a57 with SMTP id 98e67ed59e1d1-3598d954d03mr2682124a91.6.1772472563024;
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3597c40a81asm921671a91.3.2026.03.02.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F0454340506;
	Mon,  2 Mar 2026 10:29:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EDAC2E41FBD; Mon,  2 Mar 2026 10:29:21 -0700 (MST)
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
Subject: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
Date: Mon,  2 Mar 2026 10:29:12 -0700
Message-ID: <20260302172914.2488599-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092924_175619_9E4C38DA 
X-CRM114-Status: GOOD (  18.01  )
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

A subsequent commit will allow uring_cmds that don't use iopoll on
IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
setting the iopoll_completed flag for a request in iopoll_list or going
through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
io_iopoll_check() loop currently only counts completions posted in
io_do_iopoll() when determining whether the min_events threshold has
been met. It also exits early if there are any existing CQEs before
polling, or if any CQEs are posted while running task work. CQEs posted
via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
against min_events.

Explicitly check the available CQEs in each io_iopoll_check() loop
iteration to account for CQEs posted in any fashion.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 46f39831d27c..b4625695bb3a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 		io_move_task_work_from_local(ctx);
 }
 
 static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
 {
-	unsigned int nr_events = 0;
 	unsigned long check_cq;
 
 	min_events = min(min_events, ctx->cq_entries);
 
 	lockdep_assert_held(&ctx->uring_lock);
@@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
 		 * the poll to the issued list. Otherwise we can spin here
 		 * forever, while the workqueue is stuck trying to acquire the
 		 * very same mutex.
 		 */
 		if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
-			u32 tail = ctx->cached_cq_tail;
-
 			(void) io_run_local_work_locked(ctx, min_events);
 
 			if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
 				mutex_unlock(&ctx->uring_lock);
 				io_run_task_work();
 				mutex_lock(&ctx->uring_lock);
 			}
 			/* some requests don't go through iopoll_list */
-			if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
+			if (list_empty(&ctx->iopoll_list))
 				break;
 		}
 		ret = io_do_iopoll(ctx, !min_events);
 		if (unlikely(ret < 0))
 			return ret;
 
 		if (task_sigpending(current))
 			return -EINTR;
 		if (need_resched())
 			break;
-
-		nr_events += ret;
-	} while (nr_events < min_events);
+	} while (io_cqring_events(ctx) < min_events);
 
 	return 0;
 }
 
 void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw)
-- 
2.45.2


