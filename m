Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96D2C61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SGZHR6E+1XHwEXuH4bI7b8/heNltq39V3eoiOJ96fDU=; b=BRnt5o19AwIAHCCM4rfbtly5yE
	ToOfEEM0PYcZ48ghbkJ5WT0fjqjLZ8tVfbECUvAksOAWqdIgyeXTx7ZUtKHm0WqSZauQXiwu9HteF
	hDgiMW8XbE6EKvsVlthvHov1IdFigrMj3s2Jk1NgZXIphXTllhISo+gZTemkjtq40hWCDji8JAQyZ
	i9gvuid8Zy4VV8EZ2OAcQTj6qM+GEgA0vREC+nYnOKfLlxXPKiJdJgyL2L/BhGR8ya7naltkDgh9c
	L3AoxtYQK6QoyMt7ddF9G5MJFRWY0bhQb4BFxZwFSSbvfISnGyzIfO6P47LFxO+7F1oAGK0vwCJAD
	g/sYBM0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbY9-0000000CKVl-1Vp2;
	Thu, 12 Jun 2025 06:36:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbX8-0000000CKQ9-0XZR
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 06:35:31 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250612063522epoutp017b8ce5f1a18fe8f4c58bb2fea6246fcf~IOBYQkCft0515105151epoutp01I
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 06:35:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250612063522epoutp017b8ce5f1a18fe8f4c58bb2fea6246fcf~IOBYQkCft0515105151epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749710122;
	bh=SGZHR6E+1XHwEXuH4bI7b8/heNltq39V3eoiOJ96fDU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RJ0Bz0R9fN7S+zLXxBSR4ct75hfS3IEg0HX20m+zhKlpMVTw3SEi54p92wIJbVVNv
	 Tf4HRJNzNyRDmjKDyvkhlWV0vbFh6x36ZzMRJ5eLfJ/R3T71uTtvwRCjojoTdZAXvK
	 9gLOP73FdI8CfuOr7YFsfRGiWk2sh30TlNzaeT6Y=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250612063522epcas5p47e4907fd238737ef4195fd625fe6b3e8~IOBX3C3pT1936419364epcas5p4z;
	Thu, 12 Jun 2025 06:35:22 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bHt7X4yVfz2SSKb; Thu, 12 Jun
	2025 06:35:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250612063520epcas5p41c169bd6781f2df727dc980cef8ef1f8~IOBWAjQo_1936419364epcas5p4p;
	Thu, 12 Jun 2025 06:35:20 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250612063518epsmtip2cc0af3549ea92ff5de7d6a08bdc4c51f~IOBUt9gf40515505155epsmtip2r;
	Thu, 12 Jun 2025 06:35:18 +0000 (GMT)
Message-ID: <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
Date: Thu, 12 Jun 2025 12:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
	<logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250610050713.2046316-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612063520epcas5p41c169bd6781f2df727dc980cef8ef1f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c
References: <20250610050713.2046316-1-hch@lst.de>
	<CGME20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c@epcas5p3.samsung.com>
	<20250610050713.2046316-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_233530_328490_79EE8423 
X-CRM114-Status: GOOD (  12.48  )
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

On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> +static bool blk_dma_map_bus(struct request *req, struct device *dma_dev,

Both are not used in the function body.

> + */
> +bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, struct blk_dma_iter *iter)
> +{
> +	unsigned int total_len = blk_rq_payload_bytes(req);
> +	struct phys_vec vec;
> +
> +	iter->iter.bio = req->bio;
> +	iter->iter.iter = req->bio->bi_iter;
> +	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
Should this (or maybe p2pdma field itself) be compiled out using 
CONFIG_PCI_P2PDMA.

