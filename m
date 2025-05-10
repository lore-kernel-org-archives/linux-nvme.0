Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB4C3ABBC
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJa4+jEfJMXvq0+2QOrxdrucryIxvtjV958fZuz7fPI=; b=VzsjYlPuQtFklBXmk07pmjHu3v
	q6jMIOvum/IRvxH1wJbgUwz3a34oGHkQ/FZfbv9a64qnrAWxmRdqDKYtlno/63dasHZ++SIuSDtC0
	cvbOwatWjdCsH7/mKVsrkuRK0Gch9r4JEd5uZCuXMrOIw5KKaKoHT1/Hd2O4TiM4MGRUGnKKqLASU
	pTrq98LhhsEI5HGpmRg/lNUwJy+Pu9ZBlYTCRK6y4rnQk0bmSednhkRrbyWLpgmHIXeCPCByyq8uI
	huXn9BRqemnPa4z1zaaJ5QnyNfKwjJLKN+vAfInCDowkkn7knKGZ2vZ4G7qnREw7qJtnhl7Z/vOEp
	No1rEbWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDXng-00000005AsF-2XEE;
	Sat, 10 May 2025 00:10:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDXne-00000005As7-26DR
	for linux-nvme@lists.infradead.org;
	Sat, 10 May 2025 00:10:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A34A0629F5;
	Sat, 10 May 2025 00:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8347DC4CEE4;
	Sat, 10 May 2025 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746835841;
	bh=r6hz6WKcM3OOcqxFzz0dF5FTPCaB/AIhD8cGGMyJHE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPNaL0yWxUBk/GikkeGlB6+c4j0WYSVc0jMIR0dvbvug/QPvEaI/+sMYlEtrDumUm
	 rCIfvadqjiOigVmChkTjSv133hkiTB5mHmsibK6WZv+sZfTIxp0zG6Qa5x1ygiSNED
	 vIRtzAp8/T7PscyDCIGJRtFM1ViZHUagV7siOxMoK2NLT3KaesEcebxEKl/pLKJNLF
	 JiZXA6gtaPlfVjajZu7tV74X+2eW2TvCEujtMSvKIY50X7V7NxMW2n66Y7lAxbqTyk
	 +s6OuztrZdzu4aGMo6HkKnemW7Klw0Fqt9Pcushf6m9d9LasAcuCiTAWeTetaS27Mo
	 w3NBL0BAjHiVw==
Date: Fri, 9 May 2025 18:10:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized variable
Message-ID: <aB6ZfhTlhxrugPJS@kbusch-mbp>
References: <20250509235904.915626-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509235904.915626-2-wilfred.opensource@gmail.com>
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

On Sat, May 10, 2025 at 09:59:05AM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This fixes a bug where an uninitialized return value is used in
> nvmet_sq_init().
> 
> Fixes: 206372d7c565 ("nvmet: support completion queue sharing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505091619.QFU1fxsd-lkp@intel.com/
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Thanks for tagging to report! Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

