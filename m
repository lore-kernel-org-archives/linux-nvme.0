Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD2DC47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4A761139
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4A761139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0r9FhZjsV1tlaFBe1FCxlrjyEfLY9zYDrWm/f0uucZw=; b=r/dF3Zu63fvATs
	KW0Heyush2fnUuuNM5in7l5q8ol64nc5XavRgDED78Hg5r+IJDfo1dnCQcPLmJdh0CbZxNvt6E+pe
	DidlYLarwP9QGTBerrUuK2uwC2Vk7UkHD3QqAxfRh0+BsF0/A9sZInkE4mTqnvrqXCKdN7fqE71uB
	X8r9v9cAWdLno0bXHOBxCy4MAYfVtno6VlbtE/+6lt3HQ2DLWqayrmWgqlb12hMe/8ZcTguwxWdAA
	LjQbHp5jeMMehuz6MbKbQfbifQlZWGmfmnBUSKZUnfCpUAdxv+ZSrntixw7ogNv5GTEHE+yaPhsl5
	ODPurIrtQiVll6Ht/jZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLMD-005Df2-V5; Mon, 07 Jun 2021 19:56:21 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLLX-005DMl-Pc
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095739; x=1654631739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F7+lBP4ojczhfwLBuUNgvZrx3fl7UfJYf/4YhIJ1zlc=;
 b=otaq0fLpJbTz8hnGQLdvzsEW0P4aIgyd6l6kuw9XZGXHy6JU7DkLf5ll
 IOdNsNzZpDtpCE9ScUXBpUAdv34nCrwEUd1AxIZd8Vva7LNI/PBvovE8o
 NUI0TcSy18vHGrmq+R3ggthirDsGBAIDfuNwfvaZtMH4eo/WRtMFB2TQ4
 0h9hXMTuM1g5eNMJlJio5KXksI8EM2umiHt7PnCeohYTyCZM3PdygIjMu
 BLlmmu9xen5T9nB121qihPf/d83EQE5U/TfmLh7voxezmCWL63nUvRjAM
 eo+KUwPwBrn82HBzTGX47Tcp2dNLVM1oy1T2fVEIjBPIq0exJpW9seYbe Q==;
IronPort-SDR: RzfQUAqHdAnxfBc6GrU9IPhIyDtNvdjKr1KobhsfqUI8IeHTjx3v0WorbM7CMHN8fPARWqVLpS
 QijsrJ1iqGkjHiW0c1SeF4Jwx004hgokJQkqvDHwf63sVBdaFMZWrPeh4ztNESxYBWCCF4F8jy
 lxrCu7ZIRiNGExxWcMpoa+is9E/bmNaC8QGD4uvY8lBAfguKp7XI2W9bIBrQjcXGwlBqtqOaMu
 m0x99lW91Y2A/c2QLK4x5qJxBp2kb6oyyeP1H3TrZ2erksnBy08s+JYAFzIVad/on6ls4FFYhB
 Pzk=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="282476017"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:55:37 +0800
IronPort-SDR: muEItKVP5eI3SBppEmFxjZ6o8AUy1/kdXLyGwivdAyNjks4qF8Qls71TDj0SZU+9+lVdTo2xrq
 A4c4suDv7qgszlqyz9JN99ok09kY0cZPKo6QfoOq9iJkGZuOpMP2Oey3gGsWATQU73d37r7t4B
 qoVjXjiFh1Xia6T8weZdipbjRoB03nQzNrbo/vOrpCMFEVAiEf+aWN24sEPNdF3mDpByy0fUUE
 Lme71txFRPIf6aX97NOHDoad9s/b23a4CNntv9+aC6khEGgNq/110+3OUqgkqNq1WTuvC82pnS
 sB3skxPzKGl/ppEi0IASwfCM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:34:45 -0700
IronPort-SDR: C7Rv4KgSy6hR6fRv+0Xv6wnPykhx0AKddSySX7+kAuiNmr3BN/UY9ejNjkePkm9gay2JNmdSCM
 tjL98wHHtAXMwWD0Uv0sDjK/jNg3gbQvOh0E87Q7e0IBODgzIP2FiVEMv5XrSyi1hvMbJrc61s
 XLeiL7J3HMmjTtOToPoAl+RMF1lXYYXkakvZK31oYz8OE9t3epqsCl9YMnDB3hgp7vQXiCVX2O
 qAIwZ0rD5nJhDNxblXBdrlF0t8/ZV6tfrzresyTIwWYDKMKOMCHxu1VXwpSweoZeqcegIiXHRV
 17Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:38 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 5/5] nvme-pci: remove trailing lines for helpers
Date: Mon,  7 Jun 2021 12:54:54 -0700
Message-Id: <20210607195454.16829-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125539_854495_95B44878 
X-CRM114-Status: GOOD (  10.35  )
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

Remove the extra white line at the end of the functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f86ad4b7a9b6..6933f843f3f2 100644
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
