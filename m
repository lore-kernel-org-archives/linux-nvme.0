Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF643CA0EE6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMirkc2jYuhoLkWn6g3tc/zu7BWTS2mjJ3h8QSa13pk=; b=AO/6lKnNtgl+CI7kNiUmwjSnmu
	2m2dWxpkC7/zbchFssGqLa8lQXR1/uqq4KB796Yq37DtxQcOYZdE9fpB8zQ7MLeOlNSquBl3Y1Gyx
	YbmCLKsCzsO6vMvhGkHvmNWtIPcdQI7czX0bPLRcHCGzLrvoDzrBrc3C+Wa6itFGzuJdwnQfr2hl/
	PeKockRdflXwLgqcchJ8SJcW1qtIDrvb3lUiHd8pxgXvvC7jd1ncKCxSZwbyPGg7aoxvLBw9Sr+ug
	CjAzys+3Ao6X8cqqok6nPfXpW717tkQEu5CbCgp6WS1+2spaTWGjSBRHi1zhKjeVqkH2E/H4h6kfp
	+g/XzZvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYkw-0000000HCpE-42Cj;
	Thu, 14 Aug 2025 14:16:38 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umVJc-0000000Gc3V-3xlb
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:36:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250814103609epoutp02d45bc79f33619c29761879def7584df0~bm8lu7l4q0814208142epoutp021
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250814103609epoutp02d45bc79f33619c29761879def7584df0~bm8lu7l4q0814208142epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755167769;
	bh=vMirkc2jYuhoLkWn6g3tc/zu7BWTS2mjJ3h8QSa13pk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jFDYWVVUjWEPvEWDPVw6Ih9+ucoJFun2CjtSp30PFTtM1yhA8bmH2Zfm7oJV2Q+fi
	 iTCgcl8YjoXuaDJQsypeZ9ebyFBlVXWOjWf5COVYsRiwsYqFngd7Xuz6ZRUHHLYdFE
	 gkeu2+gsGcdaGs1JZ7driwHN22JVf4roXlfSG9Bk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250814103608epcas5p205526093f113b331cd6c17935fe9859b~bm8lKsWJm0668706687epcas5p2r;
	Thu, 14 Aug 2025 10:36:08 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2hVH6lJ5z2SSKY; Thu, 14 Aug
	2025 10:36:07 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250814103607epcas5p2b8b562d3df9e005e3ff746d3b3f93978~bm8kJ-Ecr0668706687epcas5p2q;
	Thu, 14 Aug 2025 10:36:07 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250814103606epsmtip1f2a6eb39e6280c9fa84c7a1604d3bc01~bm8jUSAR72509225092epsmtip1f;
	Thu, 14 Aug 2025 10:36:06 +0000 (GMT)
Message-ID: <0cbb90b6-c25d-4700-90b5-5628690834b1@samsung.com>
Date: Thu, 14 Aug 2025 16:06:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/9] blk-mq-dma: add scatter-less integrity data DMA
 mapping
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-7-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814103607epcas5p2b8b562d3df9e005e3ff746d3b3f93978
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153221epcas5p19194a22c9206de885b1c3f04ad6e0e80
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153221epcas5p19194a22c9206de885b1c3f04ad6e0e80@epcas5p1.samsung.com>
	<20250813153153.3260897-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_033613_187740_CC09C69C 
X-CRM114-Status: GOOD (  14.28  )
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

On 8/13/2025 9:01 PM, Keith Busch wrote:
> + * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segment for
> + * 					 a request
> + * @req:	request to map
> + * @dma_dev:	device to map to
> + * @state:	DMA IOVA state
> + * @iter:	block layer DMA iterator
> + *
> + * Iterate to the next integrity mapping after a previous call to
> + * blk_rq_integrity_dma_map_iter_start().  See there for a detailed description
> + * of the arguments.
> + *
> + * Returns %false if there is no segment to map, including due to an error, or
> + * %true if it did map a segment.
> + *
> + * If a segment was mapped, the DMA address for it is returned in @iter.addr and
> + * the length in @iter.len.  If no segment was mapped the status code is
> + * returned in @iter.status.
> + */
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)
> +{

The function comment should also use the name 
"blk_rq_integrity_dma_map_iter_next".
Otherwise, looks good.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

