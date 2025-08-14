Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A80ACA0EDC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=l21PDWZ/W37uJMcimaaoG/Fuz/
	GXhlfYVqQCMw7GiRe03vv238z4umMQpfIT9WbnNByd0Gam+82924n8qwIavg8pp7m3qwjDQBW80v+
	gRLlNs3plV2JqhrxfQkUvD7rb5gtWAfHytL3FHy+W6389zSQP1u/nNv73oDBHxtLeDburqYVBwZ0l
	OkXeCmJWkFwk4oHxxRMBUQwrUfTdiXoOu3kaJ3ZEIROS79diaCm8rbd3Qh9sbCJ3pujm/gJPHtEMC
	G1vDo+EFeEFoc0yBtST7/Q6RyvugF3ACTyHhIOnGiuqncojhSwZJhCXQOQZcngT0XJHpRpPTbS556
	Fb235gqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZh2-0000000HOem-1062;
	Thu, 14 Aug 2025 15:16:40 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV1g-0000000GYn0-2LRK
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:17:44 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250814101732epoutp046369bcf7eff6a2d87d44a3c6b68f790b~bmsWAd6k70197501975epoutp04F
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250814101732epoutp046369bcf7eff6a2d87d44a3c6b68f790b~bmsWAd6k70197501975epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166652;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gDWd+Q06QXSORMGzRq6uIimPO5t2altkJgjKY0dVhcleqWtI09A1cXSEF0bcHY9cu
	 pKgcJexG0s1uL95q95j4xpF2J2pBAiSE04i8HI35oaHiB/di1LC20HCx4wV+5TFz2D
	 WLAQRqGzwwF/oybPw6yYBgSbr3TazyEOmciGpq3U=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250814101732epcas5p3b4f3470beaac99f7db14a82f3dbaac24~bmsVziEsj3091930919epcas5p3x;
	Thu, 14 Aug 2025 10:17:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h4r155Nz2SSKb; Thu, 14 Aug
	2025 10:17:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250814101731epcas5p3e35e879da59d3431fe098666efe81d3f~bmsUtw--X3199631996epcas5p3h;
	Thu, 14 Aug 2025 10:17:31 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101730epsmtip240974655840b18cd4da448029040835f~bmsT1bZPM0692206922epsmtip2r;
	Thu, 14 Aug 2025 10:17:30 +0000 (GMT)
Message-ID: <09b6a041-2011-4b2b-aff6-2e25bb9125a3@samsung.com>
Date: Thu, 14 Aug 2025 15:47:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/9] blk-mq-dma: create blk_map_iter type
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101731epcas5p3e35e879da59d3431fe098666efe81d3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153222epcas5p49a56589a697f9ba0482a353450f78494
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153222epcas5p49a56589a697f9ba0482a353450f78494@epcas5p4.samsung.com>
	<20250813153153.3260897-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_031741_118898_953AF09B 
X-CRM114-Status: UNSURE (   4.68  )
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

