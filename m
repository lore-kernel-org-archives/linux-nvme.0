Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E6CC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 05:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O71Mu7pmCXquz0g3W9eI3kB9yxb8HLlsMA6ubVamasc=; b=15PhRnzAjdc0DSQn+yHZYYCuQz
	o5R2HYoFa0W6Fs+/u5Ekx/lkrx9a74okq1uIttmpOtzyu4yikpviquGaWok5isbnxkTHr0TeQSL2W
	06Tp9XsmvRfJUtFJwHVCTrWKh0sw47apzdRJ/0BoV6AySblNnirnr4sD9ergZPjHLM9MZBxCHlVvT
	V1oT7VUEepNPRaUJzSa33cNY+u3oJ785ltTLsbLQa41uQVGYPknFRh9hJsr5hIe5eskNmBDPSernJ
	QQ0u/rxnOXrODoS238a4YpZSIHYEAV/U2tVRBfVZItCZ6piVcoEs0gXkLMW0NI5a+PwF1ZNYuMaVj
	ZwDC04IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcfxR-00FF1r-2m;
	Thu, 16 Mar 2023 05:15:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcfxO-00FF0z-0d
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 05:15:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3EA667373; Thu, 16 Mar 2023 06:15:08 +0100 (CET)
Date: Thu, 16 Mar 2023 06:15:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230316051508.GA8520@lst.de>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_221518_382151_A8C51D8B 
X-CRM114-Status: GOOD (  12.05  )
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

On Wed, Mar 15, 2023 at 03:34:36PM -0700, Saeed Mirzamohammadi wrote:
> This adds a quirk to fix the Samsung PM1733a and PM173X reporting
> bogus eui64 so they are not marked as "non globally unique" duplicates.

What kinds of euid do they report?  Did you report the bug to Samsung?

