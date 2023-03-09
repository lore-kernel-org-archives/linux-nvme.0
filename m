Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FDC64EC4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+N7I6eGUYJxc1KGHnaf6MJK43+HMaFQSYxo7aV2IXUg=; b=teWQYAEU4qaGjB4C5JqI7ro2X0
	jcW5BZr844ryVchFBYdo9q0Bqnnp2yfP0Uid+OsynirEeoNQJqtgskkimQEBA5wzjsrbiHMVxflL7
	jIJ1Za7qVespoo2A8/2GS6CIrPM291DM7I2d0kesVDV31ta/DkHgIJ7NNAvxGciRiQE0lhPLMWI9X
	l/WPgcCWwZElTsSLoneOwuy+kZqqT/I85HckIaguDN4dzHkhoJTPpJ2iUntZzH/DZlP27poEGiHx7
	ZrPaKgExHWKVRd0zJyXMuhuz1DVSvSfkqmJIGYJYSfs1b8Qt+SuCCabsmKnx7QfkD3zr+uLNgn58z
	NilsoBKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paIQK-00AzQt-Ar; Thu, 09 Mar 2023 15:43:20 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paI89-00AsUl-50
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 15:24:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75EA3B81F6E;
	Thu,  9 Mar 2023 15:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C09C433EF;
	Thu,  9 Mar 2023 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678375470;
	bh=luKkIiOnxC4xgzIbQ2E01NlgSbeqhevUBKSdWPFL5vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qrzp2nmmEe29k0kWgL5J2mFhdSs9+Q+bYBgB1B7FM2ECEVw1zonmEGw784jmx4gdH
	 4dVHFwFUkkl0MnS66gpgFdTSsKhZaQMXpIOxQ7DdZQ8zXkQwt5Io2Faa0bT9KQKL2I
	 4DDhTyAZUtk7KkcEctEozBBCvxpxazMt3JuUmB9mjUjZU445lTWaV84Gt9HjjlstJU
	 855UPvEFAQev3T35MxNMEl6OZdOsWJZId63AV1YdfaAG1M2pZWInJRv3dhGvUeLTmS
	 mctTXkodCHuiYCqosICoryZbxrKlAghS+Zv9tw3R+BGmxjaIEUip1ncDuGv0TBaqGj
	 6hJ2e7Sb4EDwA==
Date: Thu, 9 Mar 2023 08:24:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>, axboe@fb.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	"Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
 <20230309151218.GA17235@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309151218.GA17235@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_072433_451119_E60E5B7A 
X-CRM114-Status: GOOD (  27.98  )
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

On Thu, Mar 09, 2023 at 04:12:18PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 09, 2023 at 07:31:07PM +0530, Rajat Khandelwal wrote:
> > Hi,
> > I am seeking some help regarding an issue I encounter sporadically
> > with Samsung Portable TBT SSD X5.
> >
> > Right from the thunderbolt discovery to the PCIe enumeration, everything
> > is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> > Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
> >
> > I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> > we are working on Intel Raptorlake systems.
> > This issue has been witnessed from ADL time-frame and now is seen
> > on RPL as well. I would really like to get to the bottom of the problem
> > and close the issue.
> >
> > I have tried 5.10 and 6.1.15 kernels.
> 
> So we have a quirk for a device called Samsung X5 in core.c, which is a
> bit of an unusual match.  Can you check that it gets applied for the
> device that you are testing?
> 
> Also if it gets applied, can you test this patch?

That won't help here. The driver should be bailing on the device
nvme_pci_enable() before we do the ready check:

static int nvme_pci_enable(struct nvme_dev *dev)
{
...
        if (readl(dev->bar + NVME_REG_CSTS) == -1) {
                result = -ENODEV;
                goto disable;
        }

It sounds like the bridge has a valid memory window, and the kernel assigned it
to the device, but for some reason the device didn't apply it to its BAR. Maybe
the device just doesn't support hotplug?

