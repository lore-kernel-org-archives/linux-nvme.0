Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463A6C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kyKUmDEGk5hOprjXSvd253e1nqOoFqC+v+9xpyPwrCY=; b=3EfLSmREhHsGDZpN6hhpDDMA6A
	J+K84WKHNt+n6aP6NICJ+vzfTIWWfzOTOQ4eItFYnCfeiX0HAoyeCU/Jh/52CFTdPVWrG4pVIeElG
	xljyJyI7/7WR/qHVjwutuOm1NOOGWCpxO5e+CF8njrZYXLMYaxgo2qwvIYgJEP5OUAVQd1VbISzsl
	rKu4qpKiMPqQjLUeZuCKadMIM0OlAGt0GF85QT1F+qY2gvJZrCLKn/MCr5neVa6jpqdYalxzu7/bR
	OxDqYD1YBa/4h4ON6d5HWZ0H4qJkk5Y0JDJGHLOYlYg1WapbWaofEMKziBgeM2ooLhLzy/LTwkb6N
	7OHgih/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhkN0-0000000GUDm-3dgq;
	Wed, 06 Mar 2024 06:03:14 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhkMx-0000000GUCH-2VFT
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 06:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709704991; x=1741240991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v2sQTHOKelwDGyJc0y/jnJH5nZsV/r1ig3/BjVCNG4g=;
  b=jg6dBMaeDN/XVnKjxv3htvqiqXSJ87iG7752tjExgoNtWVIfMCSEGJc9
   DpSwp6gH+bezqOReNW1KVitCyONXIVnmp5ArMoNVpF5K/Cj8AhbgiWNYi
   pMJ/FqX3xS/KtRI6ShDVHtrx8ag2RxIae1g/faXaHvcnfKpljKjIR76df
   T8q/GBSbX2Vxbn0iHILtasHjycKDjxzs5+HlUsgXUnRpSJh+SIWDZPsyP
   3c1OTQQIvXX4LD3070YuoGWruTlGjbDBib7MzTbiJ+Kuyujq5nDG4ehDZ
   3Td/gOIaCIpm5V+A9PtDzCmTUwS9QJITTBcP0iCvZHxre6YFnCMEje1qv
   w==;
X-CSE-ConnectionGUID: azpqPmvaTsuk1WkRFwyTBQ==
X-CSE-MsgGUID: xbYr/26LTvWmscjgjcRpSg==
X-IronPort-AV: E=Sophos;i="6.06,207,1705334400"; 
   d="scan'208";a="10761569"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 14:03:06 +0800
IronPort-SDR: nAwMqAkFFvIQlfmTX6DCqLW2QMC6VLapKoIQ6udWLS5aS1kpRGE9dqcW6LL2i+V06mvOd7gZU9
 jcCdxUeE9T1w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 21:12:16 -0800
IronPort-SDR: s88Aas6ky4xkgpzczQGmUoKgNIzVYg/pNUZu/FGve1iVW2q1wgcCCEG709lbeTZfjV7g06Hsii
 F6yRVPpGWIvQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 22:03:05 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()
Date: Wed,  6 Mar 2024 15:03:03 +0900
Message-ID: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_220311_802589_5D306ABA 
X-CRM114-Status: GOOD (  14.02  )
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

When nvme_identify_ns() fails, it frees the pointer to the struct
nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
for the pointer even when nvme_identify_ns() fails. This results in
KASAN double-free, which was observed with blktests nvme/045 with
proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
skipping kfree() when nvme_identify_ns() fails.

Link: https://lore.kernel.org/linux-block/20240304161303.19681-1-dwagner@suse.de/ [1]
Fixes: a1a825ab6a60 ("nvme: add csi, ms and nuse to sysfs")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Removed the goto label and just return on nvme_identify_ns() failure

 drivers/nvme/host/sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0..09fcaa519e5b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -221,14 +221,11 @@ static int ns_update_nuse(struct nvme_ns *ns)
 
 	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
 	if (ret)
-		goto out_free_id;
+		return ret;
 
 	ns->head->nuse = le64_to_cpu(id->nuse);
-
-out_free_id:
 	kfree(id);
-
-	return ret;
+	return 0;
 }
 
 static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


