Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0E8C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=w3i+fa6QSar6k8qg2BpqfKIW20
	Sf7u0gfn3X+JL8GhdF5kqAFfMbR/KPB/s6iSDgNGSIb4RRzioKWv6R1SM68xUh9UADU8UhvBTaFoE
	0DcGbuFf9FCgUWYVc9FZsr2ykk8a9C7/aymCMIUuEdg22yAwGPWG8miQSflAORIVTxtxnU3kF6zvI
	fzf/9LbeS94gDcSB70JrfdGm8WLkUl5vwCo8es48vaBgf13/3Sd6kMoJAXEgxOhJEmRUkJfID+4DW
	fOnQsV68PQHkRoq7un37UqFN0tVl8Penp/yEg2GrfZiaxWou87H+iybNCK+0e+XDH3vz9g3/obaDD
	x/oTFezw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqwr-0000000CfHA-2Dnv;
	Tue, 13 May 2025 14:49:37 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqwn-0000000CfCH-1Utv
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:49:36 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250513144924epoutp02f0d6a0d4d8781e45951a0ec983384e80~-HaJ-KGwS1433414334epoutp02Q
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:49:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250513144924epoutp02f0d6a0d4d8781e45951a0ec983384e80~-HaJ-KGwS1433414334epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747147764;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pm/hG6eik7Y5/89DDqaufk6WfbZLUkZHHDexwR5cvCF8q4cINDpEqGn1u+8/ZmaEc
	 5t5dH3nn/CaqZrDxfOt/CBqL915mg5BkgT1sqHX649mkrDDB3ViWXd2gzhYcXJY59L
	 G6ipOlkhS1LgaIEUTvHWbkC69Qaooj4j8tSgW3pU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250513144924epcas5p45f27b6cf10115a49b233e2cd17285947~-HaJ06Kea2325723257epcas5p4L;
	Tue, 13 May 2025 14:49:24 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZxfWQ2ccqz3hhT7; Tue, 13 May
	2025 14:49:22 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250513144921epcas5p30b42a7f50170881e1968969d00a4151d~-HaH4dXRy0035300353epcas5p3S;
	Tue, 13 May 2025 14:49:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250513144921epsmtrp249f3774490b668277a3a4d8c5c50a33f~-HaH3zH-40827208272epsmtrp2g;
	Tue, 13 May 2025 14:49:21 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-29-68235bf16f25
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.79.19478.1FB53286; Tue, 13 May 2025 23:49:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250513144920epsmtip2d226983de2d89c58da5baf90fe6fb021~-HaG3AUMT0455104551epsmtip2j;
	Tue, 13 May 2025 14:49:20 +0000 (GMT)
Message-ID: <dfe8bb9f-3706-4454-9270-aae2bf572a1a@samsung.com>
Date: Tue, 13 May 2025 20:19:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Leon Romanovsky
	<leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-6-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO7HaOUMg94+Q4v/C+eyWqxcfZTJ
	YtKha4wWU34tZbaYv+wpu8W61+9ZHNg8zt/byOKxaVUnm8fmJfUeu282sHlse9jLHsAaxWWT
	kpqTWZZapG+XwJVxasdSpgKjimtz+5gaGHW7GDk5JARMJP7dmMLcxcjFISSwnVHiwbfH7BAJ
	cYnmaz+gbGGJlf+es0MUvWaUuLP3GwtIglfATuLlgT5WEJtFQFXi+fWLjBBxQYmTM5+A1YgK
	yEvcvzUDbJCwQKTE/XM3gWwODhGBdIlnXUUgYWaBMonVR1awQsxfzSix8V8fC0RCXOLWk/lM
	IDabgLnE9nlnmEFsTgFDifeXtrJB1JhJdG3tYoSw5SW2v53DPIFRaBaSM2YhGTULScssJC0L
	GFlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgRHiFbQDsZl6//qHWJk4mA8xCjBwawkwtu4
	XTFDiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWm3wPvS
	joVyb4OZW8z1lqYe/6X8jfv2ksYfSzo8Qq5d8yw/vsLx9KsDjsd7Fn44abCZZfcVz0bunFVO
	TWv+yP+cryVV+vFa49ToVQuZND/yTpkeVZN11v59gBfrzx5HjT+Ly10OKE5Zd0pDrjHb8YOV
	parNii/F1a7igd+sa670HcrMlFaLXBnZ5LK71fhZQr9++4ubev+ca/U3ZhZqGd7uzzU+0dCj
	xGO6K0RCub/M7nv/f6YgE41Cc8Xj6tvYPm8Vf3fife822dfv2hrZlsrO2pogG+9yOeK40Lv0
	9jVbt1+f8eHDPnfre4d3RN1+1xP/9WNpkv7eKXd22VTEsDDb79KrnRi8+JSzVbH3biWW4oxE
	Qy3mouJEALQdin//AgAA
X-CMS-MailID: 20250513144921epcas5p30b42a7f50170881e1968969d00a4151d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070154epcas5p49a55945e038f5d96330eabb827174cec
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070154epcas5p49a55945e038f5d96330eabb827174cec@epcas5p4.samsung.com>
	<20250513070025.830930-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_074934_026137_A6B2E1FF 
X-CRM114-Status: UNSURE (   9.20  )
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

