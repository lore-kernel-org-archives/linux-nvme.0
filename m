Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A61D64063
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYZLJdRBmnAX7h0qxtj44k+QSmOgBM9E1XmGwspN4Ps=; b=CcSAvdwEvCta82O4IbNgI4GHPB
	YLUZE+G12hxdgnTwKm28ycTrcentqwrAOjVv/1zUYuwwFb0IApRo3ju4rnmFSOvCXPIjAJy/ybKO9
	+SSXUKN7VzKSvSVnp9iNAcbcbijnqON3qNce6ES5tk9lnccfjUWm66xKcWIj8/N/s4hdaJ3mcVJlE
	vXy2GwjCQq1PA6tTduTg3qr8d7SkyhSABrKKcLcR32UFrxGEcUKtRXfn/Rtk/tYBvMfzIR9Aqms0t
	4gJk6rIFRANIDN6eA6fxsZcgUhf0v5NmWPBtjg7e5OIx47LYrQQJYWC2Ur+B46W511jSJ0pJrTwS9
	FJXRYpAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RvS-0000000BEYO-3Son;
	Fri, 08 Nov 2024 16:33:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RJM-0000000B7HQ-2W4y
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 15:54:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 11F4FA42780;
	Fri,  8 Nov 2024 15:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A127C4CECD;
	Fri,  8 Nov 2024 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081251;
	bh=FYZLJdRBmnAX7h0qxtj44k+QSmOgBM9E1XmGwspN4Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hplJG9ErCpNB9XJ6fAYcU8U56RDnm8RhtgDU8opA7VwgkNRT/Z6riSKZKlaTz6z8s
	 FCTSd0W7kIXqXV2bnB7HOA6vONtBedaWIaWMOJ5hT2waZrv3XUwMmtWj4pflGSq9+F
	 mELHMr8l+UvlIXIFOr6hBmIEdjQUETVlPMi9aNMboFGGbrVwecpxRw29a7zgqdHakk
	 HBF5KXjZTC8G7xALckURD1HLp8Js0bfdcGrnrpkV39D3j+1RSsjO3kORmNXJ5zshFp
	 T3LHvy3MaAlmbdoc+Iv0m/K6uZ90QHovAOWwRl6EHEDCmJG7TOJuWHJ1WkqzVi7fhG
	 6q0/gVAdCh/Sg==
Date: Fri, 8 Nov 2024 08:54:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix the warning of assigne int to __le16
Message-ID: <Zy40IQ8KYcfAsLdH@kbusch-mbp>
References: <20241108083030.22555-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108083030.22555-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_075413_027726_81064502 
X-CRM114-Status: UNSURE (   7.21  )
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

On Fri, Nov 08, 2024 at 04:30:30PM +0800, Guixin Liu wrote:
> Even though NVME_CNTLID_DYNAMIC is 0xffff, we still need use
> cpu_to_le16 to translate it to litte-endian.

Folded in, nvme-6.13 updated. Thanks.

