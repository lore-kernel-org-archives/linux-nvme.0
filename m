Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3EC4743D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E98D61245
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E98D61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ixTaX4JM+Rem2NJ1D+MBuJpeqD1RR4feCCKqoX6jLmw=; b=uNN8ekOLL6vVHk
	eEJSjAGBt9mZdRrLGzqsThKtkhWaENmbpXXalVG8fKoSZsFfHE7c26FSdiEauZiz8GsEeCRli6Jov
	v45YKgSlSV65bL6+rmn7O6n+6d0pXik06r850ngSKXxSOaGZQQTRvIzKUORb7r750VsSzs9KPrhZQ
	3i17pZhWBcwhnA0xCQLFcc7JusG7Duf9ukmwzqaj2j7HvWMHrvy37CoPGAaC0Lb5i15YhA9LQ6aSv
	TJjJ9zCcZjlffiQSe0TVkW8+Wfy5YZRe26EswhdDT24fUgP+nsVOwjisrBEuPAKabWtRd4U4Us1/q
	qbMKBxYm6+XgQteXed/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3HQ-0016JW-5P; Mon, 07 Jun 2021 00:38:12 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3Gt-0016GL-ST
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026259; x=1654562259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SpSDT3wq1uKMaQgUaDY7mxIGWPmGznd2KJN9pKjqxwc=;
 b=Pmp8+5IGBqeaZ+6C/pNi/I2/e2UaKIAtXy5Of0AZdjNWuUZJGVdQTppT
 U0Lb3eagh6yxwqhKLZwjQjpMjX6S4OTiCaQBJi/NStR8Fc5K4Ys5MXJju
 nhhscMoQ2MDPryBLIz2jtP2J4RnWMM8Nf0HUHzlIbpj9kjuNxuBNwMACJ
 tDp/KF1k0gk9mp1QzkY7wxmF28TPP8WZAAjTFvsTn3zFLZlEE/KViKPP3
 WyyVQ8+JLhwBgbHIV80JSg8ii/Lb+DEmQzcd7OWOwF+iY4iHnBmjyXf6g
 a/MXgs0+llB5dzBggg0vBcJTLDsJHluvee1bxpn4Sb1hDtXkY8AZOyxEz g==;
IronPort-SDR: mp0pzE/XuNbE1nQiTNWd305LgifFp5kYuEAIV0WffDVbB51Y45ahBryqiMcsc961GGXt5HU9Y1
 k41wSNiK0OHGjzpc20ew+FR8zr0KF6TLFISbT6FrX49We7sjeuKymf+pVqXiF0i/C+nSoaaZMB
 9aGbzHRZ68GwfSKfmxoxhShKIIy1t9zFU6tK5ehHNLzzXV2OG3l3QOMsK2S07LtFdJP8mga4Nm
 ++ZW3BTPJ0vdG4S45eWy0EccB64N7MLRqRpkJyhONITEXa0tLnCLEwcEjbsSyJSgvt0jEPSBJr
 Xr0=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="282385382"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:37 +0800
IronPort-SDR: XrD55JWDhAY3u4J1Uid4sa5OXOI+d89Z/2mzUoBnwIhtc4BrDTsMBVXPqsOzoAdrPfkE/1MWYt
 50mQQcOHToFyuzJ13vpqEzlmfLSBGTcdfDJw/oSGBWn7WFIswOJvXzmvcndeTK4lAc2ntMwuBw
 1JwbSozo46PqFFgB7yVnC2eyg2rqJrNqdnfHbXb4dnbkDr8u+OD7sMA0j6ZVyMQt10bnI/14k7
 ebkyWd2yjFHaKhO2je4ApPl3LBXhxnMl4ggbNd/zkD8vW0CqUWUUWZVMf9msJnCueX3Sibftkz
 QuC0S/C07pyea91vr0EpfLJ0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:16:45 -0700
IronPort-SDR: j2CBt31wsCn3WRyQ54ko+V0kXedBoKYdl0TKF1WyYP8BQp1k8+GLahWYIPiPuokktlWW91LPL8
 B0nJtoEa8BXQZ7/KnH8uh0aC1uYRfreRd94VxLzg7lsEytHlHwqZT+UuTtwQEXYmXqycXoHAIh
 xxmuAw+T3ufHsK0MbQh9yMDmNjnf6XTKa5kTh4vvPhnpCjeGEyQ1lbsXROtbOMqEs7GaHoLk9H
 RtXWVvEpJ/zQejvdI0SG44m4dt486A62s0mKP9WU+g30kW28prEsj7eUWsV2hNfiqQ1XfmmZ+Y
 LFU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:36 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/5] nvme-pci: use helper for ctrl sgl check
Date: Sun,  6 Jun 2021 17:37:04 -0700
Message-Id: <20210607003705.21784-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173739_950362_1728C647 
X-CRM114-Status: GOOD (  12.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use helper to check the controller's SGL support instead of open coding.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..a7e7afc609b4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -536,7 +536,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 
 	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 
-	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!iod->nvmeq->qid)
 		return false;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
