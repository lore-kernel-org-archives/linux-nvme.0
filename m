Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9532C02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+lqdk1c1KdRvGnnlF282CmUzFuHypyFnryyTGLwmT/U=; b=bPt2KetKDMNa7eVErfq1MMI1Up
	u4Z7/BBw0waPAiIeC3AvJuhFbrBKIiCMPGJNSr+8PmtEhUK3IB2q4WrXseeUnqwNCgyauqpUENoGZ
	0ARQKbCbjlqSJphi/hJ65yl2FFJFrwqIMVJU+0Z5usvp8AilSL9T+hzU/o/9cRqq3qhMHQymnhZK5
	LP/QfVSm0BzSHaEeyuUKxC+H9ytROaGlR3mMQKwVer9L40n6cTXQQvQ8VkL78GE9me4Ig0iTfYHIQ
	eaCGSuNNhsK9W485iBLwMOgWWAQhnSkyjy4Q9ZxjXjZX6mB5Ic6HlPPfOnEwVtH+Bq8JtaCwfyKP+
	CdBVc5WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thL2a-0000000G7ms-0FJD;
	Mon, 10 Feb 2025 04:05:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thL2X-0000000G7lv-29zB
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 04:04:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5550B68C4E; Mon, 10 Feb 2025 05:04:46 +0100 (CET)
Date: Mon, 10 Feb 2025 05:04:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250210040446.GA2823@lst.de>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org> <20250208185124.GA1120888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208185124.GA1120888@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_200457_698359_A7F2A9BE 
X-CRM114-Status: GOOD (  14.52  )
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

On Sat, Feb 08, 2025 at 12:51:24PM -0600, Bjorn Helgaas wrote:
> > +	/*
> > +	 * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
> > +	 * power to the PCIe bus after entering low power CX power collapse
> > +	 * state during system suspend. So shutdown the NVMe devices to have a
> > +	 * working system suspend on these platforms.
> > +	 */
> > +	if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
> > +	    dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
> > +		return NVME_QUIRK_SIMPLE_SUSPEND;
> 
> I certainly acknowledge that this is a big problem for users.  At the
> same time, this seems like a maintenance nightmare of
> platform-specific hacks scattered through endpoint drivers.

Yes.  And it's what we stated that we won't do multiple times.
This needs to be taken on in the firmware or at least core PCI/PM
code.

