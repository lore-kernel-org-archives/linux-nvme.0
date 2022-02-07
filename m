Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DCCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GCTWiA81MPBnaPXOSRkh6We9a/VmDgvSUJ0rd5Ggp0=; b=kVPUEQRWTEoZfowpWA9VFnvnaq
	UGyOVaUGzuteJMVQaH9FE8LdSXK8MU0iJOcA/83U0OdS801lFfpsHCQS5t3u2pMFCeWmpTPr5E7yM
	gX+cKH59hTR0vVGUblmxZnHEFWD0MD3idr1DGh6hfVMX7tAay9fZd8IcKxNdqIXy8aQd8zwUWZDQ6
	jIdHF1qW4Rss6a12/z/oMrI7EnZp43Ii8vabruGsfmtnkpVYcLWjiqTDjr4ki0pUEHnFNUM+Mixno
	5vieuew8L/eNCNqLTVkL7QGorpzIxcrxp70TBtBbGZi6Uqin8f+6Uc9KyeVGo76irsTQkcKko4aop
	G9PwoV2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH6ll-00B39z-Uo; Mon, 07 Feb 2022 16:21:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH6Xa-00AyRe-Lj
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 16:07:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFA461515;
 Mon,  7 Feb 2022 16:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BBC004E1;
 Mon,  7 Feb 2022 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644250017;
 bh=2Gb+EU/AtSfdjaSNs2GhjR7p8dRKSjvHZi+bY9y9Wr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K9W0wHidFRcOmv3GmSe9PLfxX73SmKCWstDDFTD85Rj0GbMnYhhgkhlWBTNRAdjca
 /4XdPhDMMMIwmZgcIiZ+OcjRo3v6kMrJ4bwbR6pgkuGKjf09P3F53F2OfzFsYeVdcT
 kKDpF8DkQOfVNwVfKpZrO8COBSOcBzt2EHBLeHv6U+f8tAsLHQDefG4/I/2E3Ul7k/
 418orfUeQXE65DnIOJfVIRMuQDW3Za7CuOBVdizXuJLycwxND9EOF0XJfvn4UCEr6C
 VUxDxceIxLzpF1epCvIYtu6YWRWzL/71wVj4tlRzaOpDXZECcIZPjk89Um8loumRHv
 nupDu2kvCjZwQ==
Date: Mon, 7 Feb 2022 08:06:55 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220207160655.GB635727@dhcp-10-100-145-180.wdc.com>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
 <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
 <20220204071012.GA28638@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204071012.GA28638@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_080658_846591_A912F82E 
X-CRM114-Status: GOOD (  31.88  )
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

On Fri, Feb 04, 2022 at 08:10:12AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 02, 2022 at 08:03:34AM -0800, Keith Busch wrote:
> > On Wed, Feb 02, 2022 at 08:55:02AM +0100, Christoph Hellwig wrote:
> > > On Tue, Feb 01, 2022 at 08:50:06AM -0800, Keith Busch wrote:
> > > > There is no complete set of attributes a driver can check to know if
> > > > nvme power management is the correct thing to do in a runtime suspend
> > > > situation. Every attempt so far to optimize idle power consumption and
> > > > resume latency for a particular platform just leads to regressions
> > > > elsewhere.
> > > > 
> > > > Default to the simple shutdown since it is the historically safest
> > > > option, and provide a user parameter to override it if the user knows
> > > > it's safe to use for their platform.
> > > 
> > > Sigh.  The platforms really should be asking for a explicit D3cold if
> > > they need one..
> > 
> > It's too late now, but perhaps the new property should have been
> > inverted since preparing for D3 was the previous default behavior;
> > platforms could have instead explicitly asked for "no-D3" if they wanted
> > it. That would have been easier for backward compatibility.
> 
> I'd really prefer to sort this out at the platform level.  We can't work
> around broken platforms in nvme forever.

I agree, but I'm not sure how to get everyone aligned.

How about this to resolve the regressions: if the platform doesn't
provide StorageD3Enable property, can we just default to the simple
shutdown method? We'd only use the nvme power management capabilities if
the platform explicity says it doesn't want D3, making the default the
same as the legacy behavior.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8585df2c2fd..edd8f7dae77f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -3086,7 +3087,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
+	if (!noacpi && (acpi_storage_d3(&pdev->dev) ||
+			!device_property_present(&pdev->dev,
+						 "StorageD3Enable"))) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
--

