Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254BBEE6456
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXG+rcvlGvY+Yc++pSoQYypxL9xzAnLx/riyDqkmASc=; b=w0b0Yh/K4jpRjQmEn+fL0l/chy
	BQRhayxhFUFY2bLzD3O09sid3R9jK8+5epvJjf67wrDXUvJ3ZyJTTT4cKRNSRJ5oLJ/jTrdoWjHuS
	GPvBaGO7dggYJBazhLK+gCuBFDQo5AD1D49E7LRzSe54aBY6jlVmWgCY37MGRt8JvFkn68spb7Ras
	wp7GB1Yk2ozooupyZBn36v+ly5C3nL31vPBIP1wmeuvr95bgUORaodb4JFPRuesc8erojG7sxLtmp
	LLlnYFv62APOeE3siKdR+ewdzvT/XSXOayWSJjjvFDSAnreIKXZwZqDsZZ/ELY2qKxc2V17UJygm6
	RA1V9aCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodqR-0000000C683-0088;
	Thu, 12 Sep 2024 07:02:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodpG-0000000C5pF-1aPw
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:02:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70047227AAF; Thu, 12 Sep 2024 09:01:06 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:01:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv3 06/10] blk-integrity: simplify counting segments
Message-ID: <20240912070106.GA7572@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-7-kbusch@meta.com> <20240910154105.GF23805@lst.de> <ZuBua91J2X5Yt-72@kbusch-mbp> <20240911081720.GA7372@lst.de> <ZuG3JoOq-XaLbBo4@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuG3JoOq-XaLbBo4@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_000110_580572_058D6A6C 
X-CRM114-Status: GOOD (  15.14  )
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

On Wed, Sep 11, 2024 at 09:28:38AM -0600, Keith Busch wrote:
> Would you be okay if I resubmit this patchset with just the minimum to
> fix the existing merging? I agree stacking and splitting integrity is
> currently broken, but I think the merging fixes from this series need to
> happen regardless of the how the block stack might change when integrity
> data is set in bios.

I guess everything that makes it less broken is good.  I'm a little
worried about removing some of the split/count code we'll eventually
need, though.

