Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FF2C4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xr1BVpBx5gGSh0GJllWvUW66rtyt1zKXRdwrSLE/NmM=; b=WjBaPpPr34Y6+LcJBaBB5DSY9o
	aijkVpHOGJKtWaQHqFIoxjGJjoME371rOGrYIfeXt4zAHeS3ckKQyKG0Drv4bYGP7Sj+zeYFJ2aK2
	xRueFN6oEk849cbhE7R5529BuU6oB2dHjhQwwG1Gr8cudgPfpk1tvFPI3VeWDW2qF7mi7wQJqtPGu
	0AhFIVf7uajUjpcNG7dMaer+c7vY4vdMYeS4kfcrwo6S8MvncTHgD/bQ/VbMluYNLkFg/4tN/aapp
	qg0o10GfKXvxOVK8ROU5kw+Xpsc7WxQHx5HjIc6hamnuV3G4P1J+4KmhhsrPrE7mcqBw5dVh7Y5xN
	eZOMB2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24r5-00000008oTG-1rQl;
	Wed, 01 May 2024 07:58:19 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24qz-00000008oRn-0Fv8
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 07:58:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2ECC1CE1287;
	Wed,  1 May 2024 07:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F84C113CC;
	Wed,  1 May 2024 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714550288;
	bh=XbPXO8uiXn/yqRZIoVW/kPSUpSaN6MCQp/NIAU5fQhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7xYCCCEc8fpUGC04UkHSJnQnsk9WYYaCSLRWAAyOIpLlQXmwIFVaP4qOcftS8j1L
	 ufqVAUMf6cNN9zK118tyq29Sy9y62FQtcWIO8XkKacmaJgeBtotOzEmvqxjmhFqBRI
	 QzN9SNseuPyt5KBUNF3ZqMn2kLqHjZHzmIB0AWbSFWCxh9rCNt1JsnKsMEWSKtHsUr
	 eR+ZP5D779niNwUPQ67GvVDThpVjfWG/h5g6jNN9PdBEUCO8Xpe+5bIyhVKwVb8tki
	 YysArIfJLk6AEiW5jZv0RS/tl3DhvmP3UxmPIc6U2ZnkSzE5qbCL6/SMKMiMT5uKOA
	 ++K52vuhZHKrQ==
Date: Wed, 1 May 2024 08:58:02 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK
 hynix PC300 NVMEe
Message-ID: <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501045145.GA32110@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_005813_320925_A90CB90C 
X-CRM114-Status: GOOD (  14.58  )
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

On Wed, May 01, 2024 at 06:51:45AM +0200, Christoph Hellwig wrote:
> On Wed, May 01, 2024 at 06:29:12AM +0200, Paul Menzel wrote:
> > Could a warning be logged, when this takes more than 50 ms with a hint that 
> > the disk vendor should improve their firmware?
> 
> Not sure why we'd warn about it.  A clean shutdown can definitively take
> some time and there's nothing tha forbids it.  I don't think a linux
> message is going to have any effect on firmware engineering..

Exactly. Unless the device reports a lower D3 entry latency, then this
sounds like everything is working-as-designed.

You can check your device's advertised shutdown time (assuming your
device is nvme0):

  nvme id-ctrl /dev/nvme0 | grep rtd3e

The value is reported in microseconds. If it shows 0, then the device
doesn't report an expected shutdown time.

