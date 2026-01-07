Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA7CFD649
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lLfn0jmkAQ5wj8bh7Xk3IEwppDF45u8gpaGx52ycyU=; b=3M4Pi5OaDqSd8VDytmGJ7eqVeV
	xiwmNbU18A2sb6z7FudTC3nx6FF2R6jqujPuWvmmW2Aa9dDRWzT+M2c6ypRktMTkLDH5T5Au7EuSH
	RpZB88FwgcldT+dxtf0+6PyHHQuHJK3/ZFTF+7gdKaL7ZHvJb2Ad32S1+2cszIkZusFuau9kwivNh
	SrzjWS6tgIFH3kTsMKm7z437dDWHgBdO6jOe+qmKLu0+WLzt/pf4UbmxsfVGLPFytiKWUuvlkefUY
	zYeonR1O8NkUXfLoMj1MOloEjuwhlcClwzo+ebnJyQH5g7P11wOSW3qTcH6Bl96LOO9CE2ih7Ill/
	dNrDCvZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVaU-0000000FBJ7-3kiR;
	Wed, 07 Jan 2026 15:36:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVaS-0000000FBIf-1nyu
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 15:36:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60E48227A87; Wed,  7 Jan 2026 16:36:36 +0100 (CET)
Date: Wed, 7 Jan 2026 16:36:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260107153636.GA19836@lst.de>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com> <20260104151517.GA563680@unreal> <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_073640_608654_DCF23112 
X-CRM114-Status: GOOD (  10.95  )
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

On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
> > Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

Fine with me.

