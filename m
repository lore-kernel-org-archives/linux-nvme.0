Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F3DCD128A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 20:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=CbSuscu8LGwBrQAmdgvPDT9L/43QS1toy6u6a/73DFU=; b=hZUc1b1Q+ySDkq05fXHZ52T80H
	yNHqMeLqc64/wo/ypeTJxUxgHH3K9EA9ofHOIO74ENl3nLYMuJvbme7cpBrw54jzFAamtuMHYyBAH
	3ug+g56jlIZ4Id8D2saqt3b5CB8Y8D+ERqtL5eIOWR5p2nULGAvX8j5MN7jrUnGipo1u3RVMduU0h
	5umsSHIg+RfAORIS/dA6wzTYi47xVtLKeqCdmIiR6S5Aiunogzk7sVP6/IMfq8BaXLomfg5VVaHzF
	MgbM3xgmaABcjkzSspfmO58NQzagWIjFLCG7+QtdA/wR5SIRYvEAMRJWo92SjegEb0VteX97Lk0Mr
	sSvm1x5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruf2U-00000008vl3-3oQE;
	Wed, 10 Apr 2024 20:59:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruf2S-00000008vjx-11m6
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 20:59:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96DC461EDB;
	Wed, 10 Apr 2024 20:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D2C433F1;
	Wed, 10 Apr 2024 20:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782763;
	bh=zGAh4ICKgST7UhxvjpeVE4w+WnC0LVCFrEni6OL7qNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RRrjZkxAzgBqCzAqbahkK2QhXFqCH5r83Fxt9TbKx8//6Qtfqln3qBWMyyUPRq0Sj
	 +e29zeARUs6Lqc9bcLAro54EJ4/2/E6ahXlsyk9h5qKTeHCz0qo4V5Abr7H8UcYYYp
	 v1QgQNd9W1ZaxOVzFzuw+bPIKW3NkCZTX9NtQocnhpsYR5kA3nQ/dmqPk2H/b8+0xN
	 9tXAjwjVPKuVMpRWYhjC0UkRcxXGTE0VxgL/szUoWMKc/4z0ZbMi5sihaMnfdcys/s
	 gLR4qlFHAFmJE59iyHPbm/xt8AzVuLV7gorDESfkYvsfsGil+/tLCzPUdeGWkKJpPF
	 tLg2WOtQvD3IA==
Date: Wed, 10 Apr 2024 15:59:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240410205921.GA2156865@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6hH1=pchRidgMg2Go21tG=nJz+nz+6w++9hGSgFOcVgQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_135924_366518_341AFA1E 
X-CRM114-Status: GOOD (  28.00  )
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

On Wed, Apr 10, 2024 at 02:20:31PM +0800, Kai-Heng Feng wrote:
> On Sat, Mar 30, 2024 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 01, 2023 at 06:45:41AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> > > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > > >
> > > > > On Kernel 6.4 rc1 and higher if you put the Steam Deck into
> > > > > suspend then press the power button again it will not wake up.
> > > > >
> > > > > I don't have a clue as to -why- this commit breaks wake from
> > > > > suspend on steam deck, but it does. Bisected to:
> > > > >
> > > > > ```
> > > > > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > > > > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > > > > Author: Bjorn Helgaas <bhelgaas@google.com>
> ...

> > silverspring attached lspci output and a dmesg log from v6.8 to the
> > bugzilla and also noted that "pci=noaer" works around the problem.
> >
> > The problem commit is 1ad11eafc63a ("nvme-pci: drop redundant
> > pci_enable_pcie_error_reporting()")
> > (https://git.kernel.org/linus/1ad11eafc63a)
> >
> > 1ad11eafc63a removed pci_disable_pcie_error_reporting() from the
> > nvme_suspend() path, so we now leave the PCIe Device Control error
> > enables set when we didn't before.  My theory is that the PCIe link
> > goes down during suspend, which causes an error interrupt, and the
> > interrupt causes a problem on Steam Deck.  Maybe there's some BIOS
> > connection.
> >
> > "pci=noaer" would work around this because those error enables would
> > never be set in the first place.
> >
> > I asked reporters to test the debug patches below to disable those
> > error interrupts during suspend.
> >
> > I don't think this would be the *right* fix; if we need to do this, I
> > think it should be done by the PCI core, not by individual drivers.
> > Kai-Heng has been suggesting this for a while for a different
> > scenario.
> 
> Should I send the patch to mailing list again to stir more discussion?

Yes, please.  Include the folks from this thread, too, and the Steam
Deck bugzilla link since we have more more problem reports now.

Bjorn

