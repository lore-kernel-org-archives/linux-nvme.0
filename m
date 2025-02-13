Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC58C021A8
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgoHYoJSx78y8J12+jvcGdamNdHmjLpJ71AR3ZswIWs=; b=fAgsEY+bID6qVSco/D+nDn9A25
	lnVksBbJH6UuNPzeBTJNTtG0x3asd9ToORTWCcDXcoCTtEZAz3zlzIoJuvTK1TkGnyEQYAZW7F6eP
	4hbTQNi60pmDPzx3Yps6tKxIolo+YGo8wK7tNunTKM2XuvmhTyoROg3avNcrKRnutoqWzMDC1qljA
	bTvIVlXpxpOVyYz7wWPzoEWe/hWUo4gmiSNA4ckSARJntUv4oPP8eHg0poDb9f6GBvN1Gi9GTQBwU
	MCzbRMLWOVWojUJo7BVXWJLr4N85kcrgg+TaRPfMvxlayJzLYbxYE5Xv/j7Zbu3NoJttfnmHxAJtZ
	/jw9sUeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTN5-0000000A33n-1Xnc;
	Thu, 13 Feb 2025 07:10:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTN2-0000000A32u-45vf
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 07:10:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B75AB67373; Thu, 13 Feb 2025 08:10:43 +0100 (CET)
Date: Thu, 13 Feb 2025 08:10:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250213071043.GA21238@lst.de>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org> <20250208185124.GA1120888@bhelgaas> <20250210040446.GA2823@lst.de> <20250210063605.yp5rkraain5oqxka@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210063605.yp5rkraain5oqxka@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_231049_156285_75D3CC56 
X-CRM114-Status: GOOD (  14.93  )
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

On Mon, Feb 10, 2025 at 12:06:05PM +0530, Manivannan Sadhasivam wrote:
> Multiple times? As I stated in the commit message, this quirk is *not* going to
> be extended for any Qcom platforms as the rest of them can retain the PCIe power
> state during CX Power Collapse.
> 
> And we don't need this quirk in any other endpoint drivers as this chipset is
> mostly used in Laptop form factors and only the NVMe driver is found to be
> causing the issues. Rest of the endpoint drivers (WLAN, Modem) are all coping
> with PCIe power going down during system suspend.

No matter where you need it - the place is the core and not the driver.


