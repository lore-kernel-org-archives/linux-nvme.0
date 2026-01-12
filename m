Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A09C9EC95
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+CiaHJqMjjQE9Phb31KzcMHXN//1jSymEg2oeDr9k8=; b=JOidV9q0qTb+DPEmvYDlnOSBy1
	u48/Td+KMlopxLUMB/iksCIXxxkP4YgY+wVfTtu1se76wBoMM6OrLaztK1TN5GYMg4xYWKxNetRKR
	Xgozfu4s9AHidD1RYR1u9fqbSDhaLcx2LdnNA0RoivbM1ld7yLNAJ1mROcddQambFh/5G/Sbqo47y
	2lFqAuADeBAjyLCw+4h51cY7KouTdhJFL1pUVpcrGmH1IQVyIkC0/dZC011jYZ6dKnSkDrbm7YT/d
	/qTko1MW34Cj2CZn9U4ac0HANQglU95ZJw8zyEzorMnzUoK8n9mVaS8ICSh8QGEilWAELWRvWS658
	Q1zbxN3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIyT-00000005XPb-3txv;
	Mon, 12 Jan 2026 14:32:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIyP-00000005XOP-3XAc
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 14:32:52 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260112143240epoutp030a19bed765c3fe86e76f962c85297d09~KAlM8JXtB1445614456epoutp03M
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 14:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260112143240epoutp030a19bed765c3fe86e76f962c85297d09~KAlM8JXtB1445614456epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768228360;
	bh=4+CiaHJqMjjQE9Phb31KzcMHXN//1jSymEg2oeDr9k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TE+/aWU0C+Qy9VRS4U+q6pL6iSFzIiY7KLv2/MErs/fO7OkAitpvRS7Ebut/pvikT
	 YUe/NqFhojX8M9jRnFvVJDwCNfjm4lmREj6T+Rf1Co3irHycj1kY7Q6IQ6LoXKfa8q
	 jRJiHUvtpvkahi6JLiEBTvxrdWV0jVY91wzUmMGo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112143239epcas5p3d89bf9b66b9b9627170c58a4666a70b9~KAlMDhBBA2096120961epcas5p3d;
	Mon, 12 Jan 2026 14:32:39 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dqZbV44dGz6B9m4; Mon, 12 Jan
	2026 14:32:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112143237epcas5p3e58114246f9601703c0a45f6a31fccf7~KAlKMs1sE2096120961epcas5p3c;
	Mon, 12 Jan 2026 14:32:37 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260112143229epsmtip221775e9f44a307dd420588ee9a0c43d6~KAlC4youa1619516195epsmtip2V;
	Mon, 12 Jan 2026 14:32:28 +0000 (GMT)
Date: Mon, 12 Jan 2026 19:58:22 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	nitheshshetty@gmail.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
Message-ID: <20260112142822.tk34ei4evgypw3qv@green245.gost>
MIME-Version: 1.0
In-Reply-To: <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>
X-CMS-MailID: 20260112143237epcas5p3e58114246f9601703c0a45f6a31fccf7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
	<CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>
	<20260112135736.1982406-2-nj.shetty@samsung.com>
	<5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_063250_520461_731FEBE6 
X-CRM114-Status: GOOD (  15.17  )
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

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 12/01/26 03:08PM, Damien Le Moal wrote:
>On 1/12/26 14:57, Nitesh Shetty wrote:
>> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  drivers/nvme/host/pci.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 3b528369f5454..065555576d2f9 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>
>>  	if (iter->len)
>>  		return true;
>> -	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
>> +	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>
>Hu... Why is this not squashed with the previous patch ? If only patch 1 is
>applied, this will not compile, right ?
>
I couldn’t decide whether to use the layering convention or a unified patch,
so I chose one patch per layer.
Agreed, independently this doesn't compile, merging make sense.
I will resend.

Thanks,
Nitesh

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_
Content-Type: text/plain; charset="utf-8"


------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_--

