Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9798C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=0tWf6W/rKEp4wpm4pff4a+5tMs
	I5BRnr68/n26NUqyYFgQXiA6WE/3D5XLR+7ZybvxkFC5lCkYESTJGAs/aha22IYJRgPjh9iiit112
	RXr5y2Fn5tpZNd5b1oHtObnruktZLNW6sfO/23DonZYLQGWVDdyuDJYjWvgbNNDktAp3WDGFAofHk
	xKfbE3KTucp3jua8pUTl8ECtZlngnvUQGLteZIE/O/aEZLhT0ZoNDsGvSGyHQKekXxUCntu9THWh5
	LPSChrUYqqTCQz7feDO+LHg62M5iReBygsLMm1ZKpm9xPr/0yAo3XlN+XPSGz4vL9yotLg55oTUKY
	sitrrHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEr43-0000000CgY9-3arD;
	Tue, 13 May 2025 14:57:03 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEr1v-0000000Cg9f-2CPE
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:54:53 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250513145448epoutp04f5dcb7fb51c0c15d4d5d57fa81a9d8a1~-He4I56N50334103341epoutp04W
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250513145448epoutp04f5dcb7fb51c0c15d4d5d57fa81a9d8a1~-He4I56N50334103341epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747148088;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DYUwVjUA7toBPILcMf1CCXJVLDzPmQvfUjZQY3MlNpmHtNhH9JPpeR1pvz2hhtUj1
	 nrKyhAE+40daFWA3tIUYXbNIZKL6PW3iJAwnSTDHq1D8kp9rqtH1Rlc8G57j74QEfJ
	 yQF2iMbJhUnHJnqlmmodDAxK7nAgqd2XVW0K76uM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250513145448epcas5p4fef93b56fac88fd0fca4af391ba96a04~-He3tTZdf2322323223epcas5p4C;
	Tue, 13 May 2025 14:54:48 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.179]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4Zxfdg30cVz2SSKY; Tue, 13 May
	2025 14:54:47 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250513145446epcas5p2d48fb746488bbf3e49147004a9d2f665~-He2YUH1h2349023490epcas5p27;
	Tue, 13 May 2025 14:54:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250513145446epsmtrp27083b4ab2b2b86d34e04a9c138c75747~-He2XrWpd1045110451epsmtrp21;
	Tue, 13 May 2025 14:54:46 +0000 (GMT)
X-AuditID: b6c32a2a-d57fe70000002265-1c-68235d350e2d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.B9.08805.53D53286; Tue, 13 May 2025 23:54:45 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250513145444epsmtip1080cfdd3965e8e55bf0c44c1f8e773b4~-He0kyxAW1940419404epsmtip1R;
	Tue, 13 May 2025 14:54:44 +0000 (GMT)
Message-ID: <caa66c51-9488-403c-be0b-3f6bbe03a7a6@samsung.com>
Date: Tue, 13 May 2025 20:24:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] nvme-pci: use struct_size for allocation struct
 nvme_dev
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Leon Romanovsky
	<leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-8-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnK5prHKGwfsjehb/F85ltVi5+iiT
	xaRD1xgtpvxaymwxf9lTdot1r9+zOLB5nL+3kcVj06pONo/NS+o9dt9sYPPY9rCXPYA1issm
	JTUnsyy1SN8ugSvj1I6lTAVGFdfm9jE1MOp2MXJySAiYSNw83sEOYgsJ7GaUaN9vBREXl2i+
	9oMdwhaWWPnvOZDNBVTzmlHixN/7bCAJXgE7icOHloMVsQioSlxe8oYJIi4ocXLmExYQW1RA
	XuL+rRlgNcICwRLrdv9k7mLk4BARSJd41lUEEmYWKJNYfWQFK8T81YwShw82M0EkxCVuPZkP
	ZrMJmEtsn3cGrJdTwFCidZY8RImZRNfWLkYIW15i+9s5zBMYhWYhuWIWkkmzkLTMQtKygJFl
	FaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcJRoae1g3LPqg94hRiYOxkOMEhzMSiK8
	jdsVM4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpgSu01
	Y5vbvc+6r2gz960rnQKiFd9Otf/a11uj+PgT75tFDVPDlrgVH58l1fNmc2wg89Y3HVPvT1/x
	X5Op+gsb25rlFy6aXLy7dPGcB23SivdO1Cu4e2Y0TrQu7TSZzL763s4z03Iv5q/LeV2WbmZs
	FyHDt19FrVUk/cfUvcHzWrsM8sJ5DPJan0V8Dfou+qqLOzeJp0OQX2995xHl+zpqErxd32X+
	P3O9evLV1DkLGn5sCNw6VSj0cEuA8KP/mVzT9T8E/JimtuSzurg/086y9VlGDzbO+mmw/+m5
	j0xJwn56P470cF7Sv26rudsmSzd939EdL+yP/P8wrzY0aVFAR/ZtnR/fc8KLrRZkf3usq8RS
	nJFoqMVcVJwIAOQKG+4BAwAA
X-CMS-MailID: 20250513145446epcas5p2d48fb746488bbf3e49147004a9d2f665
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070205epcas5p3ef3127751ccc24ebc8f4c0a7a4d0d8fe
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070205epcas5p3ef3127751ccc24ebc8f4c0a7a4d0d8fe@epcas5p3.samsung.com>
	<20250513070025.830930-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_075452_272184_B4CBF6B7 
X-CRM114-Status: UNSURE (   8.71  )
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

