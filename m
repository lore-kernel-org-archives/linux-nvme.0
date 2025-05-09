Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA132C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 05:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rvd35D0ZGFtaVPzqe01gVL+IaoWmCIYL67yAdE691eo=; b=pZcdKsFxjjQ8W0+4LnEvZQq2bF
	1Twt+bfGBEDRd+FYJPYPM4XzV/FdRvLPXWJd+Hbt6EX3hJkoeGPp6Lqn8PWudMyLsMShMVYkwvzVS
	IPNupgZKf/nbZ11DNhFvtbdAf+byoEzdmiT4mPetv+NGjBIekULKCrMNxClqcB3vmMNW1LefT2A6M
	dH0rEg8wt21OPEZfOvWOT8pXDCoQjYlMPRhsZljwaKzVV0+GUFf2DcWIFX7QkGe5VRKO+sF5v1JZh
	Zhcn7VeCXdgXziLp0L+pz3bl/CssDZFf0TvY5aRTS9HsXbT/APxAdMZfE6ylFAd9tIJ5ftPkqnoca
	SzexaEVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFxb-00000002UBh-423S;
	Fri, 09 May 2025 05:07:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFmc-00000002TSa-0CAC
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 04:56:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E8AE67373; Fri,  9 May 2025 06:56:20 +0200 (CEST)
Date: Fri, 9 May 2025 06:56:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250509045620.GA29328@lst.de>
References: <20250507033536.work.088-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507033536.work.088-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_215626_235361_EB0CA324 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

Thank,

applied to nvme-6.15.


