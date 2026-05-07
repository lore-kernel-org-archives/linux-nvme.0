Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F27CD3445
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=kP+y/Vl8TmXBh/Imrw9EYYqRk/Rw3B2yQawdqTatU68=; b=yNV+RVu62Q1y7N
	8oedCFXpH+lkIoAY4HNCeAN3Wz8iH5BtF9g1BHvoMbH3BJn/LBtCeQa8hQI1TAIxPgu2dPuwzEknA
	ZvOafw4m5q9Pos/01GfXOTdGG4F0omdpgL9KBtb8+Wm+4eZGORdRcQkjG+0wWRQcDOEMIH6/J1fjD
	9xV9vAKNiL1VBhL8QtZqKSPHEiEnMhe6CcSgyjkBAXfZLRjYD71Ai/rgDjECR5ME0sMBWDxLVf+W9
	nvZyt50bCXPZWrgC/VBQ5x2QqWrg/4RpXNCnLgy2yBW4x00qnM5QVLdQ2UGXgj4iFA4nUwSrd8+MJ
	Vm6aG+tmZ7OwK3OOmV2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL7k5-000000056tr-0gDl;
	Thu, 07 May 2026 23:02:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL7k3-000000056tS-1Pci
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 23:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D8A060181;
	Thu,  7 May 2026 23:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED565C2BCB2;
	Thu,  7 May 2026 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778194970;
	bh=v7ZawboY1tagenWamPRS78LGMs+Lnkdb67PDXmvdElg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vIZsPB9LCVDbo33b//MxiLgxtLZpOOrDM+qB7b1QJ1yi+YHUCwaHeHZ/ut3j65dlZ
	 zFU33X6uHrGA39g+3x8+ePsw1fobbJjhbgF8ZJYOas0FsRLAe4Qv1gl5EK7U/thQy2
	 Eor+jZCAIcTfzAA2tYMzs+1680r6Zb8Q2mQ+0J1wb3abk9kxh3wZzBX51J1t/qydYG
	 zZO3U+ZQ6UBVs1fT6c8M+Q/6nyoub66hE56cbqgQNVA0uVERnIpgh3Dr3YOsuBuOdn
	 Fu6uvTy8HkYxWu7IAhUeXR25b6w7dY9yCvEypTiX7ir+ceXK+jHDnjHZEqy+2hpSTp
	 L+NOqjTMeg3jQ==
Date: Thu, 7 May 2026 18:02:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Introduce an API to check if RC/platform can
 retain device context during suspend
Message-ID: <20260507230248.GA51586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xqwvjygt3bgttbipe6hhnpkfwauczxpoiyfbbakdyzesz6ydcd@en54522wjnar>
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

On Fri, Apr 17, 2026 at 04:41:09PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 16, 2026 at 02:18:55PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 14, 2026 at 09:29:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Currently, the PCI endpoint drivers like NVMe checks whether the device
> > > context will be retained or not during system suspend, with the help of
> > > pm_suspend_via_firmware() API.
> > > 
> > > But it is possible that the device context might be lost due to some
> > > platform limitation as well. Having those checks in the endpoint drivers
> > > will not scale and will cause a lot of code duplication.
> ...

> > > + * pci_dev_suspend_retention_supported - Check if the platform can retain the device
> > > + *					 context during system suspend
> > > + * @pdev: PCI device to check
> > > + *
> > > + * Returns true if the platform can guarantee to retain the device context,
> > > + * false otherwise.
> > > + */
> > > +bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
> > 
> > This doesn't seem like the right name.  This isn't a property of the
> > *device*; that's all determined by the PCI spec (devices must retain
> > all internal state in D0, D1, and D2, they retain it in D3hot if
> > No_Soft_Reset, and they never do in D3cold).
> > 
> > So this seems like something to do with the *platform* behavior.  It
> > sounds like this is basically a way to learn whether the device might
> > be put in D3cold on system suspend.
> 
> That's correct. But I wanted to keep it device specific, since apart
> from pm_suspend_via_firmware() there could be other issues causing
> context to be lost. Like the issue with RC, brought up in the
> successive patches. There could be chances that only one hierarchy
> might be affected. So making it device specific would give us the
> granularity.

OK, a device-specific API is fine.

Maybe it could be something like "pci_suspend_preserves_context()"?

Is it the case that suspend never uses D3cold?  If suspend ever uses
D3cold, *every* device put in D3cold will lose its context.

How would this work if suspend can use D3cold?  Can a driver (or this
API) learn whether D3cold might be used?

