Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F8CC282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOkWzmN0SvUQ1/rRlGK67nYKsEwflg0OZDFhqDYqAzk=; b=JdqAGAHrKUrO+yACsXoXYaiQ0R
	tzuAfVQsHDA3gyYr3Qnm/gBDFjBd7Jlgsp5eIdlEN1wqQgQy/aAnfwDgj4wIwBOCACRyG7+mICwGX
	MCQ06rLXkwQ1Z+jIrZlfoxgJz6ogCDPUa98zF1T/t/E/eeOhcxNzoesyk2Hm/btpddstiqIRF4wzn
	UMZ2krcBOzCh90M7RH5G3j0oiIylO3jDOL+nFVDOAM0fr0nhF9H/k2Sm3bmvq4Btk/BoUDG+l6e/p
	tWqbLj+RjT7a5rgPZCq046pDC6dfngDtwki6dG2c2wwBBdOEIPmQZBB4cccYyPkx3+e0Kwc5IRnoe
	OENvAzUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trfKE-00000003FcA-0Lq8;
	Mon, 10 Mar 2025 15:45:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tredi-000000035L8-3Cc1
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 15:01:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6FB0A5C640F;
	Mon, 10 Mar 2025 14:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944F6C4CEE5;
	Mon, 10 Mar 2025 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741618917;
	bh=YMl5xuieX6js57Dy518+gGaDGljsePrvy3w5RpHVCSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDkkMHH/5Xn1lQDWUQ1Piq2pTt3/mmAsbxj5OWFtiLqP42+GeD77TO0ncuYzy2JGA
	 waLRxOjFdWFN3n5aj3moycObYTrbvXb2PrT5saE927Gfsol9xj7O8TjdnNFSTrLl19
	 T9zNW/p+/pvF7MnVEPSz0CEkXgRlpZBH3/ZqNSpibY4lYyCCc/zRs0OREls6LgEjE5
	 zyCmgnHmD55HAIeqBtBYNdjTdBrrABIrnbmS1Hkf5kmwu/TI5btMVoqEAsD3TZIkzn
	 Ly3WXwXlBmp8cpEKvlrTVEhB9SCLxPMOGOY2ZF+Df5fD8jc78Ve83DAdwuqqZz8tuv
	 QhAZIbSXeFFSg==
Date: Mon, 10 Mar 2025 09:01:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: simplify request ready check for pci
Message-ID: <Z87-43riMPw3jWqU@kbusch-mbp>
References: <20250307232655.2143570-1-kbusch@meta.com>
 <20250310132448.GB8835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310132448.GB8835@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_080158_840431_33FA25E7 
X-CRM114-Status: GOOD (  14.07  )
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

On Mon, Mar 10, 2025 at 02:24:48PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 07, 2025 at 03:26:55PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The criteria for pci transports' request ready check is simpler than
> > fabrics. Move the pci check to a different function. This also makes the
> > existing ready check simpler since it doesn't need to repeatedly test if
> > the controller is a fabrics type.
> 
> The change looks good, but now that this is split, the PCI version
> should move to pci.c, and the fabrics version should move to fabrics.c
> and into the nvmf_* namespace.

I don't think we can move it to pci.c. The apple device isn't fabrics
either, but is built without the pci.c module, so needs to be in a
header or common core.

