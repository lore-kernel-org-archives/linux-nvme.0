Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55CDF8D76E
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=DIrcHJZIZnVmcN4uzVlAitO3bhLa+bfS1CnfIjplpeg=; b=YPIfyUF35UW7Jj
	cPkYg0Jfl/aw2gUDu+SgSaHX5/crcnqQ1XvGO5T3vvxpaqajlBEzMplSiL/pnwBLk2Tx2t+8Yti78
	SQZ7TEW3IGRGYAJ0J2DNLmkYIYPLBcWxkQMQGHW08KCrunEOil/xLRbF1Cr5K+SN7jzIMk4bSBcKg
	C5bo3s2bhdKyaocPTVkfCO47eAYbKn+ww3UME7WarXULAS0VfB5l7d10K2cgvaRDXI7kWoRl3bqua
	prHJgXXbpFJe2wskt1ZfOzyDUzsVGezlOzhZuBS2GI27HNSUPhHeMIJRRCskmzGQ9BMOOcQ/FJYOM
	X1fSZ+qG6UiAcwCsAmSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDS7U-00000002qUI-43j2;
	Thu, 16 Apr 2026 19:11:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDS7O-00000002qTw-064I
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 19:11:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 296326012B;
	Thu, 16 Apr 2026 19:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B72C2BCAF;
	Thu, 16 Apr 2026 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776366672;
	bh=Q2H3x8CdirEHfVoa08O/a+N+b/S6QwlAH7SlxTlmmfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ik2rhivZKSXgN5rKi/dWwx3Hgk21VWQffi8tBP/cwrpj6Y01UiKcQoXv37K6MDg99
	 cmta1Pz8Jdr5BxvUomqb2r+EILw2ONnyLXpBh3hvYq7DiEpN2NrpxMp4AMiE679pao
	 JA3ycbMLQY7v0X2uc/aeoPmi50YD61iaOD1acTZZOHxnwzPUjcylcfB11I5//Md2Ok
	 XuWtabYZFKCjaBDObM4WqIVOxuGn0cwutpM0etxUvP6MpPFNaTb83sQYZCFGWvZ9aU
	 bnGhSzEGoKuTooYlB77rwelwHnFwmQEwuybTt7LGfvsgBdLnMr5YCzOlZdqkyn6IaB
	 oJrhZLIfEL9RQ==
Date: Thu, 16 Apr 2026 14:11:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Introduce pci_dev_suspend_retention_supported()
 API
Message-ID: <20260416191111.GA21551@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
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

[+cc Rafael]

On Tue, Apr 14, 2026 at 09:29:38PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This series introduces a new PCI API
> pci_dev_suspend_retention_supported() to let the client drivers know
> whether they can expect context retention across suspend/resume or
> not and uses it in the NVMe PCI host driver.
> 
> This new API is targeted to abstract the PCI power management
> details away from the client drivers. This is needed because client
> drivers like NVMe make use of APIs such as pm_suspend_via_firmware()
> and decide to keep the device in low power mode if this API returns
> 'false'. But some platforms may have other limitations like in the
> case of Qcom, where if the RC driver removes the resource vote to
> allow the SoC to enter low power mode, it cannot reliably exit the
> L1ss state when the endpoint asserts CLKREQ#. So in this case also,
> the client drivers cannot keep the device in low power state during
> suspend and expect context retention.

I don't know what pm_suspend_via_firmware() means.  The kernel-doc
says "platform firmware is going to be invoked at the end of the
system-wide power management transition," but that doesn't say
anything about what firmware might do or what it means to drivers.

Based on d916b1be94b6 ("nvme-pci: use host managed power state for
suspend"), which used it in nvme_suspend(), I guess the assumption is
that pm_suspend_via_firmware() means the device might be put in D3cold
and lose all its internal state, and conversely,
!pm_suspend_via_firmware() means the device will *never* be put in a
low-power state that loses internal state.

> And these limitations may just keep adding in the future. Without a
> unified API, the client drivers have to implement their own logic
> which may cause code duplication and may also lead to drivers
> missing some of the platform limitations.
> 
> Once this series gets merged, we can extend this API usage to other
> client drivers as well.

> 
> Testing
> =======
> 
> This series is tested on Qualcomm Hamoa based Lenovo Thinkpad T14s latop with
> NVMe drive.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (4):
>       PCI: Introduce an API to check if RC/platform can retain device context during suspend
>       PCI: Indicate context lost if L1ss exit is broken during resume from system suspend
>       PCI: qcom: Indicate broken L1ss exit during resume from system suspend
>       nvme-pci: Use pci_dev_suspend_retention_supported() API during suspend
> 
>  drivers/nvme/host/pci.c                |  3 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  drivers/pci/pci.c                      | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h                    |  9 +++++++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> ---
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> change-id: 20260414-l1ss-fix-6c9cf2451944
> 
> Best regards,
> --  
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

