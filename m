Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD83C87FC9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 06:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCAvDXDelKt6cfEkBOtN1pGCZsc+ckqH5BOvF+vS/88=; b=ebrE0po7ScbYgT8bpHrX/pYG6i
	w5KI0kAQf8ZVPwnvhPNGgwPof/07tTrxDRrBahr8lGtC1QwGVHyCEQQtwrkafXax8SLQlUwokqOSs
	J3uMvQegddHaPxa5qtwGTbCezEATc6FnYUgyurUzhwYNtVYB/SERrg4O8y0CeAWCAfec7V08HdRpl
	YgFBaplAPvV32c8+AOSSsquby2iCysBje+Pze0CjcqsxDsyi+a0aNpOvWkmDEks0q2JqcsQSfTSL7
	9AtnvA4eObWAdPyaAYgMk+T8jPjzMWXqcpXSlznIBtAVzElAU6cy5fSJ+YcG6utwkYEiQ+TZKm3Dl
	de9sGSfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh0gK-00000000pDf-1O4z;
	Wed, 30 Jul 2025 06:52:56 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh0gH-00000000pD0-0BEv
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 06:52:55 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250730065244epoutp03c6ffe3bd6c62301350687e48097359cb~W9OP4Qogv1461014610epoutp037
	for <linux-nvme@lists.infradead.org>; Wed, 30 Jul 2025 06:52:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250730065244epoutp03c6ffe3bd6c62301350687e48097359cb~W9OP4Qogv1461014610epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753858364;
	bh=wCAvDXDelKt6cfEkBOtN1pGCZsc+ckqH5BOvF+vS/88=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=h2JuiVJnuw4BbKU0ytZzwwdNqggWLKrXlURJpNM20xyUxWWlDBktJZ+Lw2TeCF2zM
	 YVdip3xtw4IGwI9/UhI9LGJrdDJZhYPZ0L7fJyoVfdOOXVtzs5ogP0UJaDd1UyejnP
	 CncsJTPrbg6YlIxaFBD1d3xIxqdzLp3MkKVQaCUg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250730065244epcas5p16535b56a459c7e04df9452aa5051e495~W9OPmQ7ME0097500975epcas5p1t;
	Wed, 30 Jul 2025 06:52:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bsNFS0yn7z2SSKn; Wed, 30 Jul
	2025 06:52:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250730065243epcas5p3750a9faae68daf85b1259ed2cbf0926f~W9OOdDWyt2796927969epcas5p3z;
	Wed, 30 Jul 2025 06:52:43 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250730065242epsmtip2fa26c948125d1721c0ff4b363b1da96e~W9ONe8Zme0229502295epsmtip2Y;
	Wed, 30 Jul 2025 06:52:42 +0000 (GMT)
Message-ID: <8b32b82b-095f-4f2c-9a21-b4cbbbca52c7@samsung.com>
Date: Wed, 30 Jul 2025 12:22:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730065243epcas5p3750a9faae68daf85b1259ed2cbf0926f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143518epcas5p2938dfecb7c1596adfa1802d46c75a75a
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143518epcas5p2938dfecb7c1596adfa1802d46c75a75a@epcas5p2.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_235254_380188_23C9AEA5 
X-CRM114-Status: UNSURE (   7.45  )
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

On 7/29/2025 8:04 PM, Keith Busch wrote:
> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> -	if (dma_mapping_error(dma_dev, iter->addr)) {
> +	iter->addr = dma_map_page(dma_dev, phys_to_page(iter->iter.paddr),
> +			offset_in_page(iter->iter.paddr), iter->iter.len,
> +			rq_dma_dir(req));
> +	if (dma_mapping_error(dma_dev, iter->iter.paddr)) {

This should be
dma_mapping_error(dma_dev, iter->addr).

