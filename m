Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D856C19F2D
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u/ZQmbcB/mx6PHOJTfRP999gmbiRlUx+aFKnkhhtx4g=; b=a1vvCgqCldPVot7o9PdTFIG5hj
	H5wQXAcNuSneOy4MZtBLC055kDyCRcd2wHOB+sSDpmbUG9CkUfdtWd8LpJ02O87yJKdOnyteOsE1/
	Z7C3Y8Bv0hijXOXT8taw2ggVk0pa71xYxookxY8N4Xvz0ZATjF9NhhLm9G81g86oIXUYC1Xqoulc7
	8ErD6zQ/SyBnmH9DI47M0CSioCwGjTeHvCmxg9ARFZu9Nkds6aoVGDersuwhH04tRSZCAOJywoPbr
	yqVZnPaRB+K6bMim6+DmO9XYVLc+C5W48cYjT9hUK4ccqdndXAkj6yur7vF0M4q2wlMhxwD8GgcL8
	oiBwU6dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKQCW-00HKMa-LI; Sat, 06 Aug 2022 20:15:12 +0000
Received: from smtp-11.smtpout.orange.fr ([80.12.242.11] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKQCR-00HKL5-6T
	for linux-nvme@lists.infradead.org; Sat, 06 Aug 2022 20:15:08 +0000
Received: from pop-os.home ([90.11.190.129])
	by smtp.orange.fr with ESMTPA
	id KQCMoiyYg9qatKQCMosYV7; Sat, 06 Aug 2022 22:15:04 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 22:15:04 +0200
X-ME-IP: 90.11.190.129
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fabrics: Fix a typo in an error message
Date: Sat,  6 Aug 2022 22:15:01 +0200
Message-Id: <9cff69b6e880387a420b848b7248dd6e6ad3739a.1659816888.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220806_131507_400230_51A3C243 
X-CRM114-Status: GOOD (  11.43  )
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

A 'c' is missing.
s/fabris/fabrics/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5207a2348257..da753d7db563 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1230,7 +1230,7 @@ static int __init nvmf_init(void)
 	nvmf_device =
 		device_create(nvmf_class, NULL, MKDEV(0, 0), NULL, "ctl");
 	if (IS_ERR(nvmf_device)) {
-		pr_err("couldn't create nvme-fabris device!\n");
+		pr_err("couldn't create nvme-fabrics device!\n");
 		ret = PTR_ERR(nvmf_device);
 		goto out_destroy_class;
 	}
-- 
2.34.1


