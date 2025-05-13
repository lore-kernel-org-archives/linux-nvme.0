Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625FC3ABCC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=XJn2UX68nz7e6LvB9KSdqMLbdA
	jHIQStnvens6PVXPcdmXQdc+CZZC/oOUt4e2txNUVz94vgAlGtuGxNs0eUIwer2wLdly4bvwbTO6A
	TIzcuFk/zgoEsJBC8IukIekpOse5l2i/JNvTwY9WsD4lYwQsgUIeco0C0Xl7RehwXVuZocgMVbqcU
	EFCy6WDf3YJHksZxYrPg5LVaQ+sUZVxYbT3Nu8RECj03nK+mHF3Wh2+gbPtnM2juRLcnKaMvNb/Ml
	DPAzfv/Zzp4tyihaxqwnr6ZfaVDISImjA1fJykUJsUeGuXXo6Ylcq7x0XZSclX64/PbjCfTU2IW1H
	zjUi6/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqzk-0000000CfdF-494Y;
	Tue, 13 May 2025 14:52:36 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqyh-0000000CfZj-08WE
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:51:33 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250513145125epoutp04e92ca790d0c667cb48126f5f33075097~-Hb7I9uoF3102431024epoutp04B
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:51:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250513145125epoutp04e92ca790d0c667cb48126f5f33075097~-Hb7I9uoF3102431024epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747147885;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KBrLHaAZ3/NxrnnD1Kgsb4H2QtCeb+A7SEU1mDtLhrRQf6hnjokSLQijy2S/BUQNd
	 zbn6PMFkr/4p9qEdDF+/Uhbm8ksQRa8gnRvJmhgKsHNgHMcopmnFkObA4J8ZWFzMBh
	 q+i4fyQxO2/lCKI+nTkCPsUoj3dEPIpNDkPuJ4Ys=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250513145124epcas5p1a287a8137b53e9cc6638abad3ad6f225~-Hb6HWW2v1970819708epcas5p1R;
	Tue, 13 May 2025 14:51:24 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZxfYl10j0z6B9m5; Tue, 13 May
	2025 14:51:23 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250513145121epcas5p4c8087a6e1b04c51e29bad9caa2870152~-Hb3TcAJJ1413814138epcas5p4V;
	Tue, 13 May 2025 14:51:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250513145121epsmtrp2327fffe0e6dc438eb764141aa48a63a4~-Hb3SzLJV0936509365epsmtrp23;
	Tue, 13 May 2025 14:51:21 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-57-68235c69be74
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.7B.07818.96C53286; Tue, 13 May 2025 23:51:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250513145120epsmtip27c31c6161519909a487cef5eee36fe8a~-Hb2RZSYd0659206592epsmtip2y;
	Tue, 13 May 2025 14:51:20 +0000 (GMT)
Message-ID: <4a4d5335-a0eb-4cb4-a75d-5279488ac453@samsung.com>
Date: Tue, 13 May 2025 20:21:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] nvme-pci: add a symolic name for the small pool
 size
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Leon Romanovsky
	<leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-7-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvG5mjHKGwd8D0hb/F85ltVi5+iiT
	xaRD1xgtpvxaymwxf9lTdot1r9+zOLB5nL+3kcVj06pONo/NS+o9dt9sYPPY9rCXPYA1issm
	JTUnsyy1SN8ugSvj1I6lTAVGFdfm9jE1MOp2MXJySAiYSNx8doWti5GLQ0hgN6PE19fHWCES
	4hLN136wQ9jCEiv/PWeHKHrNKHH/cisjSIJXwE7i9LZvLF2MHBwsAqoSGw4HQYQFJU7OfMIC
	YosKyEvcvzUDbI6wgK/E8ra5bCDlIgLpEs+6ikDCzAJlEquPrABbKySwmlHi6XZdiLi4xK0n
	85lAbDYBc4nt884wg9icAoYSX67vYIGoMZPo2trFCGHLS2x/O4d5AqPQLCRXzEIyahaSlllI
	WhYwsqxilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiOEi2NHYzvvjXpH2Jk4mA8xCjB
	wawkwtu4XTFDiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dU
	A1N4ofLUVTHq+3+vXaHBXmu72c+y68/NRaqlbH7Le79nOny5ofdsge3RRMbNH2P+q3dUNrmF
	BhWHXrk9e0HVns3rCh72XTJbY+yi+KDc1EBWMXSCwbUfXZ37ikR6ywymZGU8Ucps7TX6mfNX
	efrMuY4KC1eWn1uU0/dKQWjKl1OuB17cLG4Ve3mh9NaHn0LJbVJnb0xp93WICFQJ/nBiD2/H
	Bcc7YjJ2nEx9x6ybPpzK2nZS+nEly6Vnv6cbRXxx7NBi9bhxvbihK2s266E9kyPeR3SsPFbu
	VD+Ho2Tz5qNvct+fd94Q+OJ6+vtjC1PzZ5THG4cI3nvgJ1YWdnAfz+NLSequlybn+rrVHDio
	tFqJpTgj0VCLuag4EQCCDNnLAQMAAA==
X-CMS-MailID: 20250513145121epcas5p4c8087a6e1b04c51e29bad9caa2870152
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070154epcas5p48f926c8d5813a21fecb508572d2a7c0c
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070154epcas5p48f926c8d5813a21fecb508572d2a7c0c@epcas5p4.samsung.com>
	<20250513070025.830930-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_075131_379190_CE020E5C 
X-CRM114-Status: UNSURE (   9.27  )
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

