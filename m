Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51DEC4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ou0OH/VlMBVjAtFLLWXDLRsKxGBmMhTELtW3Scy10QI=; b=gO5LYSy1ddt/LqOWiC9QWY0w+j
	+iNXX1UYW6WHIbi0Hw8V6KtVMXwb7FZh6ENz7mOqDN/kR9b7VVmgE6Xj3uG6MzQ0TAGK3VdbMOSyV
	W0L0cSER2h7RvdLUagGJ494YBauAhiasCn7NuP3Hzgfqd9KrXcE1wrgK80bW0YnY0mtcSphtN3Ils
	4E6XmQLgohavwG0VfC7N4uyEo9WRGjQusuyHR9LjKRFTpzWTKQt2xdpaXJNsMrkurYIKIdT0ObB4y
	+YH+0k4S2yYGLJEZs7hSoBlS35YCivCddiWPmY6HQcbpOQXhg+W3q24TUvLcKHt++2ZPihB9cNMgO
	4RQ790sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0irQ-0000000Fe2x-1vmw;
	Sat, 27 Apr 2024 14:17:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0irO-0000000Fe1z-2LnG
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 14:17:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D6FBB60FA7;
	Sat, 27 Apr 2024 14:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC98EC113CE;
	Sat, 27 Apr 2024 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714227415;
	bh=Na+9ra5c6HOeVkjiYeIyIYZNajmyn09tvJZtK9DS1pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3emSUjz+0ahZUdDclaFWuMk27w0bn3NKv1d3skqWdCQwWwZ9vfAFLgkbVBHcLYsT
	 nsCIK+ZaIohpY+msyXGe5LZqLq9r6tDdwpjEgW0l6hwAMIYJuKf/ZBhcUiJI18mKO1
	 K8QUxvkXALqEXQ27PTQ8PeKnsy0creMzLh01o65ADUJrAfMgmMwkwGkopjOeFf+c/v
	 RvvBfD19NqoMwCtWC5lcRwLNKIN3kX7HfKC2imxXG8aAVPn/JaRyYNP9B9pjvh1UtL
	 2IFjsoGPhelUcvqgGmarWsd7xxlpeHwKGolKX/yAsi4np0Xq3qREcZNQsDelxwv2VH
	 bP7JMXw3tQJ2g==
Date: Sat, 27 Apr 2024 08:16:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 01/10] block: set bip_vcnt correctly
Message-ID: <Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc@epcas5p3.samsung.com>
 <20240425183943.6319-2-joshi.k@samsung.com>
 <20240427070214.GA3873@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427070214.GA3873@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_071702_661395_C801BFBE 
X-CRM114-Status: GOOD (  13.48  )
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

On Sat, Apr 27, 2024 at 09:02:14AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 26, 2024 at 12:09:34AM +0530, Kanchan Joshi wrote:
> > From: Anuj Gupta <anuj20.g@samsung.com>
> > 
> > Set the bip_vcnt correctly in bio_integrity_init_user and
> > bio_integrity_copy_user. If the bio gets split at a later point,
> > this value is required to set the right bip_vcnt in the cloned bio.
> > 
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Please add a Fixes tag and submit it separately from the features.
> 
> I'm actually kinda surprised the direct user mapping of integrity data
> survived so far without this.

The only existing use case for user metadata is REQ_OP_DRV_IN/OUT, which
never splits, so these initial fixes only really matter after this
series adds new usage for generic READ/WRITE.

