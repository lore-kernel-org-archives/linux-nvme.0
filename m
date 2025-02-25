Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52032C021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=L0fLHcOJLk/V2nxGf5ps2J15jJ
	zXEFKNRO69lOm0Xe40u6YAxlqpciukhSbJg0q2Ns9WUUSF5+J6jkKUkhR2uoxFBtIPuNOEuaKbjNV
	kPIf/L2ZxHQaSYEPK9fDzPkTxPVmQJogVbr0HXLzpzJ1gzRboAoxAlnIM0qrTiRQecGuRBgDdj8nD
	p3sQFND17XlgLIwljex4X4GoOpPGNzoJQ3VxqyqoemGMqDqtdYBMWWqwsugCwGRx/ZQeoJIMB1vIz
	v6Z5RCKuNWdncVptnsgAVbmOVypiC+NfBUh1FCgeyU2u2i5f3FedAlV6E1KPfuCFDXlBjM4Y0fOTu
	HNCPHsLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrO4-0000000GcpJ-49G8;
	Tue, 25 Feb 2025 09:38:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmquo-0000000GW7G-2Nrg
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:07:48 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250225090741epoutp03b5357ba7fb61015f87952561e8174698~naE0eAhDp1336313363epoutp03G
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250225090741epoutp03b5357ba7fb61015f87952561e8174698~naE0eAhDp1336313363epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740474461;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JcaS/i3bh8uCmVzKJghDoGckO3Y9Wsalo9isLvfY3TVnXAWyHjKvaEO+QeAx3Dmdf
	 L5MNH5+0JxQ0MygQZn74VwfpTdnsKE7j94OzjT9jj4OEc4kRIsbez0iPaNaXjhuKfh
	 khqyrvL+AnHnTpwlRshUqrclR/d4sFA3AIjXDHkw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250225090741epcas5p2667279d89c977ea2f7dfefa9f10ee33e~naE0N73-W2867328673epcas5p2P;
	Tue, 25 Feb 2025 09:07:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z2BZh3KbWz4x9Pw; Tue, 25 Feb
	2025 09:07:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.30.19933.9588DB76; Tue, 25 Feb 2025 18:07:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250225090737epcas5p187ac8490d2d046bb4f18646610697ff5~naEw_XbLv0334903349epcas5p1e;
	Tue, 25 Feb 2025 09:07:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225090737epsmtrp1eb272d55b2d26c7f6de7f19c58f58680~naEw9v2T90417204172epsmtrp1j;
	Tue, 25 Feb 2025 09:07:37 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-76-67bd885959fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.4E.23488.9588DB76; Tue, 25 Feb 2025 18:07:37 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225090735epsmtip1efccfd0e7c70909b9f1f68011aabf6b5~naEu5uzSi2127921279epsmtip16;
	Tue, 25 Feb 2025 09:07:34 +0000 (GMT)
Message-ID: <f7e563b5-39a1-4d4d-acaa-65f4286e97f6@samsung.com>
Date: Tue, 25 Feb 2025 14:37:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXTeyY2+6weU+K4uVq48yWUw6dI3R
	4szVhSwW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBjaPcxcrAlijsm0yUhNTUosU
	UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
	9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTu1YylRgVHFt
	bh9TA6NuFyMnh4SAicTJo8+Zuhi5OIQEdjNKXJ93jw3C+cQo8W11OyuE841R4tX792wwLZe3
	NzJCJPYySpy78g2q/y2jRNuyWcwgVbwCdhLbf3azgtgsAqoS39f0sEPEBSVOznzCAmKLCshL
	3L81AywuLOAj8WXnPEYQW0QgUeLsic1g25gFlCU6ez6yQ9jiEreezAdaxsHBJqApcWFyKUiY
	U8BcYlHrSagSeYntb+cwg9wjIfCVXaLl5XlGkHoJAReJ5rkWEA8IS7w6voUdwpaSeNnfBmVn
	Szx49IAFwq6R2LG5jxXCtpdo+HODFWQMM9Da9bv0IVbxSfT+fsIEMZ1XoqNNCKJaUeLepKdQ
	neISD2csgbI9JJ5f+c0CCantjBITbyxjmsCoMAspUGYheXIWkm9mIWxewMiyilEytaA4Nz21
	2LTAKC+1HB7byfm5mxjB6VLLawfjwwcf9A4xMnEwHmKU4GBWEuHlzNyTLsSbklhZlVqUH19U
	mpNafIjRFBg7E5mlRJPzgQk7ryTe0MTSwMTMzMzE0tjMUEmct3lnS7qQQHpiSWp2ampBahFM
	HxMHp1QDEy+LY9Sfoo6dn08m5fJrBBTop75Z1l6k4FrEdWtj2AS1Jc2xHNtYlhmdFu++7Lbo
	mFrxDcvH3Np7zihO3ty5c4eM0PKVjUJ2n/YuiT1UeGHKG83NVxtLd7U6VKpv8qnvWnr6dZCS
	wHcvGZHJC42ElcyqvyhJHDu9rTLUfRI/pxLj5uyV9iWqLLkf2YTdwni7HnPeq98WXuPVxbdB
	MPrm8ZIlG+Q7b9i/ObCqyuX7fSZR5djVir8nTzkq+XPSiTecJTGl3+/6uTzivCw7e0bOTh+f
	LUuZXBeaZiVJGJRKbhV97yT4+vF3d62fzbu/7TMI2nnX6b5C+psfvDNZBO/KRflY3829kaSn
	sGeu87bTSizFGYmGWsxFxYkA2baUwSAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG5kx950g6N/5S1Wrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCN4rJJSc3JLEst
	0rdL4Mo4tWMpU4FRxbW5fUwNjLpdjJwcEgImEpe3NzKC2EICuxklfjxjg4iLSzRf+8EOYQtL
	rPz3HMjmAqp5zSjxsPMrM0iCV8BOYvvPblYQm0VAVeL7mh52iLigxMmZT1hAbFEBeYn7t2aA
	xYUFfCS+7JwHtkxEIFHi7urPYDazgLJEZ89HqAXbGSVWTL7BDpEQl7j1ZD5TFyMHB5uApsSF
	yaUgYU4Bc4lFrSehSswkurZ2Qc2Rl9j+dg7zBEahWUjOmIVk0iwkLbOQtCxgZFnFKJlaUJyb
	nptsWGCYl1quV5yYW1yal66XnJ+7iREcG1oaOxjffWvSP8TIxMF4iFGCg1lJhJczc0+6EG9K
	YmVValF+fFFpTmrxIUZpDhYlcd6VhhHpQgLpiSWp2ampBalFMFkmDk6pBiYjyTR/qSUJJ023
	S09JW9GWE54TqBafuPTAxDsyYUrZGqFiglu5JrD+S9qst2DDnZqotEeP7039+cTjQuXeeWdd
	erjEuAKzXBYflS9Nrum+n6jhtKvjsPoz9fNbw4/oX00KrC1J5Gt/U1Vw7n/mrY8peSucfSwr
	Yle+26R98u3E3wv555T9sePL53Jc/HetrKb18z9bihZanljOs9Nb5bhJEt/rC507e8ovHXgY
	dPL6osVC07ZqWP7frXZ5ytGInVUXTMw9Fafz9an8P3V0k3wVeydj+5TGzU3nopN3WKWsro+d
	n50sycu1ZpM2M/PLD1ecZ/984bKIh/2jc947lV3b+16oznwx/fRzyX9yf78psRRnJBpqMRcV
	JwIAqVWNUfwCAAA=
X-CMS-MailID: 20250225090737epcas5p187ac8490d2d046bb4f18646610697ff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183344epcas5p41f571eb393be215fbfa46e06307ba359
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183344epcas5p41f571eb393be215fbfa46e06307ba359@epcas5p4.samsung.com>
	<20250224182128.2042061-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_010746_917415_9A38F0FE 
X-CRM114-Status: UNSURE (   8.09  )
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

