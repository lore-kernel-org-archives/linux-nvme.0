Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C41C282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iP5ye8zT3XIsvH+PNGvaZLaxESkuwYpIjYNZsfXOW/Q=; b=OKM4DzVsO71iEJ2bEF3UBtRv50
	/2d3xXuesHuJ/UrLqnKN4hra4jCfFOQzcOJZ+gTd/NWVjT4TuakbNPneMpScOvCqXe2JU3ax6RFrz
	1P4XLG5niYyVEmvSiCq4KH8UO/9qh5gSrrP6P/p3IYpguuDPymRiA6fusdMMMFo+k3w4/8pG/0v9G
	4cUHWiPyrSUvq/v+RXBGnMs1HwhgG3RXqFE6MNuIAbgRVThXuylLHQi0nqq36ZcPwAtsiuMcJeJaX
	+4dmKK43PGExMSc0OA2RuqGKXu6see9LsXO7W2K29lUYPeOOd2kwwr37us8P97UhzMLrKYJxip+Vs
	Yg17QBuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trfD7-00000003CZ9-0LD4;
	Mon, 10 Mar 2025 15:38:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1treHG-00000002xEJ-2y64
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 14:38:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E005B5C667A;
	Mon, 10 Mar 2025 14:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035C7C4CEE5;
	Mon, 10 Mar 2025 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741617525;
	bh=qPjt2HNHOrU8xnC8hYF6piHqZ8fvgELpU+TTqGWaDSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoZLQtB2CfOzsZYWHAHNJ5ZdOVspZBxyum3Fuhr4XeNvl4E2Y9m2InKFy9gd1BFOE
	 7QXxilfsOydkfSR3Xy3pRwfgO8MhwgCyp+uCMtuytrB3sNNFUxc7mt1mU2JTsaubtJ
	 IlTL/40HvUMpA1tTeK+u9BppgC54ZH9kZO4GuoOpYz++nGf+Nir/nMbVDd/8LGPukI
	 AzobZyZA9N2HVitqjZMN4v0Y9q0QWRCFByS+CsvQgF4c/k8aBQhW/YnxyZRdYo3ItX
	 L5hruk4XaGQLt8EUWA4E7Fvkq31U+BPl5ZEXDWXXghKOt+7BVDc7w7yZ3bcelz3VY9
	 gOA72rRSFE4VA==
Date: Mon, 10 Mar 2025 08:38:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: fix stuck reset on concurrent DPC and HP
Message-ID: <Z875cm31GNSTaiOg@kbusch-mbp>
References: <20250307002424.3655342-1-kbusch@meta.com>
 <46617499-17ea-44b9-9ed0-1fb5d238f54f@linux.ibm.com>
 <Z8sPwJw2oQH3slpT@kbusch-mbp>
 <3dcf210e-a714-4572-bd5b-01c66c594fd9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dcf210e-a714-4572-bd5b-01c66c594fd9@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_073846_790975_FFB6B69A 
X-CRM114-Status: GOOD (  10.69  )
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

On Sat, Mar 08, 2025 at 12:57:50PM +0530, Nilay Shroff wrote:
> On 3/7/25 8:54 PM, Keith Busch wrote:
> > If the pciehp removal starts after reset work's controller
> > initialization, then nothing stops the work from sending new admin
> > commands, and nothing will complete them. This causes the error_resume
> > to wait for something that will never happen.
>
> Ok makes sense, this appears to be a tight race condition and may not be 
> limited to one platform. This should be possible even on PPC.

Yeah, I also thought it was a very unlikely condition to hit, but I have
a platform that deadlocks here almost every time a DPC event occurs.

