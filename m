Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EEBC79F82
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rDZePV8Tf4LlgZ83QGlYfPnvzqZE1pVB/3dmeIjlld0=; b=CdRQLn3uDUxrOPCaVwQm8ovRTo
	dBzeRlkLwjXBPwPRldjtINrF6r6WEnpx5GyQU/CMGMD5FuXN0VWf3Zs7Qp65tpbqStaBtMuCT+KJM
	WCk/ZlDXioCRQKLzEUwik8GHHh2JyI9D6+RQJ73mQNT0xMNh5PrQXnooupispA5tbFugqo06eJFZU
	w0ed5X8x37XXj9wvCA9vIUrjQOJBy7e7n+0Muu7y5iIpviVAWN1wjxwYI1AeFk4HNfngn3hYiMMAy
	ay7bBjVnYGJg+WTxIjb1wBS87BW1kesmk553ls6gCj3YuX2hDKGRjUs9nevaBscNt9NONs4TRzEgn
	txJQGWXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3mcR-00000007z3k-30PW;
	Tue, 08 Sep 2026 03:35:35 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3mcJ-00000007z2x-1gOL
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 03:35:28 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2d715f4a587so57821185ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2026 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788838523; x=1789443323; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDZePV8Tf4LlgZ83QGlYfPnvzqZE1pVB/3dmeIjlld0=;
        b=JxgTIymQfqz1oeMxZe2n8Kw2nLcsnFHlYrtx6Ldaozw+znuOUElN7Mxfka0v7989qv
         1sf4EXDyM8cLenT/9b/03w0v4ybGCS2vvPznk2Y32gM0qev6x/p5qxJPygqlNdUxrDYr
         K+8TGvb9lS9GMOuYY/n5C3fISIjBW4qfwnJTPLh4ODFbupNmF7ejvvoayJuP7tkB+Nro
         FWyH1mnRm5k0T8OGaf/lChcfqOesPfxllP/hjHskTLdJGPaPYARdba4DjHwVfHdoqa4Q
         005MxZjIABxEyr++yuM+yDwExNtPwZFijUNLEkwrS93WHUTgjxRCuNUcEOocPfDZQbU0
         1x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788838523; x=1789443323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDZePV8Tf4LlgZ83QGlYfPnvzqZE1pVB/3dmeIjlld0=;
        b=UGY7TgNu9s6vtyGDScpOyOPrcrPLkbZxWln3gZSwBdWiSE7KIxKUqLze3Kf4eSNnRX
         QBynKzD9JC99v/hWj/QajqJMZISWSo2BCTSKawFzUiuL9xb6Pn62ZSRcYlBQ6Yfi7wjj
         shEx1IUyeolCD7WuABOKOPlSG+I3TgP8oQceuBBM5K0WV0rNhimgcCtTbNB2DxHjAqU/
         cYv647rW9U7HeXdDBms4T/Aefy6jo/wqFpo+5JpwTfftskZcV7wcpjT5atTOxOGQSjxv
         ys6z714O/9CQq6k4f2Frg54bv1du93h+100SBByFvy0NceN/WAOa3SuPll/v64hmNyg3
         b/5w==
X-Gm-Message-State: AFuF++mliCpOHtWo566tx/KvEUcB6YaiDlp0rlyleSgVP1K9srb57Phh
	uPNDHR1l6v9ppvI4yJySAEgkbfkVh/Nkx7cTcOVQTyQvotY2b0+6rWvVAdHGauVBQziHKLnpfEn
	zORV5/dg=
X-Gm-Gg: AYBFou2F8ixUQCSVpr/PMPJbYxFxg3DWxAC7v9J047579rY1cB7HfP8WqrlfbrgC9xE
	d+CaA42cELhXu9qZlM1WarrD1AZXYpGeeBeuwSP4fHqb4t9AFOnO8xFQJoYTFWoDjVscP4VHGwT
	EWMw1Pl0AxQPm02fN4Ebu+n8QWG6dxzUhXxAJD0mrjZOQIzFdj9xf2MdyBIP4F8U3eb9jzxAkan
	qJNmNCfjdnKbIKxdzdsvBNkTZvhAcMr2+/JNxj2R9vCiu57Qidw02vDqvJKJzUw2u8YGraCqceX
	qAvhOOARYEbwctxhqHdNyqOYZM+tBPRVkZrvrzm3MEwihW0DjNQC3vQ6BxRVlcfLixa48GfFrqH
	QmEG136AKYUGb1ktf58B9FHH7tvS3qhAkRG/g8jfqkGWAX3iCF5VVoaEYVrG+VJ4aJPVlj90fEr
	JINq2HUiILd0dKx9SZAkoNGf9ykpI5rLyC+p18yBqZmzftvNrzhiRTSVsi81PAcGPX
X-Received: by 2002:a17:903:4501:b0:2da:f7ad:cfea with SMTP id d9443c01a7336-2db126679c3mr266813215ad.8.1788838523165;
        Mon, 07 Sep 2026 20:35:23 -0700 (PDT)
Received: from localhost ([106.38.226.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c15besm52240325ad.61.2026.09.07.20.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:35:22 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	armenx.baloyan@intel.com,
	james.p.freyensee@intel.com,
	ming.l@ssi.samsung.com
Subject: [PATCH 1/2] nvmet: preserve device path on allocation failure.
Date: Tue,  8 Sep 2026 11:35:18 +0800
Message-Id: <20260908033519.2721210-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_203527_450829_E7DD9EE6 
X-CRM114-Status: GOOD (  11.79  )
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

nvmet_ns_device_path_store() frees the old path before allocating its
replacement, losing the existing configuration if allocation fails.
Allocate the new path before freeing the old one.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 413ee2d16d29..37998bb91408 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -534,6 +534,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	struct nvmet_subsys *subsys = ns->subsys;
 	size_t len;
 	int ret;
+	char *new_path = NULL;
 
 	mutex_lock(&subsys->lock);
 	ret = -EBUSY;
@@ -545,12 +546,14 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	if (!len)
 		goto out_unlock;
 
-	kfree(ns->device_path);
 	ret = -ENOMEM;
-	ns->device_path = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!ns->device_path)
+	new_path = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!new_path)
 		goto out_unlock;
 
+	kfree(ns->device_path);
+	ns->device_path = new_path;
+
 	mutex_unlock(&subsys->lock);
 	return count;
 
-- 
2.39.5


