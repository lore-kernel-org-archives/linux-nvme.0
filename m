Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD1C87FD1
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 22:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43efK+amVe9xh1y0u9Wd/m2eXNIDV7ce1Gg+9l8Z3Vs=; b=MSxao7Cr4fTbSDycxV1xMXuAiu
	yX5k4CvWDZjopAe6hrqsVuyEpRNDfUdvjsxoULMWSwA5p7h97l6wfCh8QtFPoQD+ipv05wNPsszSE
	388rGFuIkTMJUwqMsT561XRn5CeE/S5W+tY1Jh+R49ZqNnMVBq9eNkSSBOi7MvR0DEUt1wDx6kL+K
	YkHybuPL0olkgD6DRyF95CfA2L7lFNmnm0PEJmHa0Q1ih8HzzdqC+Q+A0zUnH2V1j+25ZRrfEXI5p
	urYSKRHI1W+cOTiKyxPaX1+T1GOK63oh7Y6FsHjEcM4zMTcncJ22UlpN53vr32fPjGxDTRnPRItqx
	MGvBLkGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujQW0-0000000DwKR-3bYb;
	Tue, 05 Aug 2025 22:52:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujQW0-0000000DwK7-0S8D
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 22:52:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 38620601D1;
	Tue,  5 Aug 2025 22:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBECC4CEF0;
	Tue,  5 Aug 2025 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754434333;
	bh=UXadAyFtTvjoHFaZZBoRwpIr7lKqKdukrW5AUWOJmYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDMOMMcFK5OQFTfpUzpGSgJFxyqXibd6wd+xQUTanSx2nwFFvc5A+utDElfDPcAhl
	 nFkakD4urWVsFe7uTQpHXSMQgvUOPV0iFigM7gnwQEKDw2YOvn+IdilqbC+4v/U1PE
	 BSLKuf4b4UE/eKNJixGWMia5UY+60IVg1cIfxZ0mpnq2IJEZaITO9t5hwkszgv1SBG
	 ooLuX833aP+T9pVMEoo7FvXbAt7T3Ymhbl2TG2O0SeefsBTo6h8aQQXbvtSGZPh994
	 UVmAg7XNCLtRDys+ho1hguKxWNw0WWoaj1xl9c0V+S1m1Px7y7ZLgK0u6TGxHdSJ+y
	 pDgLOgdYLRB2Q==
Date: Tue, 5 Aug 2025 16:52:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJKLGy9UkVjJTIIQ@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>
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

On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> +	bv = next->bio->bi_io_vec[0];
> +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];

Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
bio. I guess it's some stacking thing.

