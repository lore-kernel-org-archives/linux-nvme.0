Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D45C3ABAC
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=4YUYyybCo2Drx3m8qAkikfIkM3AlqWhqmjb4pTjwbEE=; b=pFSpYiwjmJ8IRW
	Jr4CrgylZilCR3T/9vDN4WrrfOGFGF2pU1fiXouG0HajpjUoITRjxekctXoTae85WU8d4vguSjYo0
	WMDuhbJHJs68bHdd/g8xmieaqAxjLeHsRTQG32wB5Sbfgv+qjyqn98fo+lJyTG/+2P6UnOegW9LQA
	Es2CqLppp/X5GdHTIt1k+dzP85qqcyuImRYCPnF/nMD3VNywBvPbdmKCpnTc9GNXmh2oklmNZJ7Lt
	gNKq1znirml+FvRCF0GNVYddXycl73Lza/8oKBRMgZwFzeUZvbOChh29ga8ywcm2KMy7TIVN53KWW
	eNo5iN0JxiKH4xJAaciw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uArxF-00000002GyZ-0JHu;
	Fri, 02 May 2025 15:05:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uArsM-00000002GKA-2UA4
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 15:00:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2C96F5C5BC5;
	Fri,  2 May 2025 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EC5C4CEE4;
	Fri,  2 May 2025 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746198029;
	bh=8aiCnHx6TWw1iE5xKN7o3tAkYwOoStTtmDIkoORe3Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dzCQfIz7v1iUmcBwntCNPQxjLJrJREtBsxmKbr9i3UUBx3u/ubcBCcwXfl/6C9UV+
	 0xNYx8a82Z4L44tov8D14FsRRHCjZj8UbIMlElbuGycFH4DcqeArKFccRiMGkONMeM
	 uL9W0AZl8Cu0H+BwlbATo715JqAqMsrL5VrDbpyGVakDzSL0a5cpx1XZILGyglmAxi
	 jPGGTfalfwwzPgdD1cHtQ1VltFOcAewjFDK5C9PNhvebOfGHY1F6esK2QLzwF17mRc
	 RawJLZEpm71wD1BO1DJp8Ja/c8fdheHTzka6OkZI25YL09wqc1zX81FK6k0vb/yvl6
	 8g4USY6yetoWQ==
Date: Fri, 2 May 2025 10:00:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	manivannan.sadhasivam@linaro.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
Message-ID: <20250502150027.GA818097@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502032051.920990-1-hans.zhang@cixtech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_080030_686830_8371379E 
X-CRM114-Status: GOOD (  15.91  )
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

On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain

CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
dynamically regardless of the config.

> NVMe controllers fail to release LPI MSI-X interrupts during system
> suspend, leading to a system hang. This occurs because the driver's
> existing power management path does not fully disable the device
> when ASPM is active.

I have no idea what this has to do with ASPM L1.  I do see that
nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
janky and racy).  But this doesn't explain anything about what would
cause a system hang.

> The fix adds an explicit device disable and reset preparation step
> in the suspend path after successfully setting the power state.
> This ensures proper cleanup of interrupt resources even when ASPM
> L1 is enabled, preventing the system from hanging during suspend.

Maybe there's a clue in the 600 lines of debug output that I trimmed,
but without some interpretation, I have no idea how to find it.

Unless you see similar problems on other systems, I would suspect an
issue with the SoC or the SoC driver where you do see problems.

Bjorn

