Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CBEC5478C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzQuRnvFegCz6n9ZTptM5GqU+gNy5W7lbD5tBaPg1NU=; b=jKn1+tImAZDHtbHDNrizfD9H29
	Emj2hNOijzx6TDsvt8wp0DR8sxyFySZtvACh/kulgPxXH/wy00FhtI0zOW4/DlZ8Nax96fpA5AqYz
	zWfocsQ5ensRQn6TZ8jY/NvYJDeYs6ul4cb8w5vet3dvYH/s3G/N5LB3HV638kUtdVDHT3WbCAd78
	Ksf6iGeYO+QxIIVzdhpIYjrku6NS+ngsAy6ItrkyuV2qCboM5boMAD3j8X9Dl5ymxDMrJckSBiA+P
	iUzUSJD6pJx6l6TzXMoPG+64k8ManMTjdnEkYMhNNO/6HzTUdxdXoH5uYPU2R1XxOGN2xfVFelhmX
	4cxF4MWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg5cm-00000001458-1Hm0;
	Fri, 01 Mar 2024 16:20:40 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg5cj-0000000144W-2hXA
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 16:20:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 91BBACE08BE;
	Fri,  1 Mar 2024 16:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387BAC433F1;
	Fri,  1 Mar 2024 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709310034;
	bh=Q/6VTHUKNf9I9FR2ySABVg9EyTZVleFCvryEkQoiKKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppqohgi3b4Z5DCU8Ta0SyRg9u6t5r4/HdbdcfJPZ54w/JS2bRcH/hsEEHBhfmfnBm
	 mZvZPjP4Ru6eAQeL4VRWjgLPZ7jvzPJjMItuZI+DDu8x1dUp7lBwEOoIFxu0+nwwWN
	 p8bz9SGCJbVhiMajfgwmVfyPGbq6XXGxxPxBfjOdBjN5RUwX1CckMkJQ8EK+Z8Z7Q2
	 Rt407m0SnOA2251ur2MjHeRGkaw/NHTXGlxElGixKkTDFkxbSPFF+PWL4OvbBbs56d
	 fBVutx11VumgV4ZlEJVwCPjo0G6YmO5JCDsjWj2Jho04QPgO7mcejFGAfwHqd8JUek
	 gV3B89gdT3IMg==
Date: Fri, 1 Mar 2024 09:20:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: convert nvme to atomic queue limits updates
Message-ID: <ZeIAT5uY36cLkVpJ@kbusch-mbp.mynextlight.net>
References: <20240228181215.873854-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_082037_883792_9B02FE25 
X-CRM114-Status: GOOD (  11.37  )
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

On Wed, Feb 28, 2024 at 10:11:54AM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series converts nvme to the new atomic queue limit updates, and
> as part of that refactors a lot of the setup code.  The first two
> patches are block layer patches already sent out as part of the md
> queue limits conversion and will hopefully get merged into Jens' tree
> soon.

The whole series looks good. I see Jens has got the first two patches,
so I'll rebase nvme-6.9 to that and apply the rest of the nvme patches.

