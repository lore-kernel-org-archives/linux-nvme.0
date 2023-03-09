Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC6CC742A7
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZ3Sk9Hv59R7f3nzNpg7N2ueHmbApUGviEEIiAE86H4=; b=hwcqqv7m2lO0AGxjPvHwBD+Hew
	NrXTIY6UpMwx6tPnDNaK/EkTt8eXHOH5/b0JAm+j4VJnzrKoo7aWSxyIHUUcSX2uH/dIgzVClI8RS
	csNq/Xb0Nb3wfxun4fpcuIDrmyLdF/YytRvV4ZyW09X7Q/75KjL0/NoIBsSfnJtqKgsNhozVvvmhC
	Rzi1fMlTdm5dD0FMhDtsAYOi5AEBBgiTswarndIGDbUKflcWPWLAoIvhWizEFOVWojl7TpYaudC6e
	pR11zCefSuazkCvlTWtnOA5ZYTMMMtHgFi8IaUKhcRzjedbulfoQzPAQZDb8x9M8NZODOPwKHHmVY
	J85zj1zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paK0g-00BQGx-JO; Thu, 09 Mar 2023 17:24:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paK0e-00BQG3-1w
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 17:24:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C74F61C99;
	Thu,  9 Mar 2023 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA25C433D2;
	Thu,  9 Mar 2023 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678382695;
	bh=BQ/4oicP1paq2R8L7s6sFM+Bt+aRZ0kI+QAMel2cBlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2FhF/sPGQvpe254E/Dqcso8mP+M/jMz43daXLb9tcUfrIhmjcLNw2MlJE6/1ymx0
	 nZd5kf8AdFcOkO7bRgdQ5PmnlXFEKBe4Bgd0cp0zmfaQ4QPbTwM+NGhIj3nlSzvlC7
	 U2cmGz4pqpMoXy2oYHYy9na+ZcSM+8cqry9y7ZD/3uQhjX2eX5edCyQdO4iMUB/NpD
	 GMV9pKQm0f8/QHjFs4doOiN9+/34Rj0099Vlp/1gDg+2KHWGnGIxUgDDaChOEKTpJ3
	 9jpV88dZI33+J0CsWZZn+pu9ioGJWvNajVyADNdLl1WYUyx/To8dUU7U3UDSyMIyH4
	 /zWxnrLDjjawA==
Date: Thu, 9 Mar 2023 10:24:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	"Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <ZAoWZFykm4F5wr+o@kbusch-mbp.dhcp.thefacebook.com>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
 <20230309151218.GA17235@lst.de>
 <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
 <1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_092456_178157_336B9561 
X-CRM114-Status: GOOD (  35.88  )
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

On Thu, Mar 09, 2023 at 10:36:04PM +0530, Rajat Khandelwal wrote:
> On 3/9/2023 8:54 PM, Keith Busch wrote:
> > On Thu, Mar 09, 2023 at 04:12:18PM +0100, Christoph Hellwig wrote:
> > > On Thu, Mar 09, 2023 at 07:31:07PM +0530, Rajat Khandelwal wrote:
> > > > Hi,
> > > > I am seeking some help regarding an issue I encounter sporadically
> > > > with Samsung Portable TBT SSD X5.
> > > > 
> > > > Right from the thunderbolt discovery to the PCIe enumeration, everything
> > > > is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> > > > Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
> > > > 
> > > > I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> > > > we are working on Intel Raptorlake systems.
> > > > This issue has been witnessed from ADL time-frame and now is seen
> > > > on RPL as well. I would really like to get to the bottom of the problem
> > > > and close the issue.
> > > > 
> > > > I have tried 5.10 and 6.1.15 kernels.
> > > So we have a quirk for a device called Samsung X5 in core.c, which is a
> > > bit of an unusual match.  Can you check that it gets applied for the
> > > device that you are testing?
> > > 
> > > Also if it gets applied, can you test this patch?
> > That won't help here. The driver should be bailing on the device
> > nvme_pci_enable() before we do the ready check:
> > 
> > static int nvme_pci_enable(struct nvme_dev *dev)
> > {
> > ...
> >          if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> >                  result = -ENODEV;
> >                  goto disable;
> >          }
> > 
> > It sounds like the bridge has a valid memory window, and the kernel assigned it
> > to the device, but for some reason the device didn't apply it to its BAR. Maybe
> > the device just doesn't support hotplug?
> 
> The issue is sporadic in nature, witnessed even during reboots with the device
> attached.
> Is such a scenario even possible (BAR not getting written by the hardware)?

It's not supposed to be possible, but your analysis checking the BAR register
with setpci seems pretty convincing that that is happening.

