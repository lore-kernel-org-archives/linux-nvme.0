Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94010C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 12:26:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52E864DAF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 12:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52E864DAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marcapo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CpZpInODtT4ObOnFMhpA1JoS9h3lRLT42EO26WQmvyc=; b=hotZF5MzP19fd/ao98KUyxIu+/
	NSocESWv1i7t8+kHjeNQueuLBNjDRreW9GzuW5YwMxmQUczCXGVvt1U2BEmB8UMC1stlUryWFuJ09
	buZ/o7klT4pdGZoBP6hSY/CMNm3wkzBSlfmKPodZtIq5zdBBPqOkov2cSy+zXWsYdOSzKkhgWWEG+
	VM/TRMgDAC9UxqA4XaMWRDly/achMdF7EkXNFvO/Gr7zyW2Gr8NmOoeeX2s2sg2StQjn9/umEMKWb
	hi6RmNoUjEB6lj6O56fgjpMC243JSMnSV5UmQ5Z3XctvJTrZlsksxQGK8JRiyweEvA/WttVfWS/v8
	B5A5vDiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBzQi-000253-56; Tue, 16 Feb 2021 12:26:12 +0000
Received: from mail.marcapo.com ([80.146.197.82])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBzQe-00024Z-VC
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 12:26:10 +0000
Received: from EX-01.marcapo.ebern (172.16.100.106) by EX01.marcapo.ebern
 (192.168.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Feb
 2021 13:26:05 +0100
Received: from EX01.marcapo.ebern (192.168.200.66) by EX-01.marcapo.ebern
 (172.16.100.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Feb
 2021 13:26:05 +0100
Received: from debian.marcapo.ebern (172.16.100.232) by mail.marcapo.com
 (192.168.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2 via Frontend
 Transport; Tue, 16 Feb 2021 13:26:05 +0100
Received: from julian by debian.marcapo.ebern with local (Exim 4.94)
 (envelope-from <jeinwag-nvme@marcapo.com>)
 id 1lBzQS-0005bg-5O; Tue, 16 Feb 2021 13:25:56 +0100
From: <jeinwag-nvme@marcapo.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-pci: mark Seagate Nytro XM1440 as QUIRK_NO_NS_DESC_LIST.
Date: Tue, 16 Feb 2021 13:25:43 +0100
Message-ID: <20210216122543.21509-1-jeinwag-nvme@marcapo.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_072609_045575_C7AB71B0 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: Julian Einwag <jeinwag-nvme@marcapo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Julian Einwag <jeinwag-nvme@marcapo.com>

The kernel fails to fully detect these SSDs, only the character devices are present:

[   10.785605] nvme nvme0: pci function 0000:04:00.0
[   10.876787] nvme nvme1: pci function 0000:81:00.0
[   13.198614] nvme nvme0: missing or invalid SUBNQN field.
[   13.198658] nvme nvme1: missing or invalid SUBNQN field.
[   13.206896] nvme nvme0: Shutdown timeout set to 20 seconds
[   13.215035] nvme nvme1: Shutdown timeout set to 20 seconds
[   13.225407] nvme nvme0: 16/0/0 default/read/poll queues
[   13.233602] nvme nvme1: 16/0/0 default/read/poll queues
[   13.239627] nvme nvme0: Identify Descriptors failed (8194)
[   13.246315] nvme nvme1: Identify Descriptors failed (8194)

Adding the NVME_QUIRK_NO_NS_DESC_LIST fixes this problem.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205679
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0045c5edf629..91cefa40543f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3233,7 +3233,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+				NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
