Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AFFCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 05:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7MYPfydlWU2JJQk4j750gf6fY5fxBP5VnXsZgaY6t/0=; b=3wK/SdiaizFf8032Et7t2voMQm
	R0uyEwR7OMpcNwaFFeOnnwSYAgeNdcJBJrHLBNFZXLo8HI2x/j/oQVKnuw6KWPV+V8PJG2gr7k+Be
	20+XiodxepDCzMw2bxogpvknBro2fzyOxkd7R0ljGV8t3tAPYINjzSc+nKSxcOV1yjlq4OS+M3sdY
	uo76Iz3/rrANaHkqQaQL+/D2Iv4IignCLFl9is8erf3DFwsAzaLyFHOC9N0yzalIzeRZD1A7uCIMT
	B3iv2FEu3S0ab0A8SaS9m002YkWytVTdxYkvF2qyr6tjRp2Jp9LxPwR1NhiZUwR4xGQ9Thb6tCr2F
	2f1THvnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMIzG-0000000CMYQ-2Pfc;
	Mon, 11 May 2026 05:15:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMIzE-0000000CMYF-3qUS
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 05:15:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DE766001A;
	Mon, 11 May 2026 05:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D8C2BCB0;
	Mon, 11 May 2026 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476524;
	bh=rK2ET1HiJ0JzQgjLAlzz7yx0hWuI8qnNbwc9GxCLjQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoUD8R5xu+BmQLR9qPGYh/pAB6M9BAYOhkmIF4FNUQaODve1oLXUPlWN/KeYyOFPL
	 +Qbd1Cjft6zAlpfbgl9hKJTqv1Ec5u+G33PE2dPp3UYxRMuH8xVL7kNNzA5Y/RTjbu
	 xxXVJiTOiLUqfHAyac4DkIQBBg8X9RB2I55DjPhKHK9k9DddFybWGNb3bbywu9Gn/Y
	 u/v2Fh0A72CnF6O8ozbD6CwYM3aJtCX0JW7Kd4lhUyZhKdeTiIab28HQoxp7/GeSxV
	 u6BzA1c2zNqAZJv7DIXaVzlDieqcqAjjsEUJ1HMP7KhVBBOUV5z6RUbwFHDBOtvwv8
	 C8bUw3qjEjeeg==
Date: Mon, 11 May 2026 10:45:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Introduce an API to check if RC/platform can
 retain device context during suspend
Message-ID: <tt3tl7vrdd4b4a73miywgvhdp4qqsvtfvx5xxxnv557t7daw6p@ieorx6il26qj>
References: <xqwvjygt3bgttbipe6hhnpkfwauczxpoiyfbbakdyzesz6ydcd@en54522wjnar>
 <20260507230248.GA51586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507230248.GA51586@bhelgaas>
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

On Thu, May 07, 2026 at 06:02:48PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 17, 2026 at 04:41:09PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 16, 2026 at 02:18:55PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 14, 2026 at 09:29:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > Currently, the PCI endpoint drivers like NVMe checks whether the device
> > > > context will be retained or not during system suspend, with the help of
> > > > pm_suspend_via_firmware() API.
> > > > 
> > > > But it is possible that the device context might be lost due to some
> > > > platform limitation as well. Having those checks in the endpoint drivers
> > > > will not scale and will cause a lot of code duplication.
> > ...
> 
> > > > + * pci_dev_suspend_retention_supported - Check if the platform can retain the device
> > > > + *					 context during system suspend
> > > > + * @pdev: PCI device to check
> > > > + *
> > > > + * Returns true if the platform can guarantee to retain the device context,
> > > > + * false otherwise.
> > > > + */
> > > > +bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
> > > 
> > > This doesn't seem like the right name.  This isn't a property of the
> > > *device*; that's all determined by the PCI spec (devices must retain
> > > all internal state in D0, D1, and D2, they retain it in D3hot if
> > > No_Soft_Reset, and they never do in D3cold).
> > > 
> > > So this seems like something to do with the *platform* behavior.  It
> > > sounds like this is basically a way to learn whether the device might
> > > be put in D3cold on system suspend.
> > 
> > That's correct. But I wanted to keep it device specific, since apart
> > from pm_suspend_via_firmware() there could be other issues causing
> > context to be lost. Like the issue with RC, brought up in the
> > successive patches. There could be chances that only one hierarchy
> > might be affected. So making it device specific would give us the
> > granularity.
> 
> OK, a device-specific API is fine.
> 
> Maybe it could be something like "pci_suspend_preserves_context()"?
> 

How about, pci_suspend_retains_context()? But I'm fine with
pci_suspend_preserves_context() too.

> Is it the case that suspend never uses D3cold?  If suspend ever uses
> D3cold, *every* device put in D3cold will lose its context.
> 
> How would this work if suspend can use D3cold?  Can a driver (or this
> API) learn whether D3cold might be used?

If this API returns 'false', then the device will lose all the context during
suspend. But that's not due to D3Cold, but due to the firmware and RC issues.
One can say that losing context is equivalent to D3Cold, but this API doesn't
guarantee that the proper D3Cold transition will happen (PME_Turn_Off broadcast
and waiting for PME_To_Ack).

So I would say, drivers cannot use this API to learn about D3Cold

- Mani

-- 
மணிவண்ணன் சதாசிவம்

