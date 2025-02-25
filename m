Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5054C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=zSHjbgEQLevifHTg85nJEF+bbx
	sxy6ToajR99WUB55cExhxWuiUqqO9fwDKiD4ROFz5G/OWsDNdMdUC2F0nv65aT5PKEgWs7lK3il+0
	dccs1tNigPfX98kYOV0cd0Fsk3oExz+uzwZxXpxAEaZ2jMWUUwKibrJFlYMiCcIVziffgf3mIJDs/
	YTk1kpQXEADbbcHp/bRv8trSOxQemgRjzSNWweuMyH4wKoNxitRSNEwzx7o5aMJJKy8abYSO2CfPc
	Z24H/OaCnyWuDkzjHTftzxWcTyvGjmoiX5Zeyuu4U91EPuiAj054DYZQWTf9fRLDhIli+Werb04j8
	4UCSXtkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrgi-0000000GiBy-0iOi;
	Tue, 25 Feb 2025 09:57:16 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrLS-0000000Gbow-0Yku
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:35:19 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250225093514epoutp014ce827a6ffba00234564cdb5d70b66c8~nac3mKzo82727527275epoutp018
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:35:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250225093514epoutp014ce827a6ffba00234564cdb5d70b66c8~nac3mKzo82727527275epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740476114;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JUZvmHoDu7idaTEE0jG9OmHm977LS6g8R0b85T6wAuSMmrQZk99mimsuL/NYZIB0I
	 e0LxEZ5ejjhFzFgcQ8C9QRSKGruW/C5HRfmhmNxSnnSKsy4I1XyyvapujfDPcX76tv
	 jRKSns/zPBU6IXME5JivAxzbE9awuYiH7k2sb7gg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250225093513epcas5p3b6a52f94ea3b2b9c819ea37ef4286750~nac3Ma_jc2571225712epcas5p3m;
	Tue, 25 Feb 2025 09:35:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z2CBS6NPgz4x9Pp; Tue, 25 Feb
	2025 09:35:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.F4.19933.FCE8DB76; Tue, 25 Feb 2025 18:35:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250225093510epcas5p16afc0d455c7d311c657a770cf7b0cac6~nac0vxJSl2572225722epcas5p1l;
	Tue, 25 Feb 2025 09:35:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225093510epsmtrp1976ae5e07fa446886f53e3c7f1c2d4b9~nac0vOSI22064520645epsmtrp1o;
	Tue, 25 Feb 2025 09:35:10 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-fb-67bd8ecf0b08
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.D7.18949.ECE8DB76; Tue, 25 Feb 2025 18:35:10 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225093508epsmtip153751ff9cdf6317a59ec3111172ddc30~nacyA-uo-0637606376epsmtip1n;
	Tue, 25 Feb 2025 09:35:07 +0000 (GMT)
Message-ID: <cc549e9e-2174-40eb-9a73-81389fb32446@samsung.com>
Date: Tue, 25 Feb 2025 15:05:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nvme-ioctl: simplify parameters
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-7-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU/d83950g9t7NSxWrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCNyrbJSE1MSS1S
	SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
	0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOOLVjKVOBUcW1
	uX1MDYy6XYwcHBICJhITPkZ3MXJxCAnsZpSY17+GGcL5xCjxePEMFgjnG6PEi33fmLoYOcE6
	Tjz7xwiR2Msosf7XSVYI5y2jxOZJF5hB5vIK2Enc3yYH0sAioCqx4WkTO4jNKyAocXLmExYQ
	W1RAXuL+rRlgcWEBC4k7C5+wgtgiAokSZ09sZgOxmQWUJTp7PrJD2OISt57MZwIZzyagKXFh
	cilImFPAXGLipAaoEnmJ7W/ngH0gIfCXXWLijsnsEEe7SHzZ3s8KYQtLvDq+BSouJfGyvw3K
	zpZ48OgBC4RdI7Fjcx9Uvb1Ew58brCB7mYH2rt+lD7GLT6L39xMmSCjySnS0CUFUK0rcm/QU
	qlNc4uGMJVC2h8SBG4+gIbWdUeL37y2MExgVZiGFyiwkX85C8s4shM0LGFlWMUqmFhTnpqcW
	mxYY5aWWwyM7OT93EyM4WWp57WB8+OCD3iFGJg7GQ4wSHMxKIrycmXvShXhTEiurUovy44tK
	c1KLDzGaAqNnIrOUaHI+MF3nlcQbmlgamJiZmZlYGpsZKonzNu9sSRcSSE8sSc1OTS1ILYLp
	Y+LglGpgatwtfGyS4zxrt/oDPRWL2TuTmXqO+SmeLXRplErVyp2Xsmv9pA+MOlMXTv5RFFDm
	zWpqacxZ4iJ7n3nO1w2+2zxLhSI3xZ8/PHNpPuNBLnHH1EeMEnvF5xU57L+RmSgR8THUbfIn
	l+UFjgftXX2T5lXs4ZK98F73/a1eCXa2idwtEzLfcaewVJ2y+CR4pqpA4aOI8VG/vyFFKafK
	RZc3yE8Lma694lL83dBFM9+/nOE/nevbt0Vb87ricrle3HnlMvXjtyMPagN/7tu4cS3vjX0h
	kXyvpodfcctZ0H5QidV/j2TEkwvBMfPLGjYWKh69ufyM9wvjf8o5OqEnHGafqZ3r/aV1wbG1
	fts1bTveKrEUZyQaajEXFScCAN6K7TofBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO65vr3pBudnm1isXH2UyWLSoWuM
	FmeuLmSxmL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAaxWWTkpqTWZZa
	pG+XwJVxasdSpgKjimtz+5gaGHW7GDk5JARMJE48+8fYxcjFISSwm1FiyYJl7BAJcYnmaz+g
	bGGJlf+eg9lCAq8ZJXatNO1i5ODgFbCTuL9NDiTMIqAqseFpE1gJr4CgxMmZT1hAbFEBeYn7
	t2aAxYUFLCTuLHzCCmKLCCRK3F39mRHEZhZQlujs+cgOccN2Ronrb6ZCJcQlbj2ZzwSyi01A
	U+LC5FKQMKeAucTESQ3sECVmEl1bu6DK5SW2v53DPIFRaBaSM2YhmTQLScssJC0LGFlWMUqm
	FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4aW1g7GPas+6B1iZOJgPMQowcGsJMLLmbkn
	XYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQamOq/y/aYb
	ph/+Pmvu1if6kUw2D+LK+xSOZsT80Xu78qlS9++jFru155/Mfbbl3dc1s+OWT1I7c38234qa
	iNmHFad7+1hM2m399/i5ebcY65Nz30bbS+5/fOrY7bobmrNqAppUbn/u2x7Z0XXmtO7cpfOS
	GISnbhe6qWiuH2O6L35D4smgiomv/zUX/DhYvvChX9UXhl0XrLWqF8jJROtYzojNjIpNefjv
	i5lDyB3VVU/lDaQfKmsl2z6+P7f0w1RB/SVHzpqefrLgcgyLS+PmPU8ZczRZd81hsnS7M0N1
	a4aelKj6rY1Lbv2K3HpwX90HpxkH/jg9bny9T/djG+Nns60Py1dOTMqU0vCX+nHi/QMlluKM
	REMt5qLiRAAZ4isE+wIAAA==
X-CMS-MailID: 20250225093510epcas5p16afc0d455c7d311c657a770cf7b0cac6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183305epcas5p1388a2e8fff68505c69c5152ea730c014
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183305epcas5p1388a2e8fff68505c69c5152ea730c014@epcas5p1.samsung.com>
	<20250224182128.2042061-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_013518_480326_E1E8F32D 
X-CRM114-Status: GOOD (  10.40  )
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

