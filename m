Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062FC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:58:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E722084D
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8Edj1Id";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQnMMN0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E722084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZDNz9k74CqwLrLR8AUF6DqpJfFQLi4OO1nCmxECQrUM=; b=O8Edj1IdFy6RxE
	WlprkdL163fliZhp91sb115dggAQyZdTt80RDiTPETSVXH3aS4QkP31XtIpxSov01AXD/WIh0fQhY
	XGsirSDkxw4hotj6XnYxfyFSLTDCQFQfCfz2+PF95QiHvCxkCHUZcJzsCU8/xQLow1QAj71BCdBww
	zW7TNigkEcNt9bEd/dOXPRCp9KK5TSQieG8MSg9HamoE1Z9nUAttvK5fbtQ8EYDkAAl0gtB5ihcqz
	N9aDMWOim3ri5eOPK07jGZI/UYSZ2Ks0TukUfa5I6CAj7WAo1JoNKsf8pZDNCbJ8Sc0Vvu4rfC4b+
	QlSTjHG+DzsNtNrVpUKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia1aV-0006pf-Ea; Wed, 27 Nov 2019 17:58:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia1aS-0006oS-Sx
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 17:58:50 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7EC6520862;
 Wed, 27 Nov 2019 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574877527;
 bh=t6krqhTDOQbA3ccYV42rHwI8py0lNr+pInJfmGl6yLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qQnMMN0/X1NzxPHgboVGfR/19OokLsHFgkBg7co3L9l2FBZfZm3tCKTYS87K+1/2+
 Z6ZQ7tAPpbCwv9XFCGFS1gCaWPiRi9gnco/zuKk8VvXNE8R53gAbDu3Bps7edP8x3J
 CLGph2ZEfbiEIMDDXWk2iP8A/ipOWI/mFRYdX71Q=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 1/4] PCI/MSI: Export __pci_msix_desc_mask_irq
Date: Thu, 28 Nov 2019 02:58:21 +0900
Message-Id: <20191127175824.1929-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127175824.1929-1-kbusch@kernel.org>
References: <20191127175824.1929-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_095848_957258_CF13A15E 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, bigeasy@linutronix.de, helgaas@kernel.org,
 ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Export the fast msix mask so that drivers may use these in timing
sensitive contexts.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..9e866929f4b0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -225,6 +225,7 @@ u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 
 	return mask_bits;
 }
+EXPORT_SYMBOL_GPL(__pci_msix_desc_mask_irq);
 
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
