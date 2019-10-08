Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841BC10F14
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 03:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6122E21479
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 03:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="egR6TAtF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="caK2KVt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R4bfKr+uZ+x8gbemEiBeZ45tGQ3Lns+7lGCfMhjnGZM=; b=egR6TAtF3W/Ncw
	MkQJVUAp0LAG1cdVb7XuFEf5Zn82kuishrsx6b+BBlJlR6C/5hFuUO/X88Xcf/0lPuAbwuGp2+2Lt
	3D1ilHK7sZaEjypxsX8gE1hJ3+VJFXVqZAmxtU8d1fyQc78wNcQ5dP4zq6UACw1hjHB3F0AN1DmXO
	7qLSHtb1WTVW4c9y2Fc0GytGUuUERf/ExuTVpilmqfGcAKWQPXhMqjFZGgX9dhNhImYGOE+kqC/Aj
	+euaRy1DzFR6riVI0clsFLf6hG6tp2xF2b8/vfsPstA8VqFcIAnYHd8Cul+JnInNK9OgUSpDdwsTT
	QKnKnUr1d42AI5bY8rGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHgST-0005tL-Sy; Tue, 08 Oct 2019 03:46:45 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHgSQ-0005so-Kv
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 03:46:44 +0000
Received: by mail-pf1-x441.google.com with SMTP id q10so10024845pfl.0
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qFl2JG96ct4qaQdNKzWCXwE4r0sb40nsc6Szq0amLLM=;
 b=caK2KVt/69FIetO/j+F/mQvB1T1lmIkD4M/Ym3pzovmMBDwSyGKyFWJgv0NbF28UBD
 fjOEKcKBuqESKXMKm5WPWzttX89uf3jwRekaqAlpN5UOGJqsu+9hjEjmr6fzj2r2UVFy
 0URF798o3LPYju7YYzyGV3xlkl3XWOTNHF1tfUNP8JjRiD344Tdpi4IuTDDPYqlMR3CV
 hsP3qnje76JOL/7K484k2kPmPOpfNHkE8OdRxnlb6QdpZqsw2TtlzOAp0NYtJsNte1G0
 yLfERjeFXHqRzqcQtpgCIN3tR09DD8OWw/ro89CYo2Frnd6PswVGQ9/JZw3KVFc2gXfY
 zAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qFl2JG96ct4qaQdNKzWCXwE4r0sb40nsc6Szq0amLLM=;
 b=XNQEZ+mNU8pW1oll1TSpz2kZ6AKulum5nBTMqSZhX+fXlIQ5fbJnJToE6pPjHSXLV7
 zRVQ13qhUOIs5e2mGANr7/1FGiFsLmJpYX0/WbjbvwGSHjNYISuXUtT1l6pOHetR1cPi
 r3qbSA0KUDCW71Q6qzyPsxyq/iJz8Fl/hTRPP+EMONKI9M9LSCojgecZ2+KmTxrABsp4
 hGDG4wNMHtCyWBv1Iti8MVUVbecZLxN8QPUbjdhVHIMiP9/S4H37E9ZPj0J+uAr8mThn
 RGdrxMcLQ3TWPE6KOAsI28EK1pua/LdUl2ItaJGkg183DOFbADBfEQ9qB+tzPUD0hqkc
 h0kQ==
X-Gm-Message-State: APjAAAXYyhtWw/Jj22EZ1NLuDMSmrxGOqbh+BNxUXh5X5BS7W6TQ98Gr
 yRdvWp3oyGvsjsBZkyVZBnsJrw==
X-Google-Smtp-Source: APXvYqz3+mfqHvMdhEbzTG1UT8a/Xp17PYp3x6VIfOSFrMyUdGVDRaOyTkraf7LX98u/PBz7QlCBKg==
X-Received: by 2002:a63:1401:: with SMTP id u1mr1888823pgl.73.1570506400944;
 Mon, 07 Oct 2019 20:46:40 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id r24sm15671364pfh.69.2019.10.07.20.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 20:46:40 -0700 (PDT)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Matthew Wilcox <willy@linux.intel.com>
Subject: [PATCH] PCI/MSI: Fix restoring of MSI-X vector control's mask bit
Date: Tue,  8 Oct 2019 11:42:39 +0800
Message-Id: <20191008034238.2503-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_204642_734950_8538DF55 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: linux@endlesssm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MSI-X vector control's bit 0 is the mask bit, which masks the
corresponding interrupt request, or not. Other reserved bits might be
used for other purpose by device vendors. For example, the values of
Kingston NVMe SSD's MSI-X vector control are neither 0, nor 1, but other
values [1].

The original restoring logic in system resuming uses the whole MSI-X
vector control value as the flag to set/clear the mask bit. However,
this logic conflicts the idea mentioned above. It may mislead system to
disable the MSI-X vector entries. That makes system get no interrupt
from Kingston NVMe SSD after resume and usually get NVMe I/O timeout
error.

[  174.715534] nvme nvme0: I/O 978 QID 3 timeout, completion polled

This patch takes only the mask bit of original MSI-X vector control
value as the flag to fix this issue.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=204887#c8

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Fixed: f2440d9acbe8 ("PCI MSI: Refactor interrupt masking code")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/pci/msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..deae3d5acaf6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -433,6 +433,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	u32 flag;
 
 	if (!dev->msix_enabled)
 		return;
@@ -444,8 +445,10 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+	for_each_pci_msi_entry(entry, dev) {
+		flag = entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT;
+		msix_mask_irq(entry, flag);
+	}
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
