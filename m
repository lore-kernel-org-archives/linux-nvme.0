Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E4C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+o/Oy6jtgxZb3IL0OaqxJLg6PLHtyWlpbSff0V6zpGM=; b=PSXTlQD1F7WwwkA2w1SjGCxUQ/
	kVkmegQmq1GKVT0JPbbLWi9sRHyOy9/rrw0jnphvenhIMbpAWeYulwfcw1Fan2E8VPm5ps7Iq7k0D
	h4KcKR0veUt3HZlvBsMlqHuleoOm2xdwACl5wFk/c2hxIP2yChH+uXo4pSouQOWLlPfZhnV5I2zqA
	nSo3BT+xsry3aHjtAfgru/g2hfmtcU4EP8048Tb+wCTM+KMMfeqCHMLP7Ugwadbafdb6+55LDFzag
	Cie7Bs9j4neDZx33fSet9JRPT3a/c4Tj0XthSvt9B0PpN4UDQrBncFdYUppshotbE34TgVX+XRuan
	hXC2Me2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh63J-00000001U1y-02t8;
	Wed, 30 Jul 2025 12:37:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh5if-00000001QT4-3a6k
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 12:15:43 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250730121534epoutp0377ac183b5ec8e6143e17b6759899929d~XBoHqQQGs3203632036epoutp03K
	for <linux-nvme@lists.infradead.org>; Wed, 30 Jul 2025 12:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250730121534epoutp0377ac183b5ec8e6143e17b6759899929d~XBoHqQQGs3203632036epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753877734;
	bh=+o/Oy6jtgxZb3IL0OaqxJLg6PLHtyWlpbSff0V6zpGM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qP7REYz9dUcULt2Gdr/rPbcOO/HNMfn8jz22UMppStbahkTATTN16pyUJu0zAN89Y
	 TIlBEaYcEu+8bMQ/9ydpMKHiAW39hJXNIMqKls3rziyePD2opLodNVpCq646+prtl+
	 R2FjrrI7PKeNl2eJo20CpBGA9K0L+cCC24RyxFkE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250730121530epcas5p3b584c5800e3f7937d191cc8a1114d7f1~XBoD7ItNs1519315193epcas5p3h;
	Wed, 30 Jul 2025 12:15:30 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bsWPs6brsz6B9mB; Wed, 30 Jul
	2025 12:15:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250730121529epcas5p18aee87528590191ece2ea8b16c52cec0~XBoCe1GV41597315973epcas5p1Y;
	Wed, 30 Jul 2025 12:15:29 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250730121528epsmtip2d4fd37c43f25c1d24c5019bea427bd9a~XBoBiEmX10734707347epsmtip2P;
	Wed, 30 Jul 2025 12:15:28 +0000 (GMT)
Message-ID: <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>
Date: Wed, 30 Jul 2025 17:45:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being
 iterated
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730121529epcas5p18aee87528590191ece2ea8b16c52cec0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659@epcas5p1.samsung.com>
	<20250729143442.2586575-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_051542_390814_1E822B3A 
X-CRM114-Status: UNSURE (   8.13  )
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
> @@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
>   	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
>   	iter->status = BLK_STS_OK;
>   
> +	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
> +		iter->iter.bvec = &req->special_vec;

I am not certain yet, but thinking whether this is enough to handle 
RQF_SPECIAL_PAYLOAD correctly.
Maybe "req->special_vec.bv_len" also need to be included here to 
initialize the iter.

