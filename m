Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3D7C61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QBxY6i1hqSd4pylENAx4FEqO/KN4GMI/7pdC+FYgw7o=; b=bCwiOtftfXDGFKmtCCwynfh4Q7
	bM2q/onMBnxYRyWstnRbHV8gfvcm4QuYxlzhy/R/cGRf6kNXU8tYBi+4mbzqlh55qLrvff5flstQj
	4B975pkcciNSVmXPV5rMVXIEOU6fsoJCoQL4+fyqBAeKO7G/jG10xaVBsLr3RT64iR58/vFP8mB6B
	E7OOa0AowZJe4/E3g17ytC6dlFXRZAOa2T6mLp4JnHpC+KPzFubbzUQRiAmshmckJsgwoGKHcIBg7
	i+lAtnL82I3peyUKqpyDOdhlFrbkT0z1VSxcUx8dPKitfLe5/rK4IFzTC1rni6NGvkIqQOBjo+zPw
	azGSlOIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa3p-0000000CBje-0P3b;
	Thu, 12 Jun 2025 05:01:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa3j-0000000CBia-407p
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:01:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A18FC68D09; Thu, 12 Jun 2025 07:01:00 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into
 a common helper
Message-ID: <20250612050100.GF12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-6-hch@lst.de> <6f0a019c-f9c7-4ccf-837c-c6d15492ba45@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0a019c-f9c7-4ccf-837c-c6d15492ba45@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220104_131410_9610F694 
X-CRM114-Status: GOOD (  14.32  )
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

On Wed, Jun 11, 2025 at 03:44:45PM +0200, Daniel Gomez wrote:
> > -static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
> > -		struct request *req, struct nvme_rw_command *cmnd,
> > -		struct bio_vec *bv)
> > -{
> > -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	if (use_sgl == SGL_FORCED || !prp_possible) {
> 
> I couldn't find any place other than this where the new FORCED tristate actually
> matters. So instead of passing the use_sgl tristate around, why not just check
> here whether SGL is forced?

See the check in nvme_map_data.

