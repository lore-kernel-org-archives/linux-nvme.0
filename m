Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AB8C369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=uhJzTza6dZEjX0TlWtAwInP2mA
	pYCoywV4XZo+Uxz4DiKc21A3DHZmhD+85S3s0qe3H/y4Jja2PNr5fvV1pPVXxXiKqH7OumdJD5a5m
	jNQUUF9N5sWrTl7SyDEEgW7nfDRzfY07Xq9DECAb67GarGLQvvJqRbdclj+FRNkAr1p2gcI6q0Uz0
	rQKxl73z5NYsOtfoiBfTKnPM/fD/Ysp3jTUE+r5YvztNQ1eO/IFjruKAbhAYEhEiDlSuJ5eAdQYEZ
	4S4XFRUYVs1yjNskSEhM+Cjh6A1lkkTwcUCDBZ3nmWB8VZNIqXo/UeShC9Wuu2Q9cPe33KKx/RAYZ
	sxlMkBWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797T-00000006LJN-0eWt;
	Tue, 22 Apr 2025 08:36:43 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78D8-000000069Sw-2Q0N
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:38:32 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250422073826epoutp0425a50dede957467b513dd96a3cae5d26~4k_4OpjTP1694416944epoutp04T
	for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:38:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250422073826epoutp0425a50dede957467b513dd96a3cae5d26~4k_4OpjTP1694416944epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745307506;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AitFprGG79mLV4uXkvP/3UU65h45DzTZHAQDxAHdxZAZC/EmearSivYxf6jPqKiK6
	 7Sd1YF6S2acOTgnqf/mZ6YaeNaNfL8g33xRsbXbba2DNmiJx8Sn65Y9UpU9bxUWkv+
	 5VbPLBtN5a9aXbB/D+Y5+ZX05hex1uQ/Huv9F3Y0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250422073825epcas5p4c49fa59e7a7d256c869c7bf61902edfa~4k_3uLddJ2963329633epcas5p4d;
	Tue, 22 Apr 2025 07:38:25 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZhYxq4HP9z6B9mB; Tue, 22 Apr
	2025 07:38:23 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250422073822epcas5p1f236374806c4ed2f5403357800d6303d~4k_1F-2wA3032130321epcas5p1L;
	Tue, 22 Apr 2025 07:38:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250422073822epsmtrp2ce36107c0e9e4e4d0c2245281428d769~4k_1FUGEe1036710367epsmtrp2E;
	Tue, 22 Apr 2025 07:38:22 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-48-6807476e9b90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.12.19478.E6747086; Tue, 22 Apr 2025 16:38:22 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422073821epsmtip2421a6fd931eeda0507550bb398e6545e~4k_z87bJg1922619226epsmtip2k;
	Tue, 22 Apr 2025 07:38:20 +0000 (GMT)
Message-ID: <8d55c7e6-c753-4cef-9f15-a1ef91281b22@samsung.com>
Date: Tue, 22 Apr 2025 13:08:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme/pci: factor out nvme_init_hctx() helper
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250421165525.1618434-2-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvG6eO3uGwfQ2PYvVd/vZLP4vnMtq
	sXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5vH
	toe97B6fN8kFsEdx2aSk5mSWpRbp2yVwZZzasZSpwKji2tw+pgZG3S5GTg4JAROJo2+es3Ux
	cnEICWxnlOib+40JIiEu0XztBzuELSyx8t9zdoii14wSPVs/s4AkeAXsJN4f2wzWwCKgKvFq
	1lw2iLigxMmZT8BqRAXkJe7fmgHUzMEhLOAhMbkhEGSOiMA2RondH/Yyg9QwCzhIXLjaDdYr
	JHCcUWLP63KIuLjErSfzmUB62QQ0JS5MLgUJcwrYS5xZMZUVosRMomtrFyOELS+x/e0c5gmM
	QrOQXDELyaRZSFpmIWlZwMiyilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4crSCdjAuW/9X
	7xAjEwfjIUYJDmYlEV7zIOYMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2amp
	BalFMFkmDk6pBqadbwq9E6MnLo02FRNskJLhNffa+zDw37+mK/83i4qor9ypmXu39r8Xq9sr
	85OTfeV/7vRq6GJIcqvYYMF5ze7D6aOPuaJn1MurL+HRunXdsXf+Kv6ZQmbVRSlJd39N2i5d
	zuzON8f88j+tBfcVzhcr5zb1yVsxyq50fDvD3MAx7XSU/ecZ7/lcG5beYruWd6PM884BraLf
	q+zXsby6KLh3VVB2xHHdy8eeBDH+UVOcEnZ6irEz59PvUk+Tv84yOMsSGBYifT+we87aC2Zn
	GY9kplnoWQaHsci7BHOK6P+MOL/81M3MGLO0Df3y13pvPXh9d7mp9tUdbp/P3HtUts3MV+ZZ
	25LlSeFhaq/90pRYijMSDbWYi4oTAXvXp4YLAwAA
X-CMS-MailID: 20250422073822epcas5p1f236374806c4ed2f5403357800d6303d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250421165556epcas5p156fef8877292ef2d395cf372aaa21721
References: <20250421165525.1618434-1-csander@purestorage.com>
	<CGME20250421165556epcas5p156fef8877292ef2d395cf372aaa21721@epcas5p1.samsung.com>
	<20250421165525.1618434-2-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_003830_935369_A99332D9 
X-CRM114-Status: UNSURE (   9.32  )
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

