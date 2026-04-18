Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EBF436BF
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 05:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJCwCtDK5tppiTB+NoSBlbVR8SR8bVH1mwlh+NCIPBM=; b=W4rT/aS8rTXDdS+sTLzv78oPKN
	ZgEGJN3Tj3i8W7Zyyr4BIaN/D/ot9JIwV6dxNmCzLwZUSe2FCae5Tv/YLtvOoSCVb7RAEbPHiuV05
	ed5KxeKe9vZJEBOUl41e1jEt94M7ilh689UxfWN7nm0oPwR6Nnj5YOqH8EpvS2jd3BY6xXjqSGgEH
	ObSW+kiaeqiEfWyRGgNjAG3cbjB/43rFjNT5ff5WFwFt503ZlElIAYF+nPaC31ej+5Ga+Np1iVH+M
	T+8GXFv/ub159zkLnnDMn9Zdc9/XltFAUlaLHW5WlJNZdiDJUv/7CzdLcHFuQZxkFYcVWzixz2r4i
	CzXaorkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDy2V-00000004kd6-2l2C;
	Sat, 18 Apr 2026 05:16:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDy2S-00000004kcM-2BAA
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 05:16:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C40874185B;
	Sat, 18 Apr 2026 05:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF7FC19424;
	Sat, 18 Apr 2026 05:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776489375;
	bh=uMPl3Kc09k8mo4zpBH85e8Wx+IpfMYQJXFxOcuyR1oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxyLaMDflw+emQt95R4lPo1h8kRa4KDHaOfY/ksAQGYU/F/xVdQVFeuTcfmI6QsSJ
	 V70P2dugzCSIiv+7uSwEddAk+Ia30XVPuNjODqxsQCJWPLrz9eabfO+pBV71WLoG+8
	 toUVlqB5SAGfwjZLAQW0mwR7nWX+S8IaHzKKhok9f+pm9qC5kGnW+IMDtghBA9/nOu
	 LUhPOAei9BFDaVkEdnzFPNdt7Shvsalyfw76eWzCm3AvRC2GSucAfeinm+9Ov4LzG4
	 UjM9JGJyPbM97rw4gFJkJKo5fHDblkgz/RDlCusOigib8lb2nyeVEPUyShDN88Qx82
	 NlzhdLDi7pRtA==
Date: Sat, 18 Apr 2026 10:46:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Introduce pci_dev_suspend_retention_supported()
 API
Message-ID: <r4l53y6vfxqojwprm24cfnqb4etjkfqfw6xfakrdixgi3sc2o5@t3wpxspylebs>
References: <3smfckgl2vwhha7rtlqlpfzlfpg2rebyump77cbi5pcgwubn3y@d66eu7axo7xi>
 <20260417222904.GA97164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417222904.GA97164@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_221617_109681_1CD7A5F3 
X-CRM114-Status: GOOD (  46.77  )
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

On Fri, Apr 17, 2026 at 05:29:04PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 17, 2026 at 04:34:53PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 16, 2026 at 02:11:11PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 14, 2026 at 09:29:38PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > This series introduces a new PCI API
> > > > pci_dev_suspend_retention_supported() to let the client drivers
> > > > know whether they can expect context retention across
> > > > suspend/resume or not and uses it in the NVMe PCI host driver.
> > > > 
> > > > This new API is targeted to abstract the PCI power management
> > > > details away from the client drivers. This is needed because
> > > > client drivers like NVMe make use of APIs such as
> > > > pm_suspend_via_firmware() and decide to keep the device in low
> > > > power mode if this API returns 'false'. But some platforms may
> > > > have other limitations like in the case of Qcom, where if the RC
> > > > driver removes the resource vote to allow the SoC to enter low
> > > > power mode, it cannot reliably exit the L1ss state when the
> > > > endpoint asserts CLKREQ#. So in this case also, the client
> > > > drivers cannot keep the device in low power state during suspend
> > > > and expect context retention.
> > > 
> > > I don't know what pm_suspend_via_firmware() means.  The kernel-doc
> > > says "platform firmware is going to be invoked at the end of the
> > > system-wide power management transition," but that doesn't say
> > > anything about what firmware might do or what it means to drivers.
> > 
> > It's hard to predict what the firmware might do after it gains
> > control from the OS. But as far as the API goes, it just expects the
> > drivers to save the context and reset the device so that the
> > firmware could do anything it want.
> 
> I don't see anything about the driver needing to reset the device.
> (Kernel-doc says "driver *may* need to reset it" but no hint about how
> to know.)
> 
> Adding something like "device internal state is not preserved" would
> go a long ways here.
> 

IIUC, 'may' is used in the description because not all firmware are going to
turn off or do something with the device. But for a driver that is supposed to
work with all firmware implementations, like a NIC/storage client driver, it
should save the internal state and prepare for a possible power loss. This is
what the NVMe driver does currently.

> > > Based on d916b1be94b6 ("nvme-pci: use host managed power state for
> > > suspend"), which used it in nvme_suspend(), I guess the assumption
> > > is that pm_suspend_via_firmware() means the device might be put in
> > > D3cold and lose all its internal state, and conversely,
> > > !pm_suspend_via_firmware() means the device will *never* be put in
> > > a low-power state that loses internal state.
> > 
> > Yes, that's the assumption. Though, the firmware might not do D3Cold
> > at all, but the drivers should be prepared for that to be compatible
> > with all firmware implementations.
> 
> I don't think it's useful for a driver to know "firmware might not do
> D3cold".  What could a driver do with that?  Unless the driver *knows*
> internal state will be preserved, it must act as though the state is
> lost.

A driver doesn't need to know whether device will be put into D3Cold or not. But
it does need to know whether there is a possibility or not. Because, AFAIK,
there is no way the OS can query what the firmware is going to do at the end of
the suspend. So to be on the conservative side, this API gives an indication to
the client drivers saying 'hey, firmware is going to be invoked at the end of
suspend and it may do something with the device state like invoking D3Cold or
doing something else. So be prepared for that.'

And 'be prepared' means, saving the context and resetting the device.

@Rafael: Please correct me if my above understanding is wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

