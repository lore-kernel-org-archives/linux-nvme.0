Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B08C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=vStRtGpZTV36tr5ztrgr7uUDJA
	dm2aOn9jy34jy82uwqKMn8igM4qLN3bc9pK0oZB5Hr/kplz0htO6ILmh34tCSItff8stQm4zwr4Nm
	yozBSKUIFwe7atOLRE1ekfYYm0oXOqyp1yuUVsMCWoEgojkdn2Y/1dH2tzzwasd1rffoDDsiYu1XG
	ugIMyRgMh7xWCrZnQk7l1DjE2VnC8MZsLd7hTGU7fQD3BFBnJQD45SWNIGc5LoEg/7Ov7NDP/PjhN
	V2zekYsWaMI/TWOtu97h2hws3CIgrHMXfov+iKIP5GzSxVBoFpgWBf9+YbGTOV4/QgF1ejvIWwiYE
	vuKVH5DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrNv-0000000Gcbi-28ol;
	Tue, 25 Feb 2025 09:37:51 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqtM-0000000GVo6-0Qrb
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:06:20 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250225090608epoutp03980b9e310783afeac67f3dfedc9aa503~naDeA1C631301113011epoutp03z
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:06:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250225090608epoutp03980b9e310783afeac67f3dfedc9aa503~naDeA1C631301113011epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740474368;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ljaT0GIVs4hLWV6/lu6Il6iVq4RcVuleghx1IWWs9stxtd3AJLXNgVPcq8TgvJpVs
	 NaV6zTyNiyrrFXNA8z1Mx/13WUjVP4/BTBRLyh4VnQ6lJ48V9pYJte/jkgasqsdIji
	 tHLlzQEWpvYlVNTd3Ozyw2l3oTW3u8D5mE3UFAvA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250225090607epcas5p17bf58a900b796d9281a78bf4fd554126~naDdMyXmY0927009270epcas5p1H;
	Tue, 25 Feb 2025 09:06:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z2BXt75VLz4x9Pt; Tue, 25 Feb
	2025 09:06:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.E5.29212.EF78DB76; Tue, 25 Feb 2025 18:06:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250225090605epcas5p28c5237f16c0e5d44f7f32b0d8c622cc0~naDbcA5pe2504925049epcas5p2z;
	Tue, 25 Feb 2025 09:06:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225090605epsmtrp149a118e817010cc4324f341fac9b626d~naDbbaC4q0342403424epsmtrp1o;
	Tue, 25 Feb 2025 09:06:05 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-4e-67bd87fea531
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.44.18949.DF78DB76; Tue, 25 Feb 2025 18:06:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225090556epsmtip1280794bf728f66d6772168d9b8175768~naDSffb0m2026920269epsmtip12;
	Tue, 25 Feb 2025 09:05:54 +0000 (GMT)
Message-ID: <f0efc913-aefe-425c-856b-9649455a8dc6@samsung.com>
Date: Tue, 25 Feb 2025 14:35:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTS/df+950gy3bWS1Wrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCNyrbJSE1MSS1S
	SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
	0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOOLVjKVOBUcW1
	uX1MDYy6XYycHBICJhILu3YzdjFycQgJ7GGUWL/7LJTziVFi9ZG3rCBVQgLfGCXePsyB6dj8
	qZ8Fomgvo8SlU0/YIYreMkpsXRsAYvMK2Em8vvcfLM4ioCox80UTE0RcUOLkzCcsILaogLzE
	/VszwGqEBZwlPpxZzwhiiwgkSpw9sZkNxGYWUJbo7PnIDmGLS9x6Mh9oDgcHm4CmxIXJpSBh
	TgFziSsLtrNAlMhLbH87hxnkNgmBr+wSB29eZwWplxBwkWh+B3W/sMSr41vYIWwpiZf9bVB2
	tsSDRw9YIOwaiR2b+1ghbHuJhj83wMYwA61dv0sfYhWfRO/vJ0wQ03klOtqEIKoVJe5NegrV
	KS7xcMYSKNtD4s6MqayQUNvOKDF/6wWWCYwKs5ACZRaSJ2ch+WYWwuYFjCyrGKVSC4pz01OT
	TQsMdfNSy+GRnZyfu4kRnCy1AnYwrt7wV+8QIxMH4yFGCQ5mJRFezsw96UK8KYmVValF+fFF
	pTmpxYcYTYHRM5FZSjQ5H5iu80riDU0sDUzMzMxMLI3NDJXEeZt3tqQLCaQnlqRmp6YWpBbB
	9DFxcEo1MLE6bl7RlidW2lS9v3m/yIcTh9Qdj+kbdRl/ELc5tr260iZTgVdrX5hNctbWcydm
	r2Vk8q9MnLFd6NOkthvLipVV7jGtLpPScin64bSS47hl+u8NZtvrxNXZzgidl09lW+W9T+Fw
	yf/UP4437dufx08oEzec8ffg28wZPqF5l0qaLA4qr7l7+mrJp8vRu/Ys2p7Ycsx1aZ1K9vTV
	SftDrlRWur/avNs201hnwene1yosO9Wf7TZKrVxyPHAeq7PCBeOO3OdmHsYXnZJfve5e2vcw
	tdbEaX953Jz1suyL6koztpbNDbfh5mRf/sFv8opL3TrnNoWxFL5nb8zkfvT2wTT91y/5X7r1
	bDfkN1t4XImlOCPRUIu5qDgRALQhxyEfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO7f9r3pBqtO6lqsXH2UyWLSoWuM
	FmeuLmSxmL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAaxWWTkpqTWZZa
	pG+XwJVxasdSpgKjimtz+5gaGHW7GDk5JARMJDZ/6mfpYuTiEBLYzSixbv1LVoiEuETztR/s
	ELawxMp/z9khil4zSmxevwoswStgJ/H63n8wm0VAVWLmiyYmiLigxMmZT1hAbFEBeYn7t2aA
	1QgLOEt8OLOeEcQWEUiUuLv6M5jNLKAs0dnzEWrBdkaJBd0HmSES4hK3nswHGsrBwSagKXFh
	cilImFPAXOLKgu0sECVmEl1bu6DmyEtsfzuHeQKj0CwkZ8xCMmkWkpZZSFoWMLKsYpRMLSjO
	Tc8tNiwwykst1ytOzC0uzUvXS87P3cQIjg4trR2Me1Z90DvEyMTBeIhRgoNZSYSXM3NPuhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MroscVdqbW1ou
	1dWo8vusitpSsMah3rKmZR7b3quH1x/c+XX5geON+esV8+YGrDh5ccMP96N2YhmnPYTnWQXZ
	XV8osOnX96u9/0qeqaupmXj1T9rqdvM8a8bUUwY+TcJ6yRZBAUf5lPQNba22zPTYrxDolfJt
	6uXja2LVa4/2H9682WTi2vLft8T/arGp/HthVxN/wUe09VG12fyJTLulnvQc3sjUV6GaWs84
	8+vf/G8dr7aXT45lfZEeviyz1nxj6PdAt1nCk6Ma9HMj1I/Nt0lzTQ5erc03KWjqZd/bhYcE
	bEUzd959I/VYP2ADh5ou8/qAY9PjytatrDVjUNpUUlUhc19YrWpmw/N08Y1KLMUZiYZazEXF
	iQAa0yK7/QIAAA==
X-CMS-MailID: 20250225090605epcas5p28c5237f16c0e5d44f7f32b0d8c622cc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183346epcas5p1e0610ba0429f69e98f18511f89d4dacc
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183346epcas5p1e0610ba0429f69e98f18511f89d4dacc@epcas5p1.samsung.com>
	<20250224182128.2042061-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_010616_804181_4589BC22 
X-CRM114-Status: UNSURE (   7.78  )
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

