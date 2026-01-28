Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B38D35698
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 08:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0zUrA66qVdQUteKftTzbeg7hwj5Ihkp/J+jyknQ7MU=; b=473zaCAnCX8fpg9qgpIP/FB3rJ
	81TOR8btYNFxw2fjaPpyIswDifYQGevsgHQRvvyR4UTljH7fvlR3RZtSfchYzZA/WgkaGBjecRfrT
	YL+MI4nvHXf5sR1VPpiBxJzoWBwLnkTCe8CoAttKN5TxetI0i7XGTsADt+u8JXKEEJmvI52RIs5jL
	qivZQ+rlrCwUahO5HwFA62nWcx3gWMiCUjLJ9omZhuyWuczsvqObP47vncH/QiP8+jiyX/bJQEC0R
	bheJU94may0S9mbzYi6zYXxYZynP6WUP5jaV/PsXw277q9bKo3cqRAxDSTS1JB/Hrp7Q+W5gnwlKj
	tmwGqFzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Fg-0000000FgvP-2us0;
	Wed, 28 Jan 2026 08:50:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Fd-0000000FgpA-2viZ
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 08:50:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEA75227A8E; Wed, 28 Jan 2026 09:49:58 +0100 (CET)
Date: Wed, 28 Jan 2026 09:49:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Message-ID: <20260128084958.GB9373@lst.de>
References: <20260127195907.34563-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127195907.34563-1-roger.pau@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_005013_894464_24991EFD 
X-CRM114-Status: GOOD (  17.03  )
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

On Tue, Jan 27, 2026 at 08:59:06PM +0100, Roger Pau Monne wrote:
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.
> 
> Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> If possible it would be good for this to go in 6.19.0-rc8, as corruption of
> the root device as part of a kernel update is unexpected. Sadly 6.18
> already contained this issue, and no-one noticed, so its impact is limited?

This only affects non-IOMMU paths with a non-noop dma_unmap_phys.
So it is a very common setup, but very severe for those.  Because of
that we should get into 6.19-rc and -stable ASAP.

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

but maybe we can reword the subject to sound less harmless, e.g.:

nvme-pci: DMA unmap the correct regions in nvme_free_sgls

?

