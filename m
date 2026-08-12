Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A1AC5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LsN70vJV1KtQSRtRhVm0IvWc/lzlWCqm6SEoGjkKJBs=; b=02H0Cfj9ExwMxiF9s2V016uev8
	pdIxFBHIAv5ZebLWuvzNldC53hJAKn5AdP74k96RAiQhUOxWAsE/9J493jh4U3PGJvihjwV7EKY5E
	4MYzWAEMf0Rex4P2tybZyEWahr+V8NR1pKtKnosmgkT/9v+vNrjeXuPviQtAOtpv7sjMFMrmH2ftw
	/C2Fq5kVY1esRq63wFYHdykbaFUQtjwXt3WM4e1hBHL9y3hj2nOWjHs+EVCkGJ6k0pJk0ChW43DSy
	gUQWNJp/duWLdZwQIulx3zKR3ozP3DCnUnxPyvbBMJ+qSrCUoVyLcORkfuKIebWN0Bi/N834iPAQT
	7fQvXQpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu81B-0000000GBgA-0Xhd;
	Wed, 12 Aug 2026 12:25:13 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu818-0000000GBfO-1Z5Z
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 12:25:11 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so1140957a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537509; x=1787142309; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsN70vJV1KtQSRtRhVm0IvWc/lzlWCqm6SEoGjkKJBs=;
        b=HCqXqP/qOlo+CR+ThMgPrFqtWFLK7DPR1HhUfTMge1HR+oxr9Iq0R1ve6bLC8O6BUc
         8ctmYlZN2h/O9g3ZqmjMr+1Z8+0sap+ilbpWKcsgZZUVW3snQcyBcnJF4e4dkMdr3RPe
         4fAtOKEiGhUOHylZc1bQlOL6JAP09GzFsp53JT+gvW+uO9WG4AdiVmR5rzMEeFp3NGf2
         u7zxtBvujR5MXxE2ikGIOc0H0ntYJXrd5z0qEkCzAc+DGlVT8jh0649vgwkxNMR5D+yq
         9P3+l0F3S51C7XNzAgf/w/uT936nmfiBUYoUGP8xEQvqG5+1hJksyCPMUMbDd09cr4Sj
         /BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537509; x=1787142309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsN70vJV1KtQSRtRhVm0IvWc/lzlWCqm6SEoGjkKJBs=;
        b=SkFrTLAHo0WR6K/9FPPKVS58RGGNbPzrFCHJpXanvISFOcltSMrOI2qpnOd8AvEBw1
         LsX8bWXoqsQP8HhRLRzPjHA9bkxC/VpwFtepqLL70vG7hkaxIPQEI3q6EaY8yFuDnZww
         4mQJT7HhsM4gajH9FUQUT/VLuXnW0XoVU4t3n4OwJaZuiOBn+K2xuma1rRAInUFbjZMf
         xXCVOaZ1gYOn7teDm6jyUzEKtNxfKgclOGgO6qeZHIzp6jJc6VHV3HXbdSaIoiHaY8Yz
         LOMjrwJYWzrkdDdDkU+mVQsEovLwDZdDp3HvKIeWLWkx7jeK5dNGNu5cEBuRvYhBgf5L
         Bl+g==
X-Forwarded-Encrypted: i=1; AHgh+Rov6clc2wMcNRiE/xH+mGzAKbBh54aRDMidgR9BkbMXec2KCugmEzXWYt0qyoy4lLw33uTEeUCjXayR@lists.infradead.org
X-Gm-Message-State: AOJu0Ywi3kcVI3dAfolAMjjrxzL0RcH7LvbEkDgVJl382N/XqBIw2rm9
	op+/EDku2ncjZz5X2GUB6cjd/NI+oRdlMi/ixbwqtTSqTK4bAHuF3Gda
X-Gm-Gg: AR+sD12IiiSYBcbisAogs8XCIswnxn2kWqhIDwdUHVKVGJbFG3u8qYa2o4YQWtpy3z8
	MO4tGutsWXY314pfb8w1N9gp6uMBjKleMNjON/WyDqLHucW5aD4rPx1z/qtZxO2xt1Zq2GNPZsx
	4rcjEM+jBxdspjspb/fKRLRKhgk5++HjiT6bXSHRHHdrAwzha535lkQJqmzoIPvvb9vZUtC2J0Y
	G9sO4H7hJ16DUbrPTWmsV9HsSK4dkiLyRG9QKl5Ta9ni0IviFHlYdo2EcDCckvICYxo4ggy7Hnq
	1liXn3gihlTQCvlNGWwBtSUAJ0wNWqfmTmcZg7T3WgWgFiaXPnVxHva/116HXmIRLwU51xx8pG7
	pGhlvT5wImg2xANLMeLgPxRn8EFg/VMd8wykGwlG8ioNUs+mq1eAGlvT8oOj5HRWlfV6+On77qU
	zbdLqXdmQ2WJ8OQ5c2LmcwgW9uX0qOywt/jfRUgioAS28Fp+WKEb0O9rsqIgno
X-Received: by 2002:a17:90b:35cc:b0:38f:5828:a40c with SMTP id 98e67ed59e1d1-3930151d000mr5624859a91.10.1786537509394;
        Wed, 12 Aug 2026 05:25:09 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f933f600sm3419108a91.2.2026.08.12.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:25:08 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
Subject: [PATCH v2] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Wed, 12 Aug 2026 21:25:03 +0900
Message-ID: <20260812122503.196828-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_052510_483946_BAB9ED10 
X-CRM114-Status: GOOD (  14.89  )
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

nvmf_create_ctrl() frees opts when ->create_ctrl() returns an error, so
a transport must not free it on its own error paths.  nvme_fc_ctrl_free()
therefore only calls nvmf_free_options() while ctrl->ctrl.opts is still
set, and nvme_fc_init_ctrl() clears that pointer before its last put.

It only does so on the fail_ctrl: path.  When nvme_add_ctrl() fails,
nvme_fc_init_ctrl() jumps to out_put_ctrl: instead, so
nvme_fc_ctrl_free() still sees ctrl->ctrl.opts set and frees opts, and
nvmf_create_ctrl() frees it again.

Reproduced with nvme-fcloop and failslab by failing the kvasprintf() in
dev_set_name(), called from nvme_add_ctrl():

  BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190
   nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
   nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
  Freed by task 5534:
   nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
   nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605

Without KASAN, opts is freed twice.

nvme-tcp and nvme-rdma reach the same error path, but their free_ctrl
only frees opts once the controller is on the global list, so they are
not affected.

Move the clear down to out_put_ctrl:, which both error paths pass
through.  The same injection then returns -EIO without a report.

Fixes: 1a9e218195a5 ("nvme: split device add from initialization")
Cc: stable@vger.kernel.org
Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
Suggested-by: Keith Busch <kbusch@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
---
Changes since v1: move the existing clear from fail_ctrl: down to
out_put_ctrl: rather than adding a second one (Keith).  Re-tested by
sweeping fail-nth 1..200 over the connect write with fcloop and failslab,
which reaches both labels: unpatched reports at 17, this passes 200/200.

v1: https://lore.kernel.org/linux-nvme/20260811125310.165487-1-rihyeon8648@gmail.com/

 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..a35ed9c8c212 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3593,14 +3593,15 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	if (ctrl->ctrl.admin_tagset)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
 out_put_ctrl:
+	/* the caller frees opts when we return an error */
+	ctrl->ctrl.opts = NULL;
+
 	/* Remove core ctrl ref. */
 	nvme_put_ctrl(&ctrl->ctrl);
 

base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
-- 
2.43.0


