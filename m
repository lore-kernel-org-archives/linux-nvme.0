Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE8F9B5FE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQfmN7Imo5QJIrzm50RPQSdYS48vXrojJJEQeXD/dUY=; b=LZqhcB9NlL998ePc4Qi5UzR0UJ
	8yRWGR+xvlUczGwL15H8hfM9Z8cUSnX0PtocEM61XSnsHMmGx6lA8q3SsxCMYTpEA4IFr0dU/LcfS
	k/2mIGG0w+irlyhheNBtxcMWK+yS3IOh6bP6fwZJw2I2edAi5eJKihyRUz9qqurNmpDCFpM7T2YmZ
	qRtRkSdiRGhyaOTxBeB4d4wp/pE6Q5zbDD+j0vAXuxPpHZoU2OstyTYprFZ/tF7AOVYRQNFypaQJf
	LCBhE0V7gke8BoO6CtDJhx3IantryooYGob5rOV+Q4m+OkJCTzRyzDbGehjPb3BThIwWC9rAiqouJ
	7s2eDB0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFU7a-00000009sQQ-1fAN;
	Wed, 22 Apr 2026 09:43:50 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFU7V-00000009sP7-32sP
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 09:43:48 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260422094333epoutp014bde2759be4e33376c68f0c4c2ea11fa~opJUo-uUr1753317533epoutp01x
	for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 09:43:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260422094333epoutp014bde2759be4e33376c68f0c4c2ea11fa~opJUo-uUr1753317533epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776851013;
	bh=eQfmN7Imo5QJIrzm50RPQSdYS48vXrojJJEQeXD/dUY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gtlfK4PgyTgWXkly7b9at05WNZdhGgTK8dmV8qZPrH3KcmxC7OBIWXzRv8Y6vt/AH
	 LrvJqm3km52zo8zQ/EytJEzLZrmUX+ePS+VTnvm+ok5h6DkJqtF6quh7SdwRACuu2O
	 M4wMgk3FXl+LPS4a3+sScT6o781vQooY9/7LXZbI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260422094333epcas5p26c63585054b0d4515aea9e5352615939~opJUbC5ut2432324323epcas5p20;
	Wed, 22 Apr 2026 09:43:33 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4g0vRm5Ngwz2SSKX; Wed, 22 Apr
	2026 09:43:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260422094332epcas5p289d29541046b0d91df31fc3389bfdacc~opJTlKCg61452014520epcas5p2t;
	Wed, 22 Apr 2026 09:43:32 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260422094331epsmtip29002369fd67582dad7ca8231d52c3f0c~opJSqrAAm1158911589epsmtip2j;
	Wed, 22 Apr 2026 09:43:31 +0000 (GMT)
Message-ID: <4460af94-5430-4296-9696-6dccd2ba0b78@samsung.com>
Date: Wed, 22 Apr 2026 15:13:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: fix missed admin queue sq doorbell write
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260421161855.3980034-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260422094332epcas5p289d29541046b0d91df31fc3389bfdacc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260421162015epcas5p3ba67958507806dd09025a2a85b3ddf89
References: <CGME20260421162015epcas5p3ba67958507806dd09025a2a85b3ddf89@epcas5p3.samsung.com>
	<20260421161855.3980034-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_024347_064602_138E5EF1 
X-CRM114-Status: UNSURE (   7.98  )
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

Thanks.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



