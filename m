Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8806ACAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Z57HWHhmeJbe3uOMJPLcPGhncuy9jHuAInhkIIx/vg=; b=tu8/e2dCIcXB0Tobg41J2y8Cb1
	RMmmDVdSUBR1ruiLGRS8jj6/PQpIM1skIbQz/tnJoLk6oKJ/3BB9u6kO/PcUVD93dHt6Z9WmSviJe
	/DamNCeiUEaAvywmYYN28cVjh0hb8On8E3ZI/YpTtIaeNlZb03u1eKbUX1H9jJRilDiEmDWCCrPwV
	nd+2+p211a4yUHONJGar7DCqpyj7jg16bHz2cvC7ZRX8m2CbgGuv1yQgtLw/c2Ln+W95c4t4Q6b6w
	degz6D2D+wOSca2x6uXiUeTmZeK9HeIOQhvtKh1Sx4+wkGfPgibln2/SGo4ogGfaemC/7ZODjKCru
	TD27h7tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kS4-0000000B9cg-2A9o;
	Mon, 22 Sep 2025 17:35:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kS1-0000000B9a1-3V65
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:35:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDE35227AAF; Mon, 22 Sep 2025 19:35:40 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:35:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/3] nvmet: replace transports array with a linked list
Message-ID: <20250922173540.GC14393@lst.de>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com> <20250920234943.4959-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920234943.4959-3-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_103546_011771_D80EF98B 
X-CRM114-Status: GOOD (  12.60  )
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

On Sun, Sep 21, 2025 at 02:49:43AM +0300, Max Gurtovoy wrote:
> The nvmet_transports array was sized to 255 (NVMF_TRTYPE_MAX), although
> only up to 5 transport types can ever be registered, resulting in
> some unused memory. This change replaces the array with a linked list to
> store registered transport ops, substantially improving memory
> efficiency by allocating space only for active transports.

This adds extra code and makes previously const data structures mutable
to save a little bit of space, which feels like the wrong tradeoff.

What is your motivation here?


