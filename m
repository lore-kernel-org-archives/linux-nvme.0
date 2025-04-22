Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A99C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsoLIq4WePyRYtX7QbmOwDdzfqlU/Tak/bxwhwxrhDg=; b=VIduBmXwXlqA5rxu2MSsp8m6UV
	9yRdPFpPruIuKmqtZguSAYrOy0mVvqO+MKM0NpyHGIjq5Gf26YMPOQLHzDaWznQBGNIlyU325VvTk
	7XT8ke6wyWQQirBEBvDEtRrllSjmXByLMIp0meUdLQywsPFbyfJc06loRtYwVxWF1mg7XPS0v+6TN
	EsHlpR95xyUTsP53O1Yg+F0NTJbIMRdJ3w3QziP/D7uPTfbVJDE8H9hjPtZHW7YMXGRU/zk6TDMx9
	1/hFC5WvRCyu+jKqZfPoDAzLSmB+M2d0vg6ZQHCnFJg3fhuIAuGUP6zyvdpqfVEEB7q9D7HgwV3XP
	PtQyHXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797S-00000006LIp-0oAX;
	Tue, 22 Apr 2025 08:36:42 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78D3-000000069RM-1wMR
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:38:27 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250422073820epoutp019c292bde6b20e7e7dfea4048067a65d8~4k_yvBmtz3205332053epoutp01c
	for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:38:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250422073820epoutp019c292bde6b20e7e7dfea4048067a65d8~4k_yvBmtz3205332053epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745307500;
	bh=IsoLIq4WePyRYtX7QbmOwDdzfqlU/Tak/bxwhwxrhDg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PrrjEgHQnnCwW8DN383Jymyy1ILwO2mtaGoPTUTh1mNf10Mk9Ux9ynJ/g3kWQuebf
	 lrg8Vr30hTqGxbXmOmfyvwaN2+xg1ZpIPu9+jgH53UNkY/wXJbaMQWju3gKBcvZpmU
	 tsOrKJNA5x4J3S75CijQ2iHxE9KYKd4KEYMJ3Zic=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250422073820epcas5p278a7dc220a17e59ac3f02bc959a28043~4k_yjQrRP0661506615epcas5p24;
	Tue, 22 Apr 2025 07:38:20 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZhYxk1wF3z6B9mB; Tue, 22 Apr
	2025 07:38:18 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250422073817epcas5p3ede778f39029e874aaf3c7f6538b34e9~4k_wUbKnv0299202992epcas5p3h;
	Tue, 22 Apr 2025 07:38:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250422073817epsmtrp20dbbe055a92bcca4bac310be3cf8f62d~4k_wTuDZK1036710367epsmtrp28;
	Tue, 22 Apr 2025 07:38:17 +0000 (GMT)
X-AuditID: b6c32a2a-d63ff70000002265-34-6807476965ac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.42.08805.96747086; Tue, 22 Apr 2025 16:38:17 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422073816epsmtip2f7c0fd07dfa8a4afdac43aea1ae86d83~4k_vKHH3b1940319403epsmtip2k;
	Tue, 22 Apr 2025 07:38:16 +0000 (GMT)
Message-ID: <d6437a1d-8bee-4655-a7bf-e9254b2d881f@samsung.com>
Date: Tue, 22 Apr 2025 13:08:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250421165525.1618434-3-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXjfTnT3D4N1hNYvVd/vZLP4vnMtq
	sXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5vH
	toe97B6fN8kFsEdx2aSk5mSWpRbp2yVwZZycuZa94AlTxYG/W9kaGOcwdTFyckgImEjcWXeW
	sYuRi0NIYDejRPPNk1AJcYnmaz/YIWxhiZX/nrNDFL1mlHhz7zALSIJXwE7izrYNrCA2i4Cq
	xMaZLxkh4oISJ2c+AasRFZCXuH9rBtggYQFviTOrX4MNEhHYxiix+8NeZpAEs4CDxIWr3WwQ
	G44zSqyfs4gdIiEucevJfKCTODjYBDQlLkwuBQlzCthL3DzexgpRYibRtbWLEcKWl9j+dg7z
	BEahWUjumIVk0iwkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcSVpa
	Oxj3rPqgd4iRiYPxEKMEB7OSCK95EHOGEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATS
	E0tSs1NTC1KLYLJMHJxSDUwx/J05RUs656Su7a86dbBCYd2TPRHbS2RmfLvIlWu2+c0kPv2T
	p18p3NbdGnaPT2ETq7tr8jvBwwnT6vLqguVn6LKmy5TOnmd1Mr1/qbhxkF6RukPd8vuKC7cW
	tmybGVnhqv9QZ8KyzhdHjFbGGeXL+pj6r7EoffxJ5bv1K7etyyJk96yNW7d+9ZqPitb3Mkw2
	K/OKyPUrft6T+7+1PWf6gSd5v0sFDA3cWm+wq2tvuXLw/LOwsO3bVcW1ilZf6911X2XqjKn2
	9QYPr1Ytel7FOvvtrgUGh+/kF0TrnHi8/WNZ6N2b//6HbJoxOdR5JSdT8AQvnpb+MvlgOVWr
	AIfewjo+foX1pTutlgq8fKTEUpyRaKjFXFScCABHZlahEwMAAA==
X-CMS-MailID: 20250422073817epcas5p3ede778f39029e874aaf3c7f6538b34e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250421165557epcas5p3defaf797e86f5edfafd6dcdd59cff709
References: <20250421165525.1618434-1-csander@purestorage.com>
	<CGME20250421165557epcas5p3defaf797e86f5edfafd6dcdd59cff709@epcas5p3.samsung.com>
	<20250421165525.1618434-3-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_003826_129940_044380E6 
X-CRM114-Status: GOOD (  13.69  )
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

On 4/21/2025 10:25 PM, Caleb Sander Mateos wrote:
> +	prp_pools = &dev->prp_pools[numa_node < nr_node_ids ? numa_node : 0];

Numa node values are always in the range [0, nr_node_ids - 1], so is 
this condition "numa_node < nr_node_ids" really required?

The patch looks good to me though.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>





