Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34FDC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 08:43:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623E464F11
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623E464F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marcapo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JUtzAnfJakHvmbymLjdN378lhPvAuHj5Mh1K2ijmV4Q=; b=Vc+AnQnh9FtvGd5FGSzolkbUn
	l1z3lRGNjyvL21p8QfnrZQ+vQ89svo0tJ40wghq7JsPdqK7bJZ7dMv0CxBslQ21gTVrXgRQCuzB/t
	bmYDPzUT+zzyshL5cFifZlBR0E+QE076u/L0fh7K/tT8ANIyS3bLQC9aNxnzy02IMTD1H2CpOuB8e
	kRF4GajF3FRIoa6e6MBxt1c06UoSh3mDxie6DdaQc4lGyQsmvvW8xPS1nBagXhtKCfL7XPPp80Nxa
	FPa88mxc3uIxty9xbJQlhgRxuBtkE6s4fKkMcZIU43K4yhqi1ig3jm5v8Hb9TcFpAasX23fsJp+Wm
	tP4xCKhNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI62s-00E3fU-QH; Fri, 05 Mar 2021 08:42:50 +0000
Received: from mail.marcapo.com ([80.146.197.82])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI62m-00E3cQ-B0
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 08:42:47 +0000
Received: from EX-01.marcapo.ebern (172.16.100.106) by EX01.marcapo.ebern
 (192.168.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 09:42:30 +0100
Received: from EX-01.marcapo.ebern (172.16.100.106) by EX-01.marcapo.ebern
 (172.16.100.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 09:42:30 +0100
Received: from EX-01.marcapo.ebern ([fe80::c414:7a63:130b:98dc]) by
 EX-01.marcapo.ebern ([fe80::c414:7a63:130b:98dc%5]) with mapi id
 15.01.2176.009; Fri, 5 Mar 2021 09:42:30 +0100
From: Julian Einwag <jeinwag-nvme@marcapo.com>
To: 'Christoph Hellwig' <hch@infradead.org>
CC: "'linux-nvme@lists.infradead.org'" <linux-nvme@lists.infradead.org>
Subject: AW: [PATCH] nvme-pci: mark Seagate Nytro XM1440 as
 QUIRK_NO_NS_DESC_LIST.
Thread-Topic: [PATCH] nvme-pci: mark Seagate Nytro XM1440 as
 QUIRK_NO_NS_DESC_LIST.
Thread-Index: AQHXBF7lSaeLZfCXrEaHCDSCLI7rjqp1DRsAgAAgdUA=
Date: Fri, 5 Mar 2021 08:42:30 +0000
Message-ID: <ca21dde3988941ed9bed8719af9af183@marcapo.com>
References: <20210216122543.21509-1-jeinwag-nvme@marcapo.com>
 <20210305074400.GA2546079@infradead.org>
In-Reply-To: <20210305074400.GA2546079@infradead.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.102.208]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_084244_753958_A141020B 
X-CRM114-Status: GOOD (  11.80  )
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

Christoph,

I'm sorry - I already sent a re-formatted patch with the added sign-off, but it looks like the message didn't go through. So here it is, again:

---
The kernel fails to fully detect these SSDs, only the character devices
are present:

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

Signed-off-by: Julian Einwag <jeinwag-nvme@marcapo.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0045c5edf629..91cefa40543f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3233,7 +3233,8 @@ static const struct pci_device_id nvme_id_table[] = {
        { PCI_DEVICE(0x126f, 0x2263),   /* Silicon Motion unidentified */
                .driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
        { PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-               .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+               .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+                               NVME_QUIRK_NO_NS_DESC_LIST, },
        { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
                .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
        { PCI_DEVICE(0x1c58, 0x0023),   /* WDC SN200 adapter */
-- 
2.30.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
