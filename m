Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vx5QSi8OG8I5TDDjDN/aJB31I8qaTz0i56lsAmojCc0=; b=MB3B6baSoC0K6Xemsun3P4hBmj
	Ll/FzfQsTWVVuvdFHndOfb7js/xzdgGiMD/hc9MkwW93T/sN7hbENx2Yx4ZpBn6HVaj3lxtUImCod
	bZD12yYzWmdLqzY+wJO8gXne47mDmv7waspCyLhnl1n6mnJVGSOGOF6dL3j539/l4jV4oli2cTH4L
	ENOtvVLmevGnnyKvYsyNeTfujIm3QE8VPqriHXdYKNA7X014Hqt1YkCOcmWeHG3XbwTkKrAE0IU5F
	QmRBEWp4WPpbR0Vs7ImP6rtZVxNtbJeRcAxqCXfQHmBwWPcUgMIACenUXg63GL5Iof3IDKnCqReYQ
	uPORmTCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2JH-005nLc-Mi; Thu, 29 Sep 2022 22:47:15 +0000
Received: from post.baikalelectronics.com ([213.79.110.86])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2JE-005nHq-IQ
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:47:14 +0000
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 07C17E0EB3;
	Fri, 30 Sep 2022 01:46:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=Vx5QSi8OG8I5TDDjDN/aJB31I8qaTz0i56lsAmojCc0=; b=oC95j9nfLRMq
	6QQ26lh7oDVyH8p15LwfloY4UKNJWrwMY695jLiYtQT2qM9iAsm9PrC1Ld4v/70b
	bX96x+LTbE7c8ndZqS746wS5dzopkTolZj4/6owZasYtcBJn6oQJGtFfSRZvWlQW
	B06YUq+/qMhhLRRQh8G1ghmVqovzU7w=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id ECC23E0E6B;
	Fri, 30 Sep 2022 01:46:54 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:46:55 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Pavel Parkhomenko
	<Pavel.Parkhomenko@baikalelectronics.ru>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Date: Fri, 30 Sep 2022 01:46:46 +0300
Message-ID: <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_154713_180790_65F0D17C 
X-CRM114-Status: GOOD (  13.90  )
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

Inability to allocate a buffer is a critical error which shouldn't be
tolerated since most likely the rest of the driver won't work correctly.
Thus instead of returning the zero status let's return the -ENOMEM error
if the nvme_hwmon_data structure instance couldn't be created.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- New patch
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d712920..1afb24a64145 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		return -ENOMEM;
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
-- 
2.37.3



