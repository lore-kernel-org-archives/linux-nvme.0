Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B2C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ak7BllBkpCy0LOC2ceYoHbbbv17HIFTXhICVNfOqvuM=; b=pYMJ1G0d+WMJ4TCBKhYA4B3L51
	S5MRe6PaB0u9K+7fyewtMky8qjFqqGGgZxcSCzj/F+AEXVs40Gnc5O5OMj1/QL5YNJLhB7GGEAoTj
	NLlLHqsLkYqz2cYgcn6yQZjf+t8jh6sTnd7D8iV1aWhKqYLg1r6dikDaaI2BmYJv3olTKAW1ay6zx
	Nk8+2Ld7zPjRNRR8eEAlp5BRQyT8hAqJM3RZXhEegNwhav9Qu6jhFUHRKu+/ijMH0qq+1nOJV3XXc
	OOZRvZ9L3vDKxObstTedyDCByjeEHWu73XWGqBNACD71LgSU1tinFVSMaMoMo9FinYeaB+uoM9xeI
	QPBOxLhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpmuw-0000000DY2a-01dF;
	Thu, 28 Mar 2024 10:23:30 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpmur-0000000DY0g-1Kg6
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 10:23:28 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240328102317epoutp013b637a5aa07bd4808c6c73f070a58a43~A5peaXeqD0203602036epoutp011
	for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 10:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240328102317epoutp013b637a5aa07bd4808c6c73f070a58a43~A5peaXeqD0203602036epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711621397;
	bh=Ak7BllBkpCy0LOC2ceYoHbbbv17HIFTXhICVNfOqvuM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ohCvGyy6DT6nhNzeCbJlXvf1daAOyR4LEvx/FUp09nL968r4nFsjHInnnz1ytkojw
	 NcY9CbqCYh3MnTnUGcI/+9PwdGi+M0j0fOveV1ILixzbOcz4I7jO+F5IvH4vZIGZ2A
	 w+VT2QSCGNg3++gygtNX5YfdKBNx/9Dpi+b97bnM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240328102317epcas5p4b9e40b72b28dff14b8a1c12977d1ff09~A5pePv-Ju2556825568epcas5p4W;
	Thu, 28 Mar 2024 10:23:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V50425Hf2z4x9Q3; Thu, 28 Mar
	2024 10:23:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.94.09665.01545066; Thu, 28 Mar 2024 19:23:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240328102312epcas5p12ec89d12a1a554d0af691971d6ab0bf1~A5pZyuzhq2024820248epcas5p1v;
	Thu, 28 Mar 2024 10:23:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240328102312epsmtrp177c3695b8f84d64c16f6cbe739796155~A5pZyKqeF1943819438epsmtrp1N;
	Thu, 28 Mar 2024 10:23:12 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-0e-660545101c2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.57.08924.01545066; Thu, 28 Mar 2024 19:23:12 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240328102311epsmtip29f5b19434f706f6a89c3769092f3241c~A5pZFbLE50423004230epsmtip2W;
	Thu, 28 Mar 2024 10:23:11 +0000 (GMT)
Message-ID: <ab290729-dce9-826d-db55-b6b8202abc7d@samsung.com>
Date: Thu, 28 Mar 2024 15:53:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: split nvme_update_zone_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240328062030.2915583-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU1fAlTXNYMpNbYuVq48yWUw6dI3R
	Yv6yp+wW616/Z3Fg8Th/byOLx6ZVnWwem5fUe+y+2cAWwBKVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ0x6/1VpoLLPBU9uy+wNTDO5+pi
	5OSQEDCRuP6uk72LkYtDSGA3o8Tuxv+MEM4nRolfF44zQzjfGCXuXb/HDtPy4tlPqMReRonL
	v1exQDhvGSVebLgLVsUrYCextnUzaxcjBweLgKrE39+aEGFBiZMzn7CA2KICyRI/uw6wgdjC
	AmYSZ5Y+ZQWxmQXEJW49mc8EYosIuEvM/DCXBSKuJPF5/1x2kJFsApoSFyaXgoQ5BYwk/jfM
	ZYYokZfY/nYO2G0SAi/ZJT6/v8AKcbSLxOJ/G9kgbGGJV8e3QD0jJfGyvw3KTpa4NPMcE4Rd
	IvF4z0Eo216i9VQ/M8heZqC963fpQ+zik+j9/YQJJCwhwCvR0SYEUa0ocW/SU6it4hIPZyyB
	sj0kNp3eBg2pVkaJjyvnMk9gVJiFFCqzkHw/C8k7sxA2L2BkWcUomVpQnJueWmxaYJyXWg6P
	7+T83E2M4ASp5b2D8dGDD3qHGJk4GA8xSnAwK4nw7jzKkibEm5JYWZValB9fVJqTWnyI0RQY
	OxOZpUST84EpOq8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqYm
	oZKzDzIENmsY2j378CGuy7LY8xeTGcfna1tcTzn/S/DXEa/YabfD/1zX2QsvL9Qfm99Xfy3n
	RljVNOl5j9sEz+75NDcz++MUw+TXK2Ze/HQoJ0J9bqenxnzpvNUc8fpu+6cqXop/Kf84RqG8
	7tnV7ZNLWR/s2rQtKvmIaCznpfsT/jndOfKA/VSjGM8dwcSM9xpTL3v3eskqR4loa9ro/LET
	FchOlMlvOPG3o6FF/4yl99YlSYnv1VhuH9IwEOQ0Wez3iM/LqFF5/uKg19M+xq0T7j3oMvtP
	mrdwkPQS8fXR8X9snxfeup7903mS68IDxcvkPvCvuP7vCB9PgYjSk0Bt16kmFc97xP5e+6PE
	UpyRaKjFXFScCABhS7RWGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK6AK2uaQcNiHouVq48yWUw6dI3R
	Yv6yp+wW616/Z3Fg8Th/byOLx6ZVnWwem5fUe+y+2cAWwBLFZZOSmpNZllqkb5fAlTHr/VWm
	gss8FT27L7A1MM7n6mLk5JAQMJF48ewnM4gtJLCbUeLiaheIuLhE87Uf7BC2sMTKf8+BbC6g
	mteMEtPm9bGBJHgF7CTWtm5m7WLk4GARUJX4+1sTIiwocXLmExYQW1QgWeLln4lgc4QFzCTO
	LH3KCmIzA82/9WQ+E4gtIuAuMfPDXBaIuJLE5/1zoXa1Mkqs/XSEBWQ+m4CmxIXJpSA1nAJG
	Ev8b5jJD1JtJdG3tYoSw5SW2v53DPIFRaBaSM2YhWTcLScssJC0LGFlWMUqmFhTnpucWGxYY
	5qWW6xUn5haX5qXrJefnbmIEx4KW5g7G7as+6B1iZOJgPMQowcGsJMK78yhLmhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYml89mmw2XsLptmXWqpHNh
	8tabt9oud2z4X/JT4tqsOVJcuzWuJ6Qe78qplSvZaSUcoLp2tb90lZZTFQ/fxchJ0T5aUYES
	LQ48C77W+vyfUey19/zHXSHvBBiqbs9vfnK1p0k2+1yd7smlj09MSL3y2kv6EY8+rxozhysv
	j3m1Ux/n1o3Ky3QuHnzfWxouFHGozv/AnlKd/DbbY0k7qxpkLBj+1K31MH7w2+1LtbHV24pc
	Nedbfo7aZnGs7zNW27dH2otwZXgtVJSMEpYrnFsamXg25nieTqxedqq7otx8hr3KJ42urNnT
	e0jJKqtR794Jj6hz1/f4Sr3YtZQ1acETDQMfhiLPuJwFzxialFiKMxINtZiLihMBtebzk/QC
	AAA=
X-CMS-MailID: 20240328102312epcas5p12ec89d12a1a554d0af691971d6ab0bf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240328062037epcas5p2670e1a50a03b3acf5120fae089ea10a8
References: <CGME20240328062037epcas5p2670e1a50a03b3acf5120fae089ea10a8@epcas5p2.samsung.com>
	<20240328062030.2915583-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_032326_930354_6CB9E26A 
X-CRM114-Status: GOOD (  22.65  )
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

On 3/28/2024 11:50 AM, Christoph Hellwig wrote:
> nvme_update_zone_info does (admin queue) I/O to the device and can fail.
> We fail to abort the queue limits update if that happen, but really
> should avoid with the frozen I/O queue as much as possible anyway.
> 
> Split the logic into a helper to query the information that can be
> called on an unfrozen queue and one to apply it to the queue limits.
> 
> Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
> Reported-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 17 ++++++++++-------
>   drivers/nvme/host/nvme.h | 12 ++++++++++--
>   drivers/nvme/host/zns.c  | 33 ++++++++++++++++++++-------------
>   3 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 943d72bdd794ca..5d312adca06e57 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2076,6 +2076,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>   	struct queue_limits lim;
>   	struct nvme_id_ns_nvm *nvm = NULL;
> +	struct nvme_zone_info zi = {};
>   	struct nvme_id_ns *id;
>   	sector_t capacity;
>   	unsigned lbaf;
> @@ -2098,6 +2099,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   			goto out;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ns->head->ids.csi == NVME_CSI_ZNS) {
> +		ret = nvme_query_zone_info(ns, lbaf, &zi);

lbaf is garbage at this point.

