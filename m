Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45EEECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N50pGNb7ZENTswylOsSk6CnjwfuXLAkGRJ5pZlDf4q4=; b=cr7+knjonOixr7WMk9X8IhbRpN
	xbdJfvE0TCILp2R4LPtIxY6VkVASDApQ5eiH7oQuK09EvsqFlRZ7PnHoMdHDt5SEKGVG9nQPO3rHV
	+1JgF1Ez8mXzusNhknx6NMYwLCV4xwPONGhE/u43pRcb37ocKkHOFzcO7hFh92Ykxq9Tr+HnhQt2/
	Ryy19OpTryNp8z/Xtm1QsnWd46kEF/axWVGzi1mORVnI3vONKMVtZBy/kxH6+n4uIMDPakK3b14AB
	8OewHMGPKsavkoaIg3hTbRzYzqqvoaI6LFZx9VhHg7RewNQdICVCgH9M9mm9mvQqPISigZTAekpK1
	eB09PPWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCWc-003arJ-3C; Mon, 05 Sep 2022 13:52:30 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9kE-000i5Z-OF
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 10:54:53 +0000
Received: by mail-wm1-f49.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5445859wmb.4
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 03:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=N50pGNb7ZENTswylOsSk6CnjwfuXLAkGRJ5pZlDf4q4=;
        b=kQ5FsjqkStWP7I1VraXBWXOC8VIEAJU9yzcXdM5UlDoPwd1ramICCjJMN8Es0AJ4ew
         g34eunbuJD+FYy7bIm00tv+c4cQWYH0gStVjwFlRPm0HFT1w5obvpS27Qd9L2YrR3iP4
         BL4nKaqkW8aZFOGoybuS61Pj55l4ACSivc7cQm1fjsQsikGPWzlBakyvXuUmBlzVbh35
         KJpTGqyWZ8Q34jg5fPeWpY/IpqVAvIVv1HGDr0/9dtfc/zkLNyi6GIK2D7ZlAs6NKuCe
         KLVeL3NqgDx+7xd0S3/QSKh4IhboM+dkxyJ3O4IxwPl1Bkv10ok3+4wPdmceh6lKs/Rg
         n7WQ==
X-Gm-Message-State: ACgBeo2ymuAow5GVvClNBRGnfrGTtcYIQ6P8ANRMMk3sFfSipgIBCHGi
	bmHGvIdUbZQ5KcN1ySRHOzc+MbTZHAs=
X-Google-Smtp-Source: AA6agR4al1ML/7qChFbZ29m8+1DEwgRgY5x9vBWOviBZpAZhOK3cyZAocXunKCaN7W/dalh1QsJnjQ==
X-Received: by 2002:a05:600c:3ba0:b0:3a5:b73a:8773 with SMTP id n32-20020a05600c3ba000b003a5b73a8773mr10215025wms.64.1662375259706;
        Mon, 05 Sep 2022 03:54:19 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002254b912727sm8408855wrt.26.2022.09.05.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:54:19 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: Fix UAF when detecting digest errors
Date: Mon,  5 Sep 2022 13:54:17 +0300
Message-Id: <20220905105417.1241304-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_035451_276501_5201046E 
X-CRM114-Status: GOOD (  13.91  )
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

We should also bail from the io_work loop when we
set rd_enabled to true, so we don't attempt to read
data from the socket when the tcp stream is already
out-of-sync or corrupted.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..54b4e8a7fe42 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1229,7 +1229,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
-		if (!pending)
+		if (!pending || !queue->rd_enabled)
 			return;
 
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
-- 
2.34.1


