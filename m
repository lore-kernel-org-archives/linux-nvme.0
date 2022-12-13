Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73183C10F1B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYECFOx+1/WX5tkUeIq/Ul/xG7xlDSRBG6ziierVtYc=; b=h1JyyTiyv/luGlkgkES2MbHNiL
	ZNJn3r1fUhz7HdPFVPo7pPVjg0n5MBxkMtB68DictUEiDZUTe06auPq9thVEVNaUL4UGrcEh6/r3X
	WTKqq/YrCQmlxdb9CLkKB/fESifEB+3nzC5ZzX5VUhfjPkuLszWcP5IlfACF4dZygZWNKwVHs+ULt
	ExFSFAC+9zPI6DYme8MKhjsF3E3raIL5d7FWC0zJEFPGXXavUch2f8jzJ/EPLRiV6xnLYDvw2Zr8U
	mU8I5+k4ODi/ocCQ4m1c4bepe1cf1qxvGewXMXZZorENq3nHp4JtyFrPy9Fbr33p2rF24ljdAQ1cb
	BKUkx+uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5AQ7-0058Xr-1a; Tue, 13 Dec 2022 18:54:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5AQ4-0058Sg-5s
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 18:54:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E350567373; Tue, 13 Dec 2022 19:54:15 +0100 (CET)
Date: Tue, 13 Dec 2022 19:54:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221213185415.GB14596@lst.de>
References: <20221213162453.584965-1-hch@lst.de> <20221213162453.584965-7-hch@lst.de> <Y5i8A84jGCnvLnbD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5i8A84jGCnvLnbD@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_105424_380483_E2569AB3 
X-CRM114-Status: GOOD (  14.44  )
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

On Tue, Dec 13, 2022 at 10:53:07AM -0700, Keith Busch wrote:
> Also nvme_cmd_write_uncorr.

Indeed.

> I think you'd need to know the namespace's command set to assume these
> opcodes, though.

ctrl->effects always is NVM command set if supported, or otherwise
empty for I/O commands.

> I was thinking instead of appending effects per-IO, we could always set
> ns->head->effects even if the device doesn't support the log page, then
> overwrite the log page's opcodes with known LBCC effects during
> initialization. That way we don't need a per-io check. Does that sound
> reasonable?

I'd prefer to keep OR ingin the known worst cases.  But we can do
that at setup time.

