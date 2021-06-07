Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF5EC4743D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09D7613B9
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09D7613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mP4eAaBIVy1JvOEizT4FdAHTeYBMCaTYurKskq1zodA=; b=GspSXVRXpVqQpH
	PqqmZ06lYTl02d1LrDif4XIjcx6FvoCPrZKzyQtJyv3ba9oK10Uaz5biN7VJ0Blz/q656M1rvByH3
	HKDfwAHuW3Ygy+8VgcFNsmivPBpZJc8f2GqKjvLfw1LwGgdcrAmvVFZgMe68YPqj88v4BeGetFEGB
	zpOJNHC6DBuVU8DyVhgCT6Th5qHA7MGSouxF5QxQ8+tpmgWsl8MoUANFjpVHLSz56C/7LhEoipzoe
	jhtLI1BaCxmcDR0X7bqmuqqVp09X+kjq9pfXQRL2V9VZ4sgynIJiiGjHQXeLmnV9J5GHB/3RQCYL6
	/OENlXha6ovDMKRMNrBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3He-0016Ln-HC; Mon, 07 Jun 2021 00:38:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3H0-0016H4-09
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026266; x=1654562266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SugApmBKQHsjVZhqx1bnx6pZZ7uvrJdYqPulPlCiGNo=;
 b=Fbs6zk/nZ0/JjdzAr6rcAi1YO5GaPwSyORFVwDrE6AgI8pk7GT/eGcdL
 u2C9NU0Pwodr/odLaHS7FjTOr31uWk+4j7DrpQefXUHQijtdYwaeyBiZj
 vSw7O5p2NqNdyA+4rOZUCft7aTumLtah4aC/jp3fQXaVrzlEnWrThILj8
 eLthUt29ormTvO9qPkBpnVc16rbNZ4fTot4f3SfQbS5i+Ng6kml6GancD
 Eqc44kYdKwoPZ6KUlUCJeGXgYPHIj7AzPuAptTDvo4Mng+OPRacw48FXx
 0Do8PABFVhqO73Fh6bEoE3eXU3EARFgyhoaTQ5q9zMIiOOaACK3nZ8yrh w==;
IronPort-SDR: 0jWdqGinJvLzpKj7t9kyYnX3s7XwEk8Chjbu1HNRGUNObCmThEKmgGoWypqYa1ydVwWuO0ETrz
 GqR8E6sKKT993Alm6SDHFYBXhLgbtcovE6Eei68uOs1Qf8/21u6IWn47M7cVd2Iu0k+hunav2V
 iAXxV6uBfDVGhUBLfkpSH/X2tky8WqL4lqqj9Pvw2HCBU3IQ6auP4BwmWsKTC9gcYlc9yAg9Xg
 aPyzIfrjGCJxTOThaIm2lZ+grFofRHDGgn+LXQMgJHPHLket4KW3sR2L8WgdMopBAF/1A+awev
 MwE=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="170257809"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:43 +0800
IronPort-SDR: n3mi7jUitDVNX8MB27OClTPrXop3HGSDF9MQb5KDCXVr6YWEOwDqyvktenTYr6lFcLWAIHLxiP
 TQQJbZ39f1iz2jIMtwxwfcLyrgsCH7ZelBnkvuljQPDEkW1kikUy5V5WOf/C8YjCdjLpAiOxn3
 SvLRUMKbJQcBB+WSJYWw4ir5ExTSdl4kiJETr1Ev4U6CAiUiC6SyqzlBwofZ0WMf+x3lHPUBw/
 6uxL8zYPyCNmYOVs1pYDt2Pq3Ab6mV7UWjhL7Yr+iNXfT+U+el4uMJyG/siqS9H9YLNnGzoPNS
 Z13Bq7UuJ29yhzOnW0NaThWW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:15:26 -0700
IronPort-SDR: n97yqrEKCOcwL33Tb9/fClKyX3Nb/tC38P8niWlHGvp0O9TGIgrR1Dkhsl5krdCsf4wx1/iA/N
 +DkZp7g3VB713rUwKAg3woQpX9Kay9AdC/P+bSZK1gzuD0Am3QFVIHW+4OV6EOwG1BMl2jdyB5
 K35qyI+ib5r0SNWv+lQr6fAK2LETXyVoDzF2unLKACHknjBdapUjUtA93YOpl3JcwQ4R6Fv4ry
 ea/mc+9MDIG8kkvxDJ0pQ/RTIvzoec06FhbRs4zCvfTbb/vY2Q3VKxDqJBzuLNob/kCj1iFQlU
 Xlc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/5] nvme-pci: remove trailing lines for helpers
Date: Sun,  6 Jun 2021 17:37:05 -0700
Message-Id: <20210607003705.21784-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173746_187155_85278775 
X-CRM114-Status: GOOD (  10.74  )
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

Remove the extra white lines at the end of the functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7e7afc609b4..07d2bc317fba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -559,7 +559,6 @@ static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 		dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
 		dma_addr = next_dma_addr;
 	}
-
 }
 
 static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
@@ -576,7 +575,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 		dma_pool_free(dev->prp_page_pool, sg_list, dma_addr);
 		dma_addr = next_dma_addr;
 	}
-
 }
 
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
