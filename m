Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE6AC05027
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dAt3hB+S9NO1vKom+Hq0CuiNYvum8GpgBYtr1HJO6Pk=; b=tgwnPmVZxoynrLM20tYowDDDIo
	klxJdhH3Nloq+11rbVQr5mNUmvM9EznrRzloqtumTPHilO/oWml6rY7C8KGkbi/Rlk1eufO7ZXpvS
	4FLK8mkuUiiKOy0jo6wDpBKIdgKacBjtZ9QgHNq9shNaUSSiLUQXx8yQa9uAeBb3HmwUNEm8lM5Da
	LMflC++MgMtLzZjSDR9BzeAuy4bq54C5gk65La12XAxvTy93nReQ6kPM8SQPhgrAOKKpotipOyKxE
	Zb+AeTMU1+s+MHLcXnWY0mhJOldqaBUV7HYxDaSdMwMJw9smIASrUFdfGhznCdASFVSWXcWWKaTrW
	todE+5LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQVGi-006K9E-67; Fri, 10 Feb 2023 15:24:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQVGe-006K6Z-Ti
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 15:24:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFC261DF7;
	Fri, 10 Feb 2023 15:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF8DC433D2;
	Fri, 10 Feb 2023 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676042690;
	bh=1PRcGPD7VPM7siynr1wVgz123PRtH1suYqj5IJPSzZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+yCIWyIcp1OTYt/bfaNUjbeoY0Zr2/vzXH7bW+okpvsltO6esSaXnmmEqgAn6qbQ
	 9hQW30DvQG0bX9YqdhQj6qVKFGdDIqe+vhHLJyKPbW01ZqBU2VXhQxVh8anNfh/AmL
	 EWz2N7TtZuL4wAeb2KX2ET+2/FhK4FmEqmPHlsjmPTqCFR5e9saW1JjRVhJthbS1Cd
	 hgv4slZCPDdvyR2why9TqSaokjIvWn7BQ5+kQv8AfTkwshKie04hiU73jAW05YEfNF
	 fxOPyhS1NM9bpF1uowbUAbE8igJtCEvHvyg4+KfhM4djWV6C7JR63y1M5bfc26Xy70
	 /8SHzQuSxpLvQ==
Date: Fri, 10 Feb 2023 08:24:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: hch@lst.de, kbusch@meta.com, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 0/4] nvme patches for 6.3
Message-ID: <Y+Zhvn1KwbMVmpGx@kbusch-mbp.dhcp.thefacebook.com>
References: <20230108182219.GD25544@lst.de>
 <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_072453_069574_DA6123EA 
X-CRM114-Status: GOOD (  19.71  )
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

On Fri, Feb 10, 2023 at 03:34:09PM +0100, Niklas Schnelle wrote:
> Hi Christoph, Hi Keith,
> 
> It looks like this series causes crashes on s390x.
> With current linux-next-20230210 and a Samsung PM173X I get the
> below[0] crash. Reverting patches 1-3 makes the NVMe work again. I
> tried reverting just patch 3 and 2/3 but this results in crashes as
> well and as far as I can see patches 2/3 depend on each other. Not
> entirely sure what's going on but patch 3 mentions padding to the cache
> line size and our 256 byte cache lines are definitely unusual. I didn't
> see any obvious place where this would break things though. I did debug
> that in the crashing nvme_unmap_data() iod->nr_allocations is -1 and
> iod->use_sgl is true which is weird since it looks to me like iod-
> >nr_allocations should only be -1 if sg_list couldn't be allocated from
> the pool.

Thanks for the notice.

I think the driver must have received a request with multiple physical
segments, but the dma mapping collapsed it to 1. In that case, the driver won't
use the "simple" sgl, but we don't allocate a descriptor either, so we need to
account for that. I'll send a fix shortly.

