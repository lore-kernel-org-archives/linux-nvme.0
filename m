Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D26BCA0EE4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=ctBSOlnFrSZCbUo1dnb5QNw07X
	k6oUrPvcvkhg89h4RRNuU2F0X8lfkgqK7mjovgQvYtKy7uCFiN20hzpucbaeCeiM32hUgOKhn9PzA
	PrNv7+/CEB4ylMLZ6eWKI4g5fcj2iD4BRPeGF0l1/fbxfOwEVnofo1+WYCswT2aqaPGhXZHu0ObKK
	P5r7CrsXClbJVtPcyE5kezafhDavQ/4+jy9aaxS9+VK6qCJ196kgf8iITuaFwhxDolysqYQk1BDkO
	eWkbFWxCgDjNkTlDvGVqKlm5H6QJij8SDvvoSeSIyaeT4EYZdV8+2L/c8muSTRZEqTdzAworDVlUf
	WZB6c7rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYkt-0000000HClF-0HGO;
	Thu, 14 Aug 2025 14:16:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV2n-0000000GZ4c-483m
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:18:51 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250814101847epoutp040754979720ff7a4f285e950d990d9b3d~bmtbSQwXW0291902919epoutp04L
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:18:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250814101847epoutp040754979720ff7a4f285e950d990d9b3d~bmtbSQwXW0291902919epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166727;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=t/GqglrhnCRXJtJXvL07IJFrKC2by+yilid145KvwH8UxyiOMVSA3Wo5BjePBjA6J
	 CLOOhOmBKAAgOl6eU5MJ0kF9vLjt1GuJR0jHZ/JQdB4nt+54GqLiTCbu3jxaU3rXBt
	 t38a1XZFqDy2bLVo8sO3RcIeGtHKv9OciskMw+Ms=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101846epcas5p1a3ce485aa19b78c5148ebfee6c321365~bmta9vAqn1323713237epcas5p1X;
	Thu, 14 Aug 2025 10:18:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c2h6G1X5Nz6B9m7; Thu, 14 Aug
	2025 10:18:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101845epcas5p4c2c3dfd67a80e3e43a91aff66c314c93~bmtZ3-8Ga2778127781epcas5p43;
	Thu, 14 Aug 2025 10:18:45 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101844epsmtip28fec19ebeee122086ab912e968a4a66c~bmtY1U_yX0772407724epsmtip2T;
	Thu, 14 Aug 2025 10:18:44 +0000 (GMT)
Message-ID: <81d5973c-bd9e-4cae-8b2e-d1106c911e89@samsung.com>
Date: Thu, 14 Aug 2025 15:48:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map
 type
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101845epcas5p4c2c3dfd67a80e3e43a91aff66c314c93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153211epcas5p1f2b7ff2536a368d396e32c6bf96fc8c9
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153211epcas5p1f2b7ff2536a368d396e32c6bf96fc8c9@epcas5p1.samsung.com>
	<20250813153153.3260897-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_031850_178431_B2E727D0 
X-CRM114-Status: UNSURE (   4.58  )
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

