Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7A0C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxhRoGxQMDU6ikoL0AvSCUO26Gv9OAsjIwBiwwpSKio=; b=SsmrxCLaFrbkTzcXiah36+hPdd
	qiNrIrjB84Xggtj98PV0tFfVIR6jbuf8K/AZF5ct0qVjgxVa42XmurWjlvTgk+HmAtdOj/MxwQN51
	b/JECYlV4nBIaR0LI7hRwOIgAcQEorm9ILC8IMurC9OIzahqU2nz8qLLzGs5MidJWxFYvNOikJEBQ
	8rkIl4fvg7ex1utqhL3uMYnyuTTCZHYVXtOOqwx0XiYnyUJpKYy1DpQO530BfrXs/mcBLMJd+K+Jt
	zt5L+MqLBcWnMzBrbObxAKMYZDMMTdz97MMsD1wbkff+dg8TMR4BuBhqC21lWRRd+cJ/3xMFgF4jY
	i6IGPNVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXCvg-0000000AJpS-2ZmF;
	Thu, 03 Jul 2025 05:56:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXCu0-0000000AJZv-0bdC
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 05:54:34 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250703055425epoutp045737b39a34addadc34b7ef6a370b5c91~OqAnaE7zs0870308703epoutp04W
	for <linux-nvme@lists.infradead.org>; Thu,  3 Jul 2025 05:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250703055425epoutp045737b39a34addadc34b7ef6a370b5c91~OqAnaE7zs0870308703epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751522065;
	bh=NxhRoGxQMDU6ikoL0AvSCUO26Gv9OAsjIwBiwwpSKio=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cF84dpmrmzWjHNPHxPkL0xB6K1V3QiXx3h7tlMt4iX8M/BNaSyagHwwh1asL4iu0R
	 ELj/u+7lSrDb2UM9h/bFQRtnqqN8vowfJOnAsJLaeA1EGtSgbNL576G91cETjbvs1q
	 lahDNWO+uKGcP7sPDMBIrpcM5IE3ISpVGEBInEkw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250703055424epcas5p1f09110c8969685ee00f9025484fee311~OqAm-TMbr1811418114epcas5p1g;
	Thu,  3 Jul 2025 05:54:24 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.176]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bXmDb2qvPz2SSKg; Thu,  3 Jul
	2025 05:54:23 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250703055422epcas5p2e210090b98d77bd394c7cd9e67bf0a04~OqAlHBl3V1762917629epcas5p2g;
	Thu,  3 Jul 2025 05:54:22 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250703055421epsmtip29b9ecb294e8afd118e03a01b6b09faaf~OqAj0L1Ch3089030890epsmtip2E;
	Thu,  3 Jul 2025 05:54:21 +0000 (GMT)
Message-ID: <07c07d1f-2eb6-437f-931c-0f04b129eb08@samsung.com>
Date: Thu, 3 Jul 2025 11:24:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
To: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250703055422epcas5p2e210090b98d77bd394c7cd9e67bf0a04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630075218epcas5p1f3d467fffa468cac0ccd012c193e94df
References: <CGME20250630075218epcas5p1f3d467fffa468cac0ccd012c193e94df@epcas5p1.samsung.com>
	<CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_225432_665938_DA94C3DE 
X-CRM114-Status: UNSURE (   7.57  )
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

On 6/30/2025 1:20 PM, Ben Copeland wrote:
> # first bad commit: [06cae0e3f61c4c1ef18726b817bbb88c29f81e57]
> nvme-pci: merge the simple PRP and SGL setup into a common helper

this patch had the problem [0] of not setting 'iod->first_dma' which can 
trigger that IOMMU warning on unmap.
But problem was transient as a subsequent patch removed the 
iod->first_dma and made unmapping work without that.

[0]
-static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
-               struct request *req, struct nvme_rw_command *cmnd,
-               struct bio_vec *bv)
+static blk_status_t nvme_pci_setup_data_simple(struct request *req,
+               enum nvme_use_sgl use_sgl)
  {
         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-       unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-       unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
-
-       iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-       if (dma_mapping_error(dev->dev, iod->first_dma))

iod->first_dma does not get set, and that can cause unmap on invalid 
address during teardown.



