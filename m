Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA08F99C63
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 22:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=90GPSjPJxgq6uva6UQmf92zTsQHJ++EsPPG9OkfsNbE=; b=UxtCpCRMGsaAnb
	x0sbmCp8VVL/ZzsKsuLFQcOdqAZHsiYxebv/ZqIMWgpwobrW5nC9WWBFN74E3ENJ72GvQcQ52w6rE
	Hj4P9jlNT3utG7o18gpJGsOKgnBzrWzufcsQu3L3/Q9ULCP+J/N8DenuMJ+a3Qsh7hoQ32m+31kza
	C/Ltwx4q+4fHdjujLbQ6tm5ZVBdoIAnXk4JwoMdND2N5BJKbGZaTOr5GasclggCtnZ6hZ9gDcunce
	wTqCKHyUx3aOkXbMNAX6Kyta5641471EqbIKRUZXi2DRu7Asvnq/VSBwpdwrRPnx98SG1KvwY/uDO
	E6id0XKqdN9xr6xCgXxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrgV-00000004Wi9-05zv;
	Fri, 17 Apr 2026 22:29:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrgS-00000004Whm-0AZX
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 22:29:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6459340840;
	Fri, 17 Apr 2026 22:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A959C19425;
	Fri, 17 Apr 2026 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776464946;
	bh=5AZF7bXelQGRzqbFL48OEydTjXw5VXz9hXvYPhUg7As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uHokZ8JmZIpmCjQjmbsog78G5QkQcMRXVG1SuUlM+Nxsvs1vDF9q/BthjNfLvD12J
	 uOb9NrkpkQpW82ID0zvAni/zrsRRsQ6fPkz2mqBYnM3X9EyeMl4e+YnDuVraRaME+3
	 nDHMikggfXez8Tw3w3iu88GYsmtNQj97tzu1puKYbnjzlHsJNm5ZzDY5PNOtZjrKEB
	 WuHnkLDWAiaD4UbXIz3q2qSnKzASaDive6Pt/nsKkGFbceGWgHZRZjtqmfeOwpFf1c
	 kRFZJkMoVYnEpR6tJoaxuQnTFJVYM62JvSCDyw8DnKk/tYIvoyuMOEWWfV8xXYL9jd
	 +QOxtyBDDEs0w==
Date: Fri, 17 Apr 2026 17:29:04 -0500
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
Subject: Re: [PATCH 0/4] PCI: Introduce pci_dev_suspend_retention_supported()
 API
Message-ID: <20260417222904.GA97164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3smfckgl2vwhha7rtlqlpfzlfpg2rebyump77cbi5pcgwubn3y@d66eu7axo7xi>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_152908_164607_B9A91F68 
X-CRM114-Status: GOOD (  37.32  )
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

On Fri, Apr 17, 2026 at 04:34:53PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 16, 2026 at 02:11:11PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 14, 2026 at 09:29:38PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > This series introduces a new PCI API
> > > pci_dev_suspend_retention_supported() to let the client drivers
> > > know whether they can expect context retention across
> > > suspend/resume or not and uses it in the NVMe PCI host driver.
> > > 
> > > This new API is targeted to abstract the PCI power management
> > > details away from the client drivers. This is needed because
> > > client drivers like NVMe make use of APIs such as
> > > pm_suspend_via_firmware() and decide to keep the device in low
> > > power mode if this API returns 'false'. But some platforms may
> > > have other limitations like in the case of Qcom, where if the RC
> > > driver removes the resource vote to allow the SoC to enter low
> > > power mode, it cannot reliably exit the L1ss state when the
> > > endpoint asserts CLKREQ#. So in this case also, the client
> > > drivers cannot keep the device in low power state during suspend
> > > and expect context retention.
> > 
> > I don't know what pm_suspend_via_firmware() means.  The kernel-doc
> > says "platform firmware is going to be invoked at the end of the
> > system-wide power management transition," but that doesn't say
> > anything about what firmware might do or what it means to drivers.
> 
> It's hard to predict what the firmware might do after it gains
> control from the OS. But as far as the API goes, it just expects the
> drivers to save the context and reset the device so that the
> firmware could do anything it want.

I don't see anything about the driver needing to reset the device.
(Kernel-doc says "driver *may* need to reset it" but no hint about how
to know.)

Adding something like "device internal state is not preserved" would
go a long ways here.

> > Based on d916b1be94b6 ("nvme-pci: use host managed power state for
> > suspend"), which used it in nvme_suspend(), I guess the assumption
> > is that pm_suspend_via_firmware() means the device might be put in
> > D3cold and lose all its internal state, and conversely,
> > !pm_suspend_via_firmware() means the device will *never* be put in
> > a low-power state that loses internal state.
> 
> Yes, that's the assumption. Though, the firmware might not do D3Cold
> at all, but the drivers should be prepared for that to be compatible
> with all firmware implementations.

I don't think it's useful for a driver to know "firmware might not do
D3cold".  What could a driver do with that?  Unless the driver *knows*
internal state will be preserved, it must act as though the state is
lost.

