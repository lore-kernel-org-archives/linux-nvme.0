Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FACA6C92
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33mldcjipDX1PMIif4PTu8QHtmyXWAigqBMCRW35E3o=; b=ooX9wA1w8MK3BHp765rJ0Wf+hM
	21sR9pkEK/W/HaICIC7A6q1Xy8qEBYjbqnScyosiXGrw+Sry/pQLUsTWj+MlkNttzIV8TjAtp6hbU
	8PhIOlMOLVNa75j90MduVYa4aY8AasD4aUcgxJq3oZhouMK/1czqwCrd7Ctm7rJDFUwCbNclT0+6X
	xtB1c/WV45BrUAAKOnqeonkLjh/jzdZ2gBv7bHb5CroJp0iIJvKlVFXyWMKo/Dc0QPhwAkjVM/YTp
	mAedsVcuf43KCA/FbiAVE4+IGEKYsn9ncYn+xnDEhSDBfj+gdwRbnug54q8P3HJ/1Ol4+Ze3n7Tu6
	x3NbxzWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkekE-0000000DsPP-0bVu;
	Tue, 27 Jan 2026 08:48:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkekA-0000000DsOg-2j1u
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 08:48:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF9C2227AAE; Tue, 27 Jan 2026 09:48:08 +0100 (CET)
Date: Tue, 27 Jan 2026 09:48:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127084807.GA342@lst.de>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_004814_833001_8B7495B1 
X-CRM114-Status: GOOD (  22.25  )
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

On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> The NVMe PCI driver exports the sriov_configure callback via
> pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> VFs through sysfs. However, when the PF driver is unbound, the driver
> does not disable SR-IOV, leaving VFs orphaned in the system.

That sounds dangerous.

> According to Documentation/PCI/pci-iov-howto.rst, PCI drivers that
> support SR-IOV should call pci_disable_sriov() in their remove callback
> to properly clean up VFs before the driver is unloaded.

Bjorn and other PCI folks: is there any reason to not do this in
the PCI code and leave a landmine for the drivers?

> Fix this by disabling SR-IOV in nvme_remove(). If VFs are not assigned
> to a guest, disable SR-IOV. If VFs are still assigned, emit a warning
> since forcibly disabling would disrupt the guest.

Well, I think we have to distrupt it, at least for hot unplug.  This
sounds like we need some better handling in the core code as well.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 58f3097888a7..4f2dc13de48b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3666,6 +3666,15 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_stop_ctrl(&dev->ctrl);
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
> +
> +	if (pci_num_vf(pdev)) {
> +		if (pci_vfs_assigned(pdev))
> +			dev_warn(&pdev->dev,
> +				 "WARNING: Removing PF while VFs are assigned - VFs will not be deallocated!\n");
> +		else
> +			pci_disable_sriov(pdev);
> +	}
> +
>  	nvme_free_host_mem(dev);
>  	nvme_dev_remove_admin(dev);
>  	nvme_dbbuf_dma_free(dev);
> -- 
> 2.43.5
---end quoted text---

