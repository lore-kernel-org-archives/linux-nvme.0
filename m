Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A7C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Z0hSXrwJs04RatGvoAlABFE9l0i24ot8zqw4TJzqQz8=; b=E8tMRhb5cJd9YS
	Cd+vGKDTrCLWsBdw927Ow3JArikPVorZL0gd/OpAL89X3X2WIZx0bLJhrSCuzgLFTcjwU7U1jHh3x
	xtO6DiOjTtak0Peg0+q/DnxJ1dtqPAZOrimJK9PxgpYXwM3GJ1HmwSjM6HsCmUnDtHlRyp4nOtjIa
	xEK0tb6kbOiKQCpY9H9+koQHMc4+wTmesktsMkYDw9zQx1eldtxFb3EmvYGwsdFv7YAjqaAakP/CE
	LNUIuM8Sz+yCSopCrdKoPvbKEA7p2D2gTws793NDLMR0tSIrQN8EXSb4bSoUsqU8iGKAA8CPqIP9o
	uoCvYoYDUB27wlZ+ALmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4jYT-0000000G4lH-2YHE;
	Wed, 08 May 2024 15:50:05 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4jYI-0000000G4hs-3E67
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 15:50:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F016FCE18F0;
	Wed,  8 May 2024 15:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77EDC113CC;
	Wed,  8 May 2024 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183392;
	bh=r5zbc1G8htKO/feOFFIuiqq8DEmaTRKGEMJpyhghid4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G9yWQCUuZvJqlikdQWGQ2GpyZ8bG1ZwF0Y4YtacLg/7xIod/D9DlNODVPYmwysjR9
	 z8MDQWpgRekgvcxzOapXNcglceBVwR7z0kKzqFnts1+R09IK7WSeTTf9qqt3xS43OA
	 tfYua92rJmB5MjWmpfT/mFcO3B/cBBjYpxdgfbKMyH6lyyVSseNPyty1euMEoPHVGO
	 2Dp2fFVHWVRL66J9kIhYX2PCeETvdNStWVs6SxWGByZJt5zNuXWfN1VBkyYYEL34jb
	 EKWnd/Yq5oVH1Xqy8gOTFVnaK7UGBbc3Iiezh1jiMYNlO+MOeNwfUiolplHuE0i7aE
	 mDnjPRDuojzbA==
Date: Wed, 8 May 2024 10:49:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240508154950.GA1768252@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e784280-02bb-4e0e-a5ae-4e0a40ea4c51@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_084955_190136_13CE9872 
X-CRM114-Status: GOOD (  24.97  )
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

On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> > 
> > I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> > 
> > ```
> > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Mar 7 14:32:43 2023 -0600
> > 
> >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> >     
> >     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> >     native"), the PCI core does this for all devices during enumeration, so the
> >     driver doesn't need to do it itself.
> >     
> >     Remove the redundant pci_enable_pcie_error_reporting() call from the
> >     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> >     from the driver .remove() path.
> >     
> >     Note that this only controls ERR_* Messages from the device.  An ERR_*
> >     Message may cause the Root Port to generate an interrupt, depending on the
> >     AER Root Error Command register managed by the AER service driver.
> >     
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> >  drivers/nvme/host/pci.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > ```
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.4.y&id=1ad11eafc63ac16e667853bee4273879226d2d1b
> > 
> > Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regression introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
> #regression title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

I don't think regzbot picked this up, so trying again since this is
still open:

#regzbot introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
#regzbot title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> 
> -- 
> An old man doll... just what I always wanted! - Clara

