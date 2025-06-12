Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D1C7113E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 06:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UtPymdd8LPXoV15uEH9uSYo/uGh6AqBmwQzP/RMvyGU=; b=k8f4Covkel6+Vf3JyNNSVZWUIr
	su0SzYbcdRcaeC6uYISgnorHsVjJFVLM8oGSkI9F5jf751SQyoJVPcnFqRMscdkzdN5hgQfayQtak
	S4ZbojAoKaU1OV/6PkJq1PupIchBfkQnTtzyvsszhBrNAwBf0ZI3VqlUDm6BjW42CFUO8hpYx5WoV
	KMPIG1zyI2ZRqjoLFkYCwqA9YTIgKuWyK/lsqN3BAs//bvalRQEfctR8RIIza9XyofZJI1jMk3WgX
	Jn/H5kHk+fDp5gWvJ+tz+DymaE7QdX8glmCtrn+UZSlemMlKehOAD8IIfAGRXVydn1WaGrpcwFRn6
	m66S/QNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbMr-0000000CJQR-3zCq;
	Thu, 12 Jun 2025 06:24:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbMj-0000000CJNS-2NvJ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 06:24:52 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250612062436epoutp04e65bac5d51bf370894d33db378d5fd20~IN3_k_8w-1827018270epoutp04D
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 06:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250612062436epoutp04e65bac5d51bf370894d33db378d5fd20~IN3_k_8w-1827018270epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749709476;
	bh=UtPymdd8LPXoV15uEH9uSYo/uGh6AqBmwQzP/RMvyGU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZjFpl50fvd9FHdWLEQl0C99J0G3ebipD+knz4D/naJG1SD3qF+48rISN9o/qClCDt
	 Fh/Wj92/qq4XRVFP7H9oxHvU9ySM4/D/wqInr3yDJY09HsA5aVA/oeK3+iBEta1B68
	 j821rwWpkKc1Uew6P7nc2Jv2bsn5z3qFJC3RP80o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250612062434epcas5p340bce2c2519adc20e0d234883a45f900~IN388h_cH1502115021epcas5p3a;
	Thu, 12 Jun 2025 06:24:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.175]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bHsv44bdlz3hhT9; Thu, 12 Jun
	2025 06:24:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250612062431epcas5p1eb2ce99af9b6aa2367d26b3db8804b73~IN36PhV6c3170231702epcas5p10;
	Thu, 12 Jun 2025 06:24:31 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250612062430epsmtip23f092a27f487341f12eb593eb6b30b36~IN349aphG2969629696epsmtip2C;
	Thu, 12 Jun 2025 06:24:30 +0000 (GMT)
Message-ID: <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
Date: Thu, 12 Jun 2025 11:54:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
	<logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612062431epcas5p1eb2ce99af9b6aa2367d26b3db8804b73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4
References: <20250610050713.2046316-1-hch@lst.de>
	<CGME20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4@epcas5p3.samsung.com>
	<20250610050713.2046316-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_232448_484929_12BE4D06 
X-CRM114-Status: GOOD (  11.18  )
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
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>   		return false;
>   	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
>   		return false;
> -	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> -		return false;

I did not understand the value of moving this out to its two callers 
(bio_add_page and bio_integrity_add_page).

Since this check existed, I am a bit confused. The thing that patch 
title says - is not a new addition and used to happen earlier too?
Or is this about setting REQ_NOMERGE in bio?

Flagging P2P bio with the new flag REQ_P2PDMA seems preparatory work to 
optimize stuff in subsequent patches.

