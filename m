Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E2CC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynv8wZmxyWWxEd2NKO/Huy/UH3LblhtRlHj68oT7By0=; b=kRsslI8BRGeChH6OW7B/VHGhIx
	WRm3+8cF+HAeWrAPL2LJog2CRuS6J0+EWI2+TSoFhRNrx8EDIcUxTD3Elsb4dKayxTzmGNoOzD++B
	n3659k7tsgbetmnZZF8UkI2WeCxXsd0+D2Kurf5w1s3Ee4Ku/YNiKuQip/gF4OxMSM+fclA4IMuq5
	ph0umyR+9kSPw3Fa2RFqZA8BTs0eUEr6tWQ9pTj5zOtaoII/DBweeiZpyRwOYiu6ne4c+8H7tNJ27
	FuGxryYNFxLtcOErdtws7gO1QjU8x+bZzsS6EehHZf98jZ0ioPvImGI+aYtnMiSERf+zQ6v79xmBV
	ijvf9/Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPTzE-0000000BTtC-1Mu9;
	Wed, 11 Jun 2025 22:32:00 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSbj-0000000BEyO-1ucQ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 21:03:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A25FA4C76B;
	Wed, 11 Jun 2025 21:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90164C4CEE3;
	Wed, 11 Jun 2025 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675818;
	bh=lOkgvtgj9sy7GnMiuVwjhGZzIQR4ZlGrFnLJICxuZS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq7bofy8svtSKuIOBunBaBGs1FW4TTIxY9w7MBLNAWILfVtutt55431YMfkrxs1jT
	 Yk4nj8qlWtay9tanIsEuIdFgbuiHOaBl26f0itnnICfEiVyQIJd0uJp+3QjAJQ5ZoF
	 wwKObOTHz1iAX9qThkQCWwwu1cSml1vKapXx5gWCgnHbU61I0JsU5cH/UNEtnDAG/H
	 k8ffCNeQhDIQhliNvu1qQkg235KVO09IB4TDLPLPJiEJXgK3YJeyug9iaV1+D/2W5I
	 dtJeF6dXwqQl8pMyqy/H0wqYhsMpGKOqm1YsBpokrU/ZD4W8JVxf4VcBZFXse+ILzi
	 ts+A7DfmSYiEw==
Date: Wed, 11 Jun 2025 15:03:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_140339_559918_7FA48E71 
X-CRM114-Status: UNSURE (   9.06  )
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

On Tue, Jun 10, 2025 at 07:06:43AM +0200, Christoph Hellwig wrote:
> -	iod->dma_len = bv->bv_len;
> +		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
> +		iod->cmd.common.dptr.prp2 = 0;
> +		if (bv.bv_len > first_prp_len)
> +			iod->cmd.common.dptr.prp2 =
> +				cpu_to_le64(dma_addr + first_prp_len);

Nit, set prp2 to 0 in an 'else' case instead of unconditionally before
overwriting it?

Otherwise looks good.

