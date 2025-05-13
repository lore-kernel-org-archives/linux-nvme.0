Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793DDC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYUaVVgSeZluLHANp84vj06KyY+2+TKS7/eyAMH8a60=; b=FdfV+obQk0tOFTEeiY2miPplb1
	A38kchppdyb8Kk0lzb443PjUnU/l+ykoqan0gJWfozRWV2C0Um3GWsNFWRZeHd5MOMhhld0tamU7L
	5z7oMpIa8sVYpndC1jRxsT+ox/buZ/gh5sEG+vCpHMVMFef/KXoMcsJFcTJ9RB4M+3EqZDmcVAs+S
	R29fhRvCRLMxrjH17KEbWqqavS54g+LFjaAnCyiaIjYp9WDYcwzEHm2HC1BRh8HKYo5urM9Hhe/vS
	q3XFjyN1hldMm3UMUTMMFeVTqI6uzpe/QCCt1PZvvJY6UfnC2vSkj6rcBETHToB2fTore0ogju+Bn
	0qS5ZVBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqOK-0000000CaG2-3MAk;
	Tue, 13 May 2025 14:13:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqOG-0000000CaFc-25ly
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:13:55 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250513141347epoutp02a7ed378508bca934aa06cc6db826d7a4~-G7EZ2_d42273322733epoutp02U
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250513141347epoutp02a7ed378508bca934aa06cc6db826d7a4~-G7EZ2_d42273322733epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747145627;
	bh=fYUaVVgSeZluLHANp84vj06KyY+2+TKS7/eyAMH8a60=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cWOXxITKR0oO4XVko0ft1W6tdSDpObY91Okz5rGit/SZAEV7vBw7248XnR8h/Jxhp
	 qrhlB82Ev8q9fmU50Z5cNbU7o1xSmJ5Er7B5K/+9Hbm5eCvYlRuUli08Pvq0OFKi/O
	 cdNveBc3Ag+mH889Jiv7CYHMe1z3v3SRlNWNIa8c=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250513141347epcas5p465cb20a95c36220130be0baba40ede4c~-G7D87Jd00814508145epcas5p4I;
	Tue, 13 May 2025 14:13:47 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.178]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZxdkL18yJz6B9m5; Tue, 13 May
	2025 14:13:46 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250513141345epcas5p157dd0d4d2846238e08c014bd7cb6bd0b~-G7CB30gj3228432284epcas5p1i;
	Tue, 13 May 2025 14:13:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250513141345epsmtrp16c6542ac2caf3b300fdcb36e66b8bbc8~-G7CBQPWt0845008450epsmtrp1B;
	Tue, 13 May 2025 14:13:45 +0000 (GMT)
X-AuditID: b6c32a2a-d63ff70000002265-54-682353992f6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.F7.08805.99353286; Tue, 13 May 2025 23:13:45 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250513141344epsmtip2296dff4a38df93f84da2d1f68011caee~-G7A4WlN91453714537epsmtip2W;
	Tue, 13 May 2025 14:13:43 +0000 (GMT)
Message-ID: <c6e9b2bb-6e32-43da-8a8a-29775c21c853@samsung.com>
Date: Tue, 13 May 2025 19:43:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] nvme-pci: store aborted state in flags variable
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Leon Romanovsky
	<leon@kernel.org>, linux-nvme@lists.infradead.org, Leon Romanovsky
	<leonro@nvidia.com>
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO7MYOUMg9NdPBb/F85ltVi5+iiT
	xaRD1xgtpvxaymyxacMTFov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm0dv8zs2
	j20Pe9kD2KK4bFJSczLLUov07RK4MtZPec5a8IKpomXOXfYGxuVMXYycHBICJhIzPt9g7WLk
	4hAS2M0o0T1zGiNEQlyi+doPdghbWGLlv+fsEEWvGSWeND9kBknwCthJbOpZDGazCKhKbL9y
	kQUiLihxcuYTMFtUQF7i/q0ZQM0cHMICHhIv37KBmCIC6RLPuopAKpgF5jJKfFusDWILCaxm
	lNhyuQQiLi5x68l8sDvZBMwlts87A7aJU8BQYv22I4wQNWYSXVu7oGx5ie1v5zBPYBSaheSI
	WUhGzULSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHRo6W1g3HPqg96
	hxiZOBgPMUpwMCuJ8DZuV8wQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6Yklqdmpq
	QWoRTJaJg1OqgUlIbtnWX1+lBaZGxLkel4ludj/iUP/AtrTJ5RzTCy/HrNlFMrYrbd236X2S
	e/Pr3r4W9h3u5/RuzF13pvTGeoaLTsdn2atsvVcZvbxA8G36vrfPNzss3NJm4Oz0WXN57vGL
	8XHtbywk2a739vAc0Vj2iXtPlkxb2pIo01s7UkVKL8b5un3fNF3uxZRf8gmic391yM0ycLjH
	25vQvU3dVevos9DJ0g7Fp/e4NR0+6Rez9XXrzdUl9r8ZmnrOGc9cGdLee/CL4xqV0l1xfN4n
	/r89ss2D6eTFb34Hapw4HsxR9OIOmhPOvH7ikciLezadNy4UfRAvLvfk+dMZyua8+kw/0ipX
	pzj9W5vLpcKhKKzEUpyRaKjFXFScCADartawDQMAAA==
X-CMS-MailID: 20250513141345epcas5p157dd0d4d2846238e08c014bd7cb6bd0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070151epcas5p3f9a1f857f6d7e5433b3281dccebd0dc2
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070151epcas5p3f9a1f857f6d7e5433b3281dccebd0dc2@epcas5p3.samsung.com>
	<20250513070025.830930-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_071353_980852_C69BC8D4 
X-CRM114-Status: GOOD (  10.88  )
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

On 5/13/2025 12:30 PM, Christoph Hellwig wrote:
> From: Leon Romanovsky<leon@kernel.org>
> 
> Instead of keeping dedicated "bool aborted" variable, let's reuse
> newly introduced flags variable and save space.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

Nit: I would not call it 'reuse' as flags (within iod) did not exist 
before this patch.

