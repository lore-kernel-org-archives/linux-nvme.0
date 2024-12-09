Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04290E77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNK2zfi6tVXc+4s0Do+yMDt9DtDzDWGxibhzftOMlG4=; b=CZUYka+optkRMhz0SPhg76b46x
	aD/7x8pwCVMdzZbEtxW9OPrQP/dtxl36v3PS8BfP0gt5jyhsp6wUBWryOkvfa5VE9Xoz5BRS14Mv2
	czaM6PDeTkezKuKFWYW30bspVZDB/YPft8/NNTYPe5wLSYWzCx3Evs8IrsSIlzDj13MwNBtFJgWRm
	teJ6zvRCN2zWZYSpkQ3GmYVracPWNB2mHtq7rhHm2yhKirFPNVf2Rq3w27KCeeqPkAuaqt59hbOzC
	vdHa7LCrSMJTsvHIvpLNA8LA2Jr4QbJ07/a2//lD3brLRFiN2rlgaifoME8XeSzvCTQ8F8jqod5+B
	geS755Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdvo-000000081Qf-3ZRT;
	Mon, 09 Dec 2024 13:36:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdvm-000000081Pn-25bF
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 13:36:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C93D268D13; Mon,  9 Dec 2024 14:36:06 +0100 (CET)
Date: Mon, 9 Dec 2024 14:36:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209133606.GA18172@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241206014934.GA3081609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206014934.GA3081609@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_053610_679430_D68582EA 
X-CRM114-Status: GOOD (  15.57  )
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

On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> Oops, I think I got this part backwards.  The patch uses PCI PM if
> d3cold_allowed is set, and it's set by default, so it does what you
> need for the Qualcomm platform *without* user intervention.
> 
> But I guess using the flag allows users in other situations to force
> use of NVMe power management by clearing d3cold_allowed via sysfs.
> Does that mean some unspecified other platforms might only work
> correctly with that user intervention?

Still seems awkward to overload fields like this.

The istory here is the the NVMe internal power states are significantly
better for the SSDs.  It avoid shutting down the SSD frequently, which
creates a lot of extra erase cycles and reduces life time.  It also
prevents the SSD from performing maintainance operations while the host
system is idle, which is the perfect time for them.  But the idea of
putting all periphals into D3 is gaining a lot of ground because it
makes the platform vendors life a lot simpler at the cost of others.

