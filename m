Return-Path: <SRS0=Z/zs=YN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871ACA9EA0
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AB921928
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bfntYibn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pg7uQK+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AB921928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TwSzlq8vHMZrkkoEeUhQWWaEaR3QW29GEEeBmXkewM0=; b=bfntYibnXCtizg
	NGrSL/gbjw5091pjfu6YJyQBJEof86n2sY4mARiMEFL96cKV+HUhDgZIP9IM2KK+gdTys7b3u0FMa
	wv791MvK0iIeHHAhqMKnCq9ADVDFSiPP6QF5miXRwwSK7pg94TEh30tvr55quhUFFDfTHDdt6WP25
	vKMQTMp2LxtKBULgQtCJ2WPSUlvotg1/NsKxpN99SFTyqrZGCPlLml1IZWHLH3w3LsrSck0ftRpvq
	nFHKBXhEyYhGKB7HNv/P0bOwfc67MSrVFw0V3x0BXNSjaxET4oEwjAuzuPYHeS2dakU/Rxcu4op7k
	Y8kXkY6u1g3vwTmgjc1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMKqC-0008P0-LY; Sun, 20 Oct 2019 23:42:28 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMKq8-0008Nn-Ft
 for linux-nvme@lists.infradead.org; Sun, 20 Oct 2019 23:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571614944; x=1603150944;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UvXkV9cpe7GZrCq1Z+KHdi5vNklfj7PY8s4wcUn0ltM=;
 b=pg7uQK+yAeMkwaH+rsVVTiahtBCNnxDHYXyOyzJshccALrEIlxcvQdgr
 lTCUQN+ur3JRGCOi19WYdolX/++RhANhMf0JCghMdFaEXOf4QIPlr4sEH
 x/6crdA1fL18hZ1/ixM9pGT/FmKtAANnUaxOVUvKo9u7+QCi3Q/+bkoA3
 qPHghSdgdhDMLhiqxnJERz94kb6a+PPCHEItcwTSCdsZqugd92rgE1DLl
 Jjd4gz3RqCQdWuTW/rfEthOjv5onBHfyvn7Y5+glYWLauirk0LRDmxGj7
 V3uvZ5Da26fHVkwDEv6M52V7EQa+ug99DaTfevWjf7T+2MJqAKz6WQwH0 g==;
IronPort-SDR: iVMvyMzA+YUiGyx7tsMKvvptNI1WppRQ8CPU4Q4IgP4HHueVMmcWDCb+J7Hnnn+bgEM83uCgIA
 1nu4hvL8ShlEOmCDmsKkoIdXI7AemxsLATMJyaqbFr7Nj8FKkFvlq2976199wJoQdEWnZq3dyR
 p+dXF0/qWeBe8T4ahmty8RvhtvbVJiJzAHWUOJpVXErvJCIc+r1h3BU9ylIovJDNwrdkqklIuc
 wrys+LZVLtMi9uGyoyoWUdzKYr+jD4YX8Ut/GzQoU3gcvFY9njG07ntkOCcXSCproyva3NzBmC
 YzI=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; d="scan'208";a="228036409"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:23 +0800
IronPort-SDR: aemZfX2AQh/E95ZyTnGJhQucSiTEh8+cWQs6D6ElkLr0uOov6EqEV6ROu1XndITPS2OtZd2Orz
 x6RCe3jW/5rEf8K18H5s7Gs3EBgYSY1BqdKGI8C2nUXJ9wa8nrCvFSPy2U/l8BPbPYdazrfYu6
 4PIbus70RJ74qCM5paVW/oz6/tbd0s0qW7Fl9zMbOtmYjtlFWlx1WfnJguy8MySyOr/D6Y+hxN
 l1bjJlsR95kZbUFg2mdq2QgvEbAJDCSDEzOwbH1j7Zrb7KFq1+EZeiIfpyEKG95I+fvoXMw9V7
 62buKlQneZbgVObMaIumEsKE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 16:38:04 -0700
IronPort-SDR: ww4o/vndLJvfTlaIG3xtUhpXPo5a0u1AiG/5HYGBKBtvaxtL3T4+siYLECqyWq5PIKjTfTfhJk
 fxPVjTvYWDdDfu3hmts3ou7uig+JoiDmRsCSO/gFat7zG5jOp5be+a+5RZSflX4WiV9frANFQj
 ASgGYdN43KLJOK2HitNFVcys0ooZwf6qRyXmrZ07RD4jKtCZt1y1VzuYLLzbzzWchZI6slcIs3
 4MGKixTmivEMfLam3vkTAiCAzRaTaqF5UnHYuAi0WoNcL20zRAoHWS/fRYIl2bZE7Dtx336u0X
 eXs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:23 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] nvme: Cleanup nvme_block_nr()
Date: Mon, 21 Oct 2019 08:42:19 +0900
Message-Id: <20191020234220.14888-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020234220.14888-1-damien.lemoal@wdc.com>
References: <20191020234220.14888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_164224_562621_C1776402 
X-CRM114-Status: GOOD (  10.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use SECTOR_SHIFT instead of its hard coded value 9. Also add a comment
to decribe this helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/nvme.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..a979b62ea4b2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,9 +419,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
+/*
+ * Convert a 512B sector number to a block number.
+ */
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
 static inline void nvme_end_request(struct request *req, __le16 status,
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
