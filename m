Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50488C61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jl54tlO36Yj/sy0HCZQHl9ZEKpPz+BY/+ex4PHQ9W4Y=; b=xe+3IWeRukvJsLYPPKCO+hAeAY
	0unCoB+BZJKhXCKoCe4MLlED30Mvksup0d1VF7Nqz4BSL7CaM5rB07XnDdh3FArCyJD/dNSrvHmOe
	1a2GxmhYEmCfPT9D9C3n8rZEMZM0d7k7u7DqXohNZWZCHAVTvkynn0Ciw87dnp1hGE7fhkPcZC7fT
	skRWZ3KMoPfI4cY4b3u38Nrho86vJJtLp+rw2INYKd2hINLUJ3FWfd4+jOjDoB3TX93GDUhwa28Pu
	yBgIBPQXPlKljfAxa+bauQS4EV7OsF0li3oCeLQC39S7jPTarKVK4bvUxGq30cP4YArsUB0bjJv0P
	cUFBBVyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa2r-0000000CBTI-3U45;
	Thu, 12 Jun 2025 05:00:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa2o-0000000CBSI-3JvQ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:00:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C947568D09; Thu, 12 Jun 2025 07:00:01 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:00:00 +0200
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
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250612050000.GD12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-5-hch@lst.de> <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220006_972173_63C780B5 
X-CRM114-Status: GOOD (  12.83  )
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

On Wed, Jun 11, 2025 at 03:43:36PM +0200, Daniel Gomez wrote:
> > -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> 
> FORCED implies SUPPORTED, what about simplifying to:
> 
> if (use_sgl >= SGL_SUPPORTED)
> 
> or just do:
> 
> if (use_sgl)

For forced we unconditionally enter the sgl branch, for supported
we also need an additional condition.

