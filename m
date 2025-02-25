Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E907AC021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=A/14KnWiD/UaPIwiLtB12HYaXH
	ZhQe4Juhm2lbAgaYFO0gS2N7W3emAMjs/v8n855WTQAo3oVLP/0U7qm9xxjhMfyOgeIbmPOC924I5
	lswJboXWh+crkJYHrDbHjzXS9lypwkH6mECOF//uKW3LOvtr2PKLDFnZGk/XwOi2WG25ctqNpvSYd
	aX7NRq79E4/yS4nmUmKl20BUXhLRjEPThQ0KamOfUzEGE4blanQ3d14QY4MlS94m0sOTo44SKrqGJ
	OOkaWC/s9n2LCRoNYhvj/uUe2N0x7QyvC8q8VLi+jqM2nTaxn0GuXSq1w2aYjBrWHb3xCYleyt1ky
	omX60sbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrPs-0000000Gdmx-12nM;
	Tue, 25 Feb 2025 09:39:52 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqw7-0000000GWPf-1tQi
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:09:08 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250225090904epoutp02c30bfe435da9bfc7d4ad7953bb3f2ae5~naGBzc7VZ3059230592epoutp02b
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250225090904epoutp02c30bfe435da9bfc7d4ad7953bb3f2ae5~naGBzc7VZ3059230592epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740474544;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZJNKsT48NeeA6SaANyaUZvgUTNT6hZz4a9qEWxMLWWR+PsSaY5nS007nwVh6AQ5nG
	 syAAIpruAk6OISz9+rEQm/hUpsDgITFqqYj6Kh61jgAp5qj9cOaSatpZPAHl1sFlUq
	 x7W8BtVS3REe5Qo7JMpQf1JSdqvu6YJlNpzjiuEg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250225090904epcas5p26dac5e5929d049f4d2b5fd21d59e5d20~naGBo0Zrf0340503405epcas5p28;
	Tue, 25 Feb 2025 09:09:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z2BcH3tBfz4x9Q3; Tue, 25 Feb
	2025 09:09:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.F9.19710.EA88DB76; Tue, 25 Feb 2025 18:09:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250225090901epcas5p3c8a793eea5d8cc4d79e5a8f613065dc7~naF-cMDyG1284712847epcas5p35;
	Tue, 25 Feb 2025 09:09:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225090901epsmtrp17d7e894eaa6081687a7fa6d79e3fcb9a~naF-bnAlf0502905029epsmtrp1d;
	Tue, 25 Feb 2025 09:09:01 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-db-67bd88ae52c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.E6.33707.DA88DB76; Tue, 25 Feb 2025 18:09:01 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225090850epsmtip1fc69ae708efeab2b0199ba616cfd361b~naF0cW32q2199021990epsmtip1Y;
	Tue, 25 Feb 2025 09:08:48 +0000 (GMT)
Message-ID: <29af4b29-ee21-4743-8d9c-9e00c2578093@samsung.com>
Date: Tue, 25 Feb 2025 14:38:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvme-ioctl: common user timeout setting
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-5-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTXXddx950g+sdghYrVx9lsph06Bqj
	xZmrC1ks5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwe5y5WBLBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
	6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa
	3D6mBkbdLkZODgkBE4mr978wdzFycQgJ7GaUWHvjIBOE84lR4sHii8xwztq1dxhhWpqebIeq
	2sko0XC7Fcp5yyix6u0PFpAqXgE7iRMbXzKB2CwCqhLt/2cwQcQFJU7OfAJWIyogL3H/1gx2
	EFtYwEHiQXsPmC0ikChx9sRmNhCbWUBZorPnIzuELS5x68l8oDkcHGwCmhIXJpeCmJwC5hKH
	z5dBVMhLbH87B+xoCYGX7BIn/n6FOtpFYsrWuVC2sMSr41vYIWwpiZf9bVB2tsSDRw9YIOwa
	iR2b+1ghbHuJhj83WEF2MQOtXb9LH2IXn0Tv7ydg10gI8Ep0tAlBVCtK3Jv0FKpTXOLhjCWs
	ECUeEnMPVEICajujxIJJT1kmMCrMQgqTWUh+nIXkm1kIixcwsqxilEwtKM5NT002LTDMSy2H
	R3Zyfu4mRnCy1HLZwXhj/j+9Q4xMHIyHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYfYjQF
	Rs5EZinR5Hxgus4riTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp1cBU
	OMd11jKGv02eL58c//NG43Z9qG166sIItVOL/4Xmv2g88dL4Jiczn3e3vVh+4ZnFtxZfdHlZ
	+cLXVDdsg5HeGYH3TO/7+JZE3/EXCngm+OqekXFm0atSLb2e1Menj1Zv4W0rYTeav2x5Uv1z
	1TOyueHvZqhtu2fVPGfFjh9auuY3Djw7LPO6I/rH9WOR6pnX8yfvrNB6nmi9b7+a+ppJqT8d
	Ap/UrXlulaEUGzrv2Wa2PXvXBS4/U+PmN6t52meeOP6Q1jfLrBKfnEp5PFfsJIuTtGDbbg9W
	+2UL/OSa358Rf5A1Zbn5hhUHmzikpq9/Gud3+FnTMulracm2snfOXmtwtDeU7Ivcy2rCdsJH
	iaU4I9FQi7moOBEAg4gX7x8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO7ajr3pBsdfmFqsXH2UyWLSoWuM
	FmeuLmSxmL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAaxWWTkpqTWZZa
	pG+XwJVxasdSpgKjimtz+5gaGHW7GDk5JARMJJqebGcCsYUEtjNKbOu0gYiLSzRf+8EOYQtL
	rPz3HMjmAqp5zSjxZ9lWRpAEr4CdxImNL8GaWQRUJdr/z2CCiAtKnJz5hAXEFhWQl7h/awbY
	IGEBB4kH7T1gtohAosTd1Z/B5jALKEt09nyEWgB0xM2vD9ggEuISt57MBxrKwcEmoClxYXIp
	iMkpYC5x+HwZRIWZRNfWLqgx8hLb385hnsAoNAvJFbOQDJqFpGUWkpYFjCyrGEVTC4pz03OT
	Cwz1ihNzi0vz0vWS83M3MYIjQitoB+Oy9X/1DjEycTAeYpTgYFYS4eXM3JMuxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwMRT9LUlS8rkLZt5YurNrLml
	P0Pc9e9Lnt2wKfVVgne02LFjKSdO3NvRcMrZqnLK0zSve+1aidybeTf+1jVc4Rx73P+e29tl
	39sfPpbaO6fR/VWKR+i7hal2KVNTcgQSn/xYLqC6LnXy2k/Xjp5s0exSKj2hoNweKhUTIpTQ
	OvHK0/B0cyvZbP1NP9cv8pml7yuRdtTq4Q7bWVGnOQTq2DSOSNSZXPsnwP1z08ctqpt4F8/n
	Xlj7uyql5LTEcc+8lNlysvsD9F9wr93vkfB5J4fViVcvSnsXljyNr1r7P+phV8/2hiiP9fUn
	81mCvRqqW8871zvV6t19VOLZaNBy0dCmg8O67foRR9EOVplPSizFGYmGWsxFxYkASTe0BPcC
	AAA=
X-CMS-MailID: 20250225090901epcas5p3c8a793eea5d8cc4d79e5a8f613065dc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183451epcas5p1a44b90044516604e5afd4c1f92f56ff1
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183451epcas5p1a44b90044516604e5afd4c1f92f56ff1@epcas5p1.samsung.com>
	<20250224182128.2042061-5-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_010907_795320_202F90BE 
X-CRM114-Status: UNSURE (   7.87  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

