Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B488C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDhQkWMWRGoRLKTbtM9xVOh6hTvE/t2fLLJ2VXHyu5I=; b=gyeZc1aA1f7IdMPVmSKEGVPBuT
	ez3Act4yqPrynoTzzUR3ASUi2vRIyyH+OqHpL8D8FvSFckTvdfy+2HRR+2YibivbIDRg8ddwJPA1S
	OHle/IpEsuGTucpR9lVGsBgD12gacCjBtFHQ57mEnUbmL9NWwLSTR+ARTEeDiGVtDAzitoUMlAe/a
	rhxCcp7OpobLoj4dFCuvNYzPByZ/INyPQsh0/aCBV+7jyIfZJa9/krgvMIl9gsV/j1ejGD7IabHVP
	Z0BktBBHWj8xFfzZMosvZmfGOswdiEGvFcFRUWmUtAq/ECO89xXI03PcSh/HOyjNGOLNs68+LIuwr
	ldQaTDNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFuC-0069rk-50; Wed, 16 Feb 2022 08:43:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFu8-0069rK-SH
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:43:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8498868B05; Wed, 16 Feb 2022 09:43:13 +0100 (CET)
Date: Wed, 16 Feb 2022 09:43:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: simple suspend quirk for vmd devices
Message-ID: <20220216084313.GA11360@lst.de>
References: <20220210152233.1657933-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210152233.1657933-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_004317_086736_065288B6 
X-CRM114-Status: GOOD (  14.65  )
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

On Thu, Feb 10, 2022 at 07:22:33AM -0800, Keith Busch wrote:
> Bug reports from users tell us platfroms with vmd enabled regressed
> power when using nvme power management on s2idle. We can't get the
> StorageD3Enable property on such devices so the driver used the wrong
> suspend method. Add a simple suspend quirk for the domain since that is
> the safest option.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Rafael, can you try this on the affected platform?
(not for merge as-is)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9e1e6b8d88763..49f4e54da919d 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -723,4 +723,5 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
 
 	return dev;
 }
+EXPORT_SYMBOL_GPL(pci_real_dma_dev);
 #endif
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6809158..6edc8c514cbc8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3086,7 +3086,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
+	if (!noacpi && acpi_storage_d3(&pci_real_dma_dev(pdev)->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.

