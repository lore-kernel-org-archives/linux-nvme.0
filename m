Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC85C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=drXdszgr7MYqey5dQ/qlL6r64a
	KRikyM7s4SeX5acT8wmLpA9+qXdgZFRI/Njbjz5yT+NQQe/KUNC5oJckMV3YwlEtUGWDzosrOeV8Q
	Ia9gYk0Y+eonSkA4WRUreyzIrtR7xLoXOErtB70bsRz7TXHzt4wvTaXxNKkaGnEsdWxixGrxZkKZ0
	5vNlByM+EGaR41omzWp5fxAm6yet2N5serbXKqZq3WDJR3EwlUEV/ilo+kCOsG0Hm0iEKnmry8uwG
	xpsf25jcc6TH09mCkgDvuPF3qbps1uUp5IRnxXIIWFrrAA6mVBHFJZ5+Y+V4q6vncLV9LuTODwRy3
	utMYZoxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPf9-0000000DUuZ-38Uc;
	Tue, 20 May 2025 16:17:55 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPGW-0000000DPaq-3ZWb
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:52:30 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250520155224epoutp04ff42b1924253412daa7f51ca54ae9e91~BRyKh8W6f1336213362epoutp04M
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 15:52:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250520155224epoutp04ff42b1924253412daa7f51ca54ae9e91~BRyKh8W6f1336213362epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747756344;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NfbqlCSfumAyB5l340saKmOe7EBLoq1wAuQbdjFYpVOB4rMXS7ykGDPhU/vyjo6eg
	 EiIamoyLMdXk6cMgZqT0ca+AUFpq4zfCi94XIb3shaKBDsqeiDZj62IsCCqJzxf0wM
	 9jvqZ0EFm/zgSfArK07yISDricmCCr3YhBw/rDAg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250520155223epcas5p29ac9cbc3125a92d124282fa391229441~BRyJjqK6U2239322393epcas5p24;
	Tue, 20 May 2025 15:52:23 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.176]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b1zZt4gHSz6B9m4; Tue, 20 May
	2025 15:52:22 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250520155221epcas5p2dc13aec89ed6a7c1f95955e127f168ba~BRyH8Md5K0380103801epcas5p2t;
	Tue, 20 May 2025 15:52:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250520155221epsmtrp1459d3f9dd611fdbcd99b8d61ff8e1959~BRyH7k1Pz0363303633epsmtrp1E;
	Tue, 20 May 2025 15:52:21 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-94-682ca5358516
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.E8.08766.535AC286; Wed, 21 May 2025 00:52:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250520155220epsmtip1ee7aed494b7f8215a14eaaad5d0efb53~BRyGp8BOU0968309683epsmtip1L;
	Tue, 20 May 2025 15:52:20 +0000 (GMT)
Message-ID: <47c2d651-5af7-4cee-892f-92ff72c2820a@samsung.com>
Date: Tue, 20 May 2025 21:22:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: enable vectored registered bufs for
 passthrough cmds
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Anuj Gupta
	<anuj20.g@samsung.com>, dw@davidwei.uk
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTtd0qU6GwbH5ihZNE/4yW8xZtY3R
	YvXdfjaLVzPWslmsXH2UyWLSoWuMFvOXPWW3WPf6PYsDh8e1GRNZPHbOusvucf7eRhaPy2dL
	PTat6mTz2Lyk3mP3zQY2j74tqxgDOKK4bFJSczLLUov07RK4Mk7tWMpUYFRxbW4fUwOjbhcj
	J4eEgInEhzWfWLsYuTiEBHYzShzs+s8OkRCXaL72A8oWllj57zk7RNFrRomfKz+ygSR4Bewk
	Hp5eyQpiswioSvx4cpMZIi4ocXLmExYQW1RAXuL+rRlgg4QFQiWm35oHNkhEYAKjxJWH+8AG
	MQuUSuz93c0MsWEDo8SudSdYIBLiEreezGfqYuTgYBPQlLgwuRTE5BSIldi4UgCiwkyia2sX
	I4QtL7H97RzmCYxCs5CcMQvJoFlIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10v
	OT93EyM4srQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5VmzUyhHhTEiurUovy44tKc1KLDzFKc7Ao
	ifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAx1cZJTp9lLmGccWRXNGsiy81Vs47z2O/SD5z8
	WdzcriS/7+CcySpBzt5dd137MrMjWhkCHH/Mcehmrlm0p/pdVg7/YpcItfxsvU2cOocDihgZ
	pZ5syrq8b2oW2/U7LWJRhz7NX+BxbWXkt8r9siez9H+/bjD9+CchMvbIxvkx5z7WVIqk+qxV
	ZNNt7Fm8YNryhX2r5su1/l/Hnm2c2Bhz8OCrcIaHxzac6dvZa9l+1XhnpVU84+xDl/YzSxhK
	BH1maOqob5qbN3sjy+ZJq+6VSDT0Mtw7eGBd0041628HDiSVlpVsWmioWSccmmT1adqvhSet
	T32a+/Jbi/P972fNrvq7Swc4T1HiPXDL/owSS3FGoqEWc1FxIgAuImmkGwMAAA==
X-CMS-MailID: 20250520155221epcas5p2dc13aec89ed6a7c1f95955e127f168ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250520152111epcas5p27d108cbc62386e9e078c43bf6208f78a
References: <CGME20250520152111epcas5p27d108cbc62386e9e078c43bf6208f78a@epcas5p2.samsung.com>
	<8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_085229_196238_0DF8B792 
X-CRM114-Status: UNSURE (   9.68  )
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

