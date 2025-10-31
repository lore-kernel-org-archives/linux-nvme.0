Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCCDCCFA03
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=; b=0psqkjZaZx95id6YUsvDMDYfqr
	73oyzvfRkJ/TylEGg5zG1IknzWRDsga4yvI13hEzH4rdBjmmSHQ8ehTLCaAEG/VIK+86agnHMDuFD
	uixzeqQ7pLG3jYHxPSEiCEH2TCT3u10CRLY9vLV7TZIY1+Jq/e22y0kHSAal9/MByDfCOtHgPtNFS
	imaST14Ljf13loCn/6c79qVeBK+xkpG9gAuqKB16wkgUNGycf56hQviSMHDw5mcWnYooHo5FGD4Cs
	M3OwK7/cY357KLs8qzDkDW8ch+QVqQNtMMolspam9MUn1t0LRcOyyJoDYSnPP5UeeiOUG7IQY+Bz8
	1ARQJNaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvpb-00000006mPR-0mVq;
	Fri, 31 Oct 2025 20:34:43 +0000
Received: from mail-lj1-x262.google.com ([2a00:1450:4864:20::262])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvpX-00000006mNo-49bt
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 20:34:41 +0000
Received: by mail-lj1-x262.google.com with SMTP id 38308e7fff4ca-378cfae07efso3831621fa.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Oct 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942878; x=1762547678; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=ZPNucowZl4hB8gjnSpy0c0zgDcmL5uFwxPDy3br70LnnqAwB7Fr+2Tq5nBDzRNqpwh
         vgEMboqycBDkxAYSn9ClDfWZvEMFZo62hciW3mrBifVdYcaaEDExWaTYHmK7Nk4sV/ct
         Xx2Jf6lLP/fVjZ5MGXYLYzVS0q7LpVTrjCl9uDRO7XD53q5SXMwUUGXVQAB3MV4sQhCY
         pgZw58+Zj6kGNoKgTpx0vk0K89WMHEaZFZ3Mg0b5eKZMjqu8S3x8iuQleJEFrY1MgRb8
         gOmU8Aatv1jPeSBCq4AOJ5FMDXxvEuikDEOsjOyAqF4thJPnPRqC9aSg3dwQbOJRwrTS
         UYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942878; x=1762547678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=I+Fev6aXoVThOWi88ZAbIePdIiwEbIBCpmlD0yoLXlkaNv0BaK8gXF/7nTTaH7yhfk
         oi+/PyBJJ6bz598FQlYqrp7wwFYCJed1w5kgvG+SkTbBd7WYIEOvUN/Ue7/7EiN4k1f2
         bm/ngK3EdWUOm9WGWpLDDAYyPvPiNzn2D9p/Wqi4BvO58laYM/6+djWh+t4LsLEE+EGY
         QE98Ujx93Sr0TfZ3diydPTWfCuWyGYH75sYG/Pbldtd32HyY4Pim7ngq8hErJ9GuHNxW
         t/6iAZWsBP+VO7YWDf1JMpHqgQAF3PFyP3PNPjE5hUGAcJ/KENpSv83c2lelJF1HKlOp
         2Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCVLA0crMyc3hBGEpTzD4L+MPGbxrfyL1XEzrzpwgoD7CjX+Qv5e+w7gwXZ0/AsSEVroHjY9CsRd6JOv@lists.infradead.org
X-Gm-Message-State: AOJu0YyQXSWV7pbj9IG+3IwllaB9LQRSOntYPwPt7cPr+5YwpSNwWrF7
	Lb32aVykMdbvqGUJH4cHTwj27LsWgOvjEfkXOGQbuFdpNYO1JCmMo+NTVo2OpxWeP7EvN0qR8m7
	UOuoHTO3sQFa4NIbHbY3PNxbHCPmwUg+Y1i7LFJZ+EGltRklLK+be
X-Gm-Gg: ASbGncvE4eF03Jg7Ut3K+CexPT2qmr4xpaWhYlLteTWqg6aJoUihLf9GyYHLTooAp3I
	2ALmP7VWN1EsBzgu0loBMyyoxoiDp6Kr7xNnYmsdyjY+jfyY76KmtOXv1l4+5JKR1HcN9WKj4hg
	955xCdV9zpDcAeLx0mj9KjLiuPoD6W19Ul59+8tTTomJlkLv0YKQhaJQL5zzzOE3DmhC+tDm5Nd
	Sxzoasp18zDxnaopvrADb2F6jQ+P/L8nht94AOLEr2YXIJmuoFX5yAdkT8QjNeQVPfTrKtezcqy
	y+AxjEhpssvehJfj5ywht9+a76BqgC8lp6MVxwT6Tn8B6ws2ivbf/6rlmsKxq6dGt5bHEzc4f8i
	L4x5jLgHvujOY7dtE
X-Google-Smtp-Source: AGHT+IFkklfQMtwtYHctUmXUj84xAbmvWB5viNqygwZDDgD7B4MpJ/ProRXWufuferuOhixNh09lD4F7KOks
X-Received: by 2002:a05:6512:4025:b0:55f:6637:78f with SMTP id 2adb3069b0e04-5941d5539bdmr914999e87.9.1761942877597;
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f5b5c33sm282549e87.37.2025.10.31.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DFCEB341B91;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA9BEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/3] io_uring: only call io_should_terminate_tw() once for ctx
Date: Fri, 31 Oct 2025 14:34:28 -0600
Message-ID: <20251031203430.3886957-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_133440_041462_BBCAA6A8 
X-CRM114-Status: GOOD (  11.35  )
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

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93a1cc2bf383..4e6676ac4662 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -287,14 +287,13 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.45.2


