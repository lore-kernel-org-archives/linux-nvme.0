Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B267C87FD2
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7nQq3bAqMIxxN/XxLCukV6f4+OY2/BogMqasaFwx3w=; b=Xn48Gf36BlBKvX9sejizIEVvCM
	4qJFQw6HxVV05e5V4by5+2btW1RLRkVUbFE3F68n2FS18GwcR77QO+fIkaOWGAZWZSqpiXWN29lsa
	BVkPONoEidTQHVJ0nKqRxh3qONAVJOgj2k7qSIdMIzffxbsRzKTx/tZLOwQBOtqGpCY/7Ca4eWyy3
	9c5N/awSQ7Wi24Prqz6S4+UG/0veHL5AuYGCB+tuhFHBnan1Q+zPRr5YZx+liXPeIegh8rHM87AAH
	rLr2NR1qxcH6skcA7L93agvAtHYPY0/kwXX6aPfrO6KWfdaWuJ3DfbiSLVarRzUYdezWECYrx3EzA
	2LnNWTcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMcp-00000002qpC-48jN;
	Fri, 08 Aug 2025 12:55:11 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMc6-00000002qki-3ob2
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 12:54:29 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808125419epoutp046af96c509e2d6fadac1f1f47f16708fe~Zy9hCLdft1916819168epoutp04z
	for <linux-nvme@lists.infradead.org>; Fri,  8 Aug 2025 12:54:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808125419epoutp046af96c509e2d6fadac1f1f47f16708fe~Zy9hCLdft1916819168epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754657659;
	bh=A7nQq3bAqMIxxN/XxLCukV6f4+OY2/BogMqasaFwx3w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EdoVoxf1UdlSyQZfNNdMyr8RpWUgowXccwaN/DY1gXThRxgoLelJELbOAOLcLOvWl
	 isfh3m4q/HKBK/iUM8D6zeueM8ciGeUiQJlxpYA49ENOe6yb55otWdRP006pmY+277
	 bQ+FVgrbRY3vZX0ACp7GRmm6Tnz0pbEUr3seGgEU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250808125419epcas5p3b484d595b795a0708e59d5b68d5b559e~Zy9gxCNKX2117521175epcas5p3V;
	Fri,  8 Aug 2025 12:54:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bz3rV3pJmz2SSKX; Fri,  8 Aug
	2025 12:54:18 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250808125418epcas5p4d66269e567cceb4658c965f2991493ec~Zy9fq9tyY2971229712epcas5p4D;
	Fri,  8 Aug 2025 12:54:18 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808125417epsmtip22e814d8c3e62e358ea6a890005f1532c~Zy9e1hL150076300763epsmtip2u;
	Fri,  8 Aug 2025 12:54:17 +0000 (GMT)
Message-ID: <5e218cb4-af0a-49a8-ad1c-21cfb7ac467c@samsung.com>
Date: Fri, 8 Aug 2025 18:24:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 4/8] blk-mq: remove REQ_P2PDMA flag
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250731150513.220395-5-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250808125418epcas5p4d66269e567cceb4658c965f2991493ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250731150528epcas5p1f3970f09cf6e32cf277ba6f38acaf385
References: <20250731150513.220395-1-kbusch@meta.com>
	<CGME20250731150528epcas5p1f3970f09cf6e32cf277ba6f38acaf385@epcas5p1.samsung.com>
	<20250731150513.220395-5-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_055427_453348_0B868D25 
X-CRM114-Status: UNSURE (   5.44  )
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

On 7/31/2025 8:35 PM, Keith Busch wrote:
> -#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)

since this is gone, __REQ_P2PDMA can also be removed.

