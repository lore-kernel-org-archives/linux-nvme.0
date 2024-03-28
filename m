Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF8AC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X2pFXA+MkANZs0alHpiT0Hkdq8/tSBqcME8Fd1yEUF4=; b=Mb24QGplgAzRy2jn3hRj3QbZZC
	xZy9mJkUj47bHj1SU3eBiqx+S6TjNDBuJi001rlbAmJDiKoPU1KKQZIa4LS7d3Os2M5vtp0kBvBzD
	6aOX1J1gp0moBCffxO1za6Vq+kcJcTVoHnwzWbZozcL6jGfSXzSZCnzrcfLZtQZiEXUolwgBEhoz5
	k8+wWte97hAsmkMF6BhYqsdOosmG+qDlM/VJQXw+MPuP6IdUFAGjeA0fMokJakvVaBetHPds5p/KS
	C++NbQa7RJ+r4b1Jn/nz4JwjtuN5E1R3X+hGvevZPRiPrYiaJNmEZIBXXRuPqi63zEh1Xa73ovDnr
	ITj8gKtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpg39-0000000CD27-1kTJ;
	Thu, 28 Mar 2024 03:03:31 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpg35-0000000CD0H-1bc6
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 03:03:29 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240328030315epoutp049cccb2f40609962db7b39831bfbfea6f~AzpRijfjA0162901629epoutp04c
	for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 03:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240328030315epoutp049cccb2f40609962db7b39831bfbfea6f~AzpRijfjA0162901629epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711594995;
	bh=X2pFXA+MkANZs0alHpiT0Hkdq8/tSBqcME8Fd1yEUF4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=knctH0bMplqDCLKmKAgxEICS+sKahkkJydvA27RTzdYVJvGlOyOch2K7KtWaziIIc
	 9pIHLINQgaNFsJPQVfOzwQHBbbFgTu34LQM9r2X/u8DTZXJhMFZYlNHE5I3KcqfyxM
	 Z1he9akKbp1cTaqYF25lD07BHtkIslNYEBJi5e9o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240328030314epcas5p33c73395db2080137bb095606dc4e2761~AzpRRSRnM0685806858epcas5p3M;
	Thu, 28 Mar 2024 03:03:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V4pJJ61Hdz4x9Q0; Thu, 28 Mar
	2024 03:03:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.10.09666.0FDD4066; Thu, 28 Mar 2024 12:03:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240328030312epcas5p2bff483d6adc5e0d0296463587409dfbf~AzpPL5d5F0086300863epcas5p2K;
	Thu, 28 Mar 2024 03:03:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240328030312epsmtrp14d9fb04ba73abb31f6aa04b52bdaf417~AzpPKjSN60129301293epsmtrp1Z;
	Thu, 28 Mar 2024 03:03:12 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-1b-6604ddf0fa92
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.BE.19234.0FDD4066; Thu, 28 Mar 2024 12:03:12 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240328030311epsmtip15d509abf1a10268dcf226a1b353c850c~AzpOJSGl-2845928459epsmtip1G;
	Thu, 28 Mar 2024 03:03:11 +0000 (GMT)
Message-ID: <c30ca278-aaf9-095f-4602-9d09694e6564@samsung.com>
Date: Thu, 28 Mar 2024 08:33:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] block: add a helper to cancel atomic queue limit
 updates
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240327172145.2844065-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpu6HuyxpBld+6lmsvtvPZrFy9VEm
	i0mHrjFa7L2lbTF/2VN2i3Wv37M4sHmcv7eRxePy2VKPTas62Tw2L6n32H2zgc3j8ya5ALao
	bJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuUFMoS
	c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ
	z5fMYSvYw1nxp+EXcwPjXfYuRk4OCQETiYlTL7F0MXJxCAnsZpQ4u62HCcL5xChxbfJEZjin
	Y996JpiW7W9+skEkdgIlNjawQjhvGSV2nf4FlOHg4BWwk9i0LwekgUVAVeLhnvusIDavgKDE
	yZlPWEBsUYFkiZ9dB9hAbGGBYInJHa/BbGYBcYlbT+aDLRMRMJa4NvcXI0Q8TeL1l4lMIOPZ
	BDQlLkwuBQlzChhJ7L24kBWiRF5i+9s5zBB3dnJIHDphDGG7SMxYtRDqfmGJV8e3QL0vJfGy
	vw3KTpa4NPMcVE2JxOM9B6Fse4nWU/3MIGuZgdau36UPsYpPovf3E7BrJAR4JTrahCCqFSXu
	TXrKCmGLSzycsYQVosRDYtpEaNC2Mkrc+3iTeQKjwiykMJmF5PdZSJ6ZhbB4ASPLKkbJ1ILi
	3PTUYtMCw7zUcnhsJ+fnbmIEp08tzx2Mdx980DvEyMTBeIhRgoNZSYR351GWNCHelMTKqtSi
	/Pii0pzU4kOMpsDImcgsJZqcD0zgeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YW
	pBbB9DFxcEo1MKWFRM8Onrnz88PkN8H/z7LfuLFDe5+56DRl3dIX5qILGRfOFXqw9PxTw2lW
	tw88jH7v6MYttrDuj9O525WCV7Z63/mR/N1nywL97H99G7PnHrj8f3J8ziz1uztf1H94myP1
	VGhZUlPV9OdlU1cFJBVWZNh80n+/nrehyOGtSNxjF+cnTZ+ibmV+CiqeVrh51rS01CMSXS9v
	hNW8SZzrc7rG/aOOreVM+V/1nLknC6UnXvFcmh6f7sXeG/bgbZnul7PqBa668Y8Pmu8tneX/
	LKHzmPnpkJUX2uNKbTfe3Wmy7XxR9TpNzieHmRbOPuGlJNR+tvvMcqvDP6ds0a84ofSobbE9
	32e1Q5un1Z6bY7VaiaU4I9FQi7moOBEAsk5whSgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnO6HuyxpBpseS1qsvtvPZrFy9VEm
	i0mHrjFa7L2lbTF/2VN2i3Wv37M4sHmcv7eRxePy2VKPTas62Tw2L6n32H2zgc3j8ya5ALYo
	LpuU1JzMstQifbsEroznS+awFezhrPjT8Iu5gfEuexcjJ4eEgInE9jc/2boYuTiEBLYzShxf
	dpcVIiEu0XztB1SRsMTKf8/ZIYpeM0pc/jONpYuRg4NXwE5i074ckBoWAVWJh3vug/XyCghK
	nJz5hAXEFhVIlnj5ZyLYHGGBYInJHa/ZQGxmoPm3nsxnArFFBIwlrs39xQgyklkgTWLTx3CI
	Va2MEsc+zmEDibMJaEpcmFwKUs4pYCSx9+JCVogxZhJdW7sYIWx5ie1v5zBPYBSaheSKWUi2
	zULSMgtJywJGllWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwVGiFbSDcdn6v3qHGJk4GA8x
	SnAwK4nw7jzKkibEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TB
	KdXAVDm1Re7llw+SH6YfUzbmyQo/dXnX8U3vgh5IxB27P9nS67Z10J2u06VcnXWP5B+fKj3n
	l6vrK3mi+pLSZqfNRSqH7yY1Rs7J/nTzj8uNO73yX7b0HVt3pvvTpY3iyj4PxftWi8/aUm+U
	d1NshkPJQqMV3JLRcy5N0No50eDFS5WscFe2gl0OfHKPw6R0018ezp12pSZz4cuZqsk3FQqn
	zvS/uzVridT+lhePL18S4cwvdfy6T2HzIscv7moRq3n7jtyvjdy3WOB2wH5eva/Oyr66KXtC
	kn+vUf8eZXnWp+XglN091+WWG83aM33DNp6e1dtspi2uaPl70/Tl7qqgEH2NrZ/NZBW01HhW
	clRGz1BiKc5INNRiLipOBACyAK9bAQMAAA==
X-CMS-MailID: 20240328030312epcas5p2bff483d6adc5e0d0296463587409dfbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240327172205epcas5p356fffa2ae1916fa1479c2c75e4215cd1
References: <CGME20240327172205epcas5p356fffa2ae1916fa1479c2c75e4215cd1@epcas5p3.samsung.com>
	<20240327172145.2844065-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_200328_150833_6A423B66 
X-CRM114-Status: GOOD (  19.78  )
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

On 3/27/2024 10:51 PM, Christoph Hellwig wrote:
> Drivers might have to perform complex actions to determine queue limits,
> and those might fail.  Add a helper to cancel a queue limit update
> that can be called in those cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f9b87c39cab047..39fedc8ef9c41f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -892,6 +892,19 @@ int queue_limits_commit_update(struct request_queue *q,
>   		struct queue_limits *lim);
>   int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
>   
> +/**
> + * queue_limits_cancel_update - cancel an atomic update of queue limits
> + * @q:		queue to update
> + *
> + * This functions cancels an atomic update of the queue limits started by
> + * queue_limits_start_update() and should be used when an error occurs after
> + * starting update.
> + */
> +static inline void queue_limits_cancel_update(struct request_queue *q)
> +{
> +	mutex_lock(&q->limits_lock);

mutex_unlock is needed here.

