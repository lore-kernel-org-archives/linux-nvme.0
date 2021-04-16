Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F6DC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 09:29:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BD261166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 09:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BD261166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g9+cE9rL38eLbe4fHuZ1ANyw6NhM3+YhEmD3sxPBDlI=; b=ASB+3Ml+Zw9IVZv22QNRmExJRG
	AjajBPPBKYA/Kd4DKCW+MuI7gS5Y+jzCktN8XbJ/ycCLKs1m9UI9zlrLkfCfS+GjfNOrZ8NEG8AFS
	SM0avuNV5AXwsNIlc9WF/YrquBEkanoTIwOiJsTGS82JcOcdRbhuxBE/mld+KXN3GWLqgjrvShTFX
	tfaX48LYxd2H77jt4XWEJKXdY83RJ5aPX18DLnSg72jfRh88Mc0pWgMa7jrAItUUvOncbQMB01nPW
	6GDjOanlpkgjSdM/QWFOvfog5Ppn2ZuSys82pTqYeoSQEAgqBNqMlNBiJruciKHxlyQ3r9JSzfkU6
	5uSRBtBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXKmV-001YEQ-DN; Fri, 16 Apr 2021 09:28:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXKY6-001VJM-3m
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 09:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=7nutUdfyCjiZA8Z+CnjyuPBARqIYhserdGDBDRdo7nw=; b=TWpNA+O4ajj05SprR1K2MW6FfJ
 Pjy5U5EKOD0uUAU0NMKpp2TXJUg2hvtQu0l8hmSASS6AJxxGTu5TVNta4PZGqNIZ9wKVWq+x4RrSu
 y9hR6qFA2NJ1HTBFkdURVcTBTbewKN4vRdfspyBo0/D0hJcP/FapRaopNFgTEny2X6N+LQBi0VTPs
 Xk5rWrYsD7eWTEfedBxkwyTXTI3CaSh5JDEHLeR4LeE1+IXiwCJuVDhXOAOhMtZ/fsHedP4C8m2HI
 aRJXjoOM+zCsH97ZiJnvlBIVqEmNSv3OAHEkqKnbeBe40NWE9XF2ilnPAippdlJUlSFGXxOtw8Jjp
 3oBOpQ4g==;
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXKXz-009ETn-CK
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 09:14:00 +0000
Received: from 36-229-228-200.dynamic-ip.hinet.net ([36.229.228.200]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lXKXs-0007Ka-Ec; Fri, 16 Apr 2021 09:13:49 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Prike Liang <Prike.Liang@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports it
Date: Fri, 16 Apr 2021 17:13:44 +0800
Message-Id: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_021355_569727_876796DF 
X-CRM114-Status: GOOD (  10.84  )
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

On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
because their SMU FW may cut off NVMe power during sleep.

Unlike Intel platforms where the power resources are generally
controlled by root port, the power resources is controlled by NVMe
device itself on recent AMD platforms:
...
    Scope (\_SB.PCI0.GP24.NVME)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            P0NV
        })
        Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
        {
            P0NV
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            P0NV
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
        }
    }
...
And it's a great indication that the NVMe should use D3cold for sleep
instead of staying at D0.

So use NVME_QUIRK_SIMPLE_SUSPEND if the ACPI counterpart of NVMe device
supports D3cold.

Tested on HP EliteBook 845 G7/G8.

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
References: https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Typo. It's EliteBook 845, not EliteBook 840.

 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7249ae74f71f..cc190324a919 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2840,6 +2840,13 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	acpi_status status;
 	u8 val;
 
+	/*
+	 * If the device itself supports D3cold, use that instead of D0 ASPM +
+	 * NVMe APST.
+	 */
+	if (pci_pr3_present(dev))
+		return true;
+
 	/*
 	 * Look for _DSD property specifying that the storage device on the port
 	 * must use D3 to support deep platform power savings during
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
