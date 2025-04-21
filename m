Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C80C369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2u87TOECjawntY7D5V86pdK95+lTCeMUL6C9Y3hUsCw=; b=wEVlz6a5QVRPPHbiCsEelUctgF
	d0RHMvQ99/mhwGst+2Hrr9EsXhtDHOI1P9KbiN9tSNLzV3dD0PzLqM5m7UpHUGeVE0T6kXmh8uOwl
	snG+Ljhnv9lVYsf7RiV+l67f7iMiQIaZ4pu7j+IV1ZOoE3gerDkm3XDgLW9R9emUYQIYIWEgkIjwe
	YXnrSLrJFCeXuYQQi6oS7omLBJxwumahcwa3i5jTfrbzi1U0sWw/9g64tQdvMdPS7BgByT69RHLV5
	ZzdjqCPLCv7wKv19o4ZYBhqWrw/9wjDpHx+vbORpHH1utdVL7O56q7Y8pUlCLZijfwxTog9QRzKE8
	QaPcF59g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lLU-00000003lHQ-01tW;
	Mon, 21 Apr 2025 07:13:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lLQ-00000003lGL-3Owv
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 07:13:34 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250421071329epoutp013df2df619e3014f70078928cfe2d8fe1~4Q-zwybNM2915029150epoutp01S
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 07:13:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250421071329epoutp013df2df619e3014f70078928cfe2d8fe1~4Q-zwybNM2915029150epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745219609;
	bh=2u87TOECjawntY7D5V86pdK95+lTCeMUL6C9Y3hUsCw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lAypoYclbmkjPS7BnD7H0W5YI88PM/klJBB85seET587K9o6Ow+bXA8IZSQ53DbNK
	 4BODLTA7hmriZBpFFT+ZamdiowUgjD3nYI+W7cT6pU9w0OJLM7zlE2ZQNV9Da4bD7B
	 4OkQJtGgtZn4/gbuZeRNPMBvQleJFQungu9XFdW0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250421071328epcas5p13cf33f8bb7005e69360f837d4411d236~4Q-zXJfkp2319223192epcas5p1x;
	Mon, 21 Apr 2025 07:13:28 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ZgxRW2FdSz2SSKX; Mon, 21 Apr
	2025 07:13:27 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250421071326epcas5p156047242a96a1f25825071656349095e~4Q-xboPty1355113551epcas5p1k;
	Mon, 21 Apr 2025 07:13:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250421071326epsmtrp26fe4e6a180a50e347c7f4ac2f170cf81~4Q-xa6JzZ2685026850epsmtrp2K;
	Mon, 21 Apr 2025 07:13:26 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-0f-6805f0164222
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.6D.08766.610F5086; Mon, 21 Apr 2025 16:13:26 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250421071325epsmtip19ee977189641d5b401f31de93c7e73c8~4Q-wLOHHi1816518165epsmtip1J;
	Mon, 21 Apr 2025 07:13:25 +0000 (GMT)
Message-ID: <be873f40-d3c4-4f0e-8b36-dc6e4f5bcf48@samsung.com>
Date: Mon, 21 Apr 2025 12:43:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250420164450.1144416-1-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnK7YB9YMg+knVS1W3+1ns/i/cC6r
	xcrVR5ksJh26xmhxedccNov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	2x72snt83iQXwB7FZZOSmpNZllqkb5fAlXFt73umgvXMFfPOrWZuYLzB1MXIwSEhYCJxvVG1
	i5GLQ0hgN6PEv6unWLoYOYHi4hLN136wQ9jCEiv/PWeHKHrNKLH8w0Q2kASvgJ3Eor2zGEFs
	FgFViQ37prFCxAUlTs58AjZIVEBe4v6tGWCDhAVcJD78/sYKMkhEYBujxO4Pe5lBEswCDhIX
	rnazQWyYxCix/v4/RoiEuMStJ/PBTmUT0JS4MLkUJMwpYC+xacMxqBIzia6tXVC2vMT2t3OY
	JzAKzUJyxywkk2YhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgONLS
	3MG4fdUHvUOMTByMhxglOJiVRHjNg5gzhHhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJI
	TyxJzU5NLUgtgskycXBKNTB5/2/65i1bLNO9/OxmN/Xreu+TYwpNT6X1LZ379vnT7sbswpCz
	9eXqjFrNjyaV8m1cX9T57toTDZFztrW39iUu3GDyU32r851oFdYPL37lvQ/Y0xuxZ83hhVZK
	R39wyDtrSnGIN745wia4xW2NfkYDo9rGgusftdo+tnQcqORTY9n+e81LwWvup//+0Y08e8Qg
	xjRvX4TSmRO6dbOULmsHrY958P2SicZ3ARWtpGm5Ci/T7VcLy2zj+jXVfa1MnrDdjiPHWg+u
	ffje4Cl3SKlQuKj0wmWrY/Ym1V45Vx626F7bo+bn0X6TDj9YKFD3u4nr+5nvvZ6Saw/rO13T
	3CzFe7xZy23KbO0Ek2jO8D4lluKMREMt5qLiRAAhQ28iEgMAAA==
X-CMS-MailID: 20250421071326epcas5p156047242a96a1f25825071656349095e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0
References: <CGME20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0@epcas5p1.samsung.com>
	<20250420164450.1144416-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_001333_175486_18296083 
X-CRM114-Status: GOOD (  14.24  )
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

On 4/20/2025 10:14 PM, Caleb Sander Mateos wrote:
> struct nvme_dev {
>   	struct nvme_queue *queues;
>   	struct blk_mq_tag_set tagset;
>   	struct blk_mq_tag_set admin_tagset;
>   	u32 __iomem *dbs;
>   	struct device *dev;
> -	struct dma_pool *prp_page_pool;
> -	struct dma_pool *prp_small_pool;
> +	struct nvme_prp_dma_pools prp_pools[MAX_NUMNODES];

I wonder if it is worth to make this dynamic using nr_node_ids?

