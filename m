Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3084AC55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=YWUVXkBW0i8pAjTW2GNXYlqcvA
	7l7JBTL0Qis/wIPynDnyA8jYfzz1PpL+JSUhJeSI3XTF0tXU1azqMDf85sH4DG0c5SB2Pb0KcHHD1
	UUm/EIltkAxc8EMW+CC77ffa409e6upGAgmc8nEXvADzYYUTErXQRq0AGSuzztcE8UslFVPOnWL8T
	jGcAo7qx/toHLGTmv38wxbIXu/Po3AiyjE53nXnZmgtI77NsQATtw7AwLy4weVGE0R51qUPrInXrq
	79E7+5MorlzdG+KsRh0adnyDIVwju54DKJGWHm+teybvmu2trLBj550v/l4QYbT7CM7ug50qe1CtP
	j599C03A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPGm-0000000AO2O-1giI;
	Thu, 30 Jul 2026 11:49:48 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPGh-0000000AO1P-3Nm9
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:49:46 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260730114935epoutp0339eb987c272b635c575e89380d3dd32c~HDuoQYyyO0495304953epoutp03j
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 11:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260730114935epoutp0339eb987c272b635c575e89380d3dd32c~HDuoQYyyO0495304953epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785412175;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IDZqUPvxvee1jw1LJ73ZLkGH485ni+MJaag4p2WgSEwOy3d5GTQ82SUXl7g9iCM1a
	 6T2+m2jNCELsEQ8zvLRkfqqenwPGm8tBG6mR1WcBSAURkkh3AC+4RixA05MAVS+syI
	 j7yAD6UctUCVGUYxbIxXltT5gJKwPy1ErOGgnAoU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260730114935epcas5p485abdb95dbcf39aef948c71baf4ac040~HDunn6Nvt2489524895epcas5p4G;
	Thu, 30 Jul 2026 11:49:35 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4h9nYV4QPtz3hhT7; Thu, 30 Jul
	2026 11:49:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260730114933epcas5p303397c7ebe02a7173ac39a8c4294e37c~HDumPH_8M2493624936epcas5p3M;
	Thu, 30 Jul 2026 11:49:33 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260730114932epsmtip10f0fc23839aae50e09725efdea00cb5f~HDulEakQH0699706997epsmtip1c;
	Thu, 30 Jul 2026 11:49:32 +0000 (GMT)
Message-ID: <e523eb20-ad79-4eee-9d13-4709c289356a@samsung.com>
Date: Thu, 30 Jul 2026 17:19:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-pci: release descriptor pools on probe failure
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Nilay Shroff
	<nilay@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260730043105.3071328-4-kanie@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260730114933epcas5p303397c7ebe02a7173ac39a8c4294e37c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260730043144epcas5p356652c0f5bf0cf5272d3f2865178595a
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
	<CGME20260730043144epcas5p356652c0f5bf0cf5272d3f2865178595a@epcas5p3.samsung.com>
	<20260730043105.3071328-4-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_044945_130179_FCFE1DEE 
X-CRM114-Status: UNSURE (   6.47  )
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

