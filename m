Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0001DC87FDA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7H/HNtK+WIhQZTcATGbOZGAlBvU9iv0q0dlKuaen/w=; b=EVA2L77FCbTf3NHBiT2s7raqwV
	wbVAWfE3wlqPXTZRMyxR306x/TFXdYr0171qNO1/8YNC2tMFIBUtig0uUUU+KfcugHeSJ+GqV6Obe
	OExbtt/MXtjSOwzXf5KUB2HJxhHP8vP/eBUgUeJo3uGnryPbCYTd9T3DuVAcS2uxMPgWPd1bWJPEi
	Fc8zT1C/4KfQIAXm3FxvqWBjozLdUMgmWQG+KbgR5A3ZTt9UHClkF8c4z/2OGgykR4C6csZDfS5Jl
	IcMo3cTy5pIsSdWtNKiddd6Iw4k4w2PZlFBuVcAIMGvOZ1EuPyYhbK9ezli17n729UhubrOkJfOws
	8S8vQ3Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMup-00000002ta3-3X56;
	Fri, 08 Aug 2025 13:13:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMit-00000002s18-0F8V
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 13:01:28 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250808130120epoutp02e01da7fd780aac657f13f12a5441bf03~ZzDpWscZe1465814658epoutp02n
	for <linux-nvme@lists.infradead.org>; Fri,  8 Aug 2025 13:01:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250808130120epoutp02e01da7fd780aac657f13f12a5441bf03~ZzDpWscZe1465814658epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754658080;
	bh=V7H/HNtK+WIhQZTcATGbOZGAlBvU9iv0q0dlKuaen/w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=l5C0E9PtjXe1LQUXEXQa1MtmvvcMbA5XCfXpfvLroNuu06gTzt8IlFOqJvjSaPFN7
	 HooffEdjm2kj7AHtnNBHQOE+PbZ0PJcnEGUIm3Gjj3khYRTJBuXc+7PoOk3wH3rK2r
	 9uRcndPKNbqrQtqwCZ/epcCnU1wDPzBLSI3/sIY0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250808130120epcas5p1177d920a8f2a241a76345c9ce5278b2f~ZzDpIX2Sf2491424914epcas5p17;
	Fri,  8 Aug 2025 13:01:20 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bz40b62XSz6B9m5; Fri,  8 Aug
	2025 13:01:19 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250808130119epcas5p18dc676ac009d3032576412d4953c01bd~ZzDoGp0pF0628606286epcas5p1c;
	Fri,  8 Aug 2025 13:01:19 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808130118epsmtip2fd0788518b2f1fa0c99f0395f71c36a8~ZzDnROCGJ1102111021epsmtip2F;
	Fri,  8 Aug 2025 13:01:18 +0000 (GMT)
Message-ID: <94414f36-ea73-4f36-ada7-684b4fe36506@samsung.com>
Date: Fri, 8 Aug 2025 18:31:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 8/8] nvme-pci: convert metadata mapping to dma iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250731150513.220395-9-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250808130119epcas5p18dc676ac009d3032576412d4953c01bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250731150532epcas5p19499d1438d1910bcac513cc085456f2c
References: <20250731150513.220395-1-kbusch@meta.com>
	<CGME20250731150532epcas5p19499d1438d1910bcac513cc085456f2c@epcas5p1.samsung.com>
	<20250731150513.220395-9-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_060127_589726_05A007EF 
X-CRM114-Status: UNSURE (   6.63  )
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

On 7/31/2025 8:35 PM, Keith Busch wrote:
> @@ -1120,7 +1157,6 @@ static blk_status_t nvme_prep_rq(struct request *req)
>   	iod->flags = 0;
>   	iod->nr_descriptors = 0;
>   	iod->total_len = 0;
> -	iod->meta_sgt.nents = 0;

This is missing "iod->meta_total_len = 0;" here.

