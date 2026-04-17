Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CCDF8E498
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtuyOWdi+GVtXcfnLKR1XvMiPQQSqD8kyp7YKeiT74o=; b=0Pfocq4NIw69sEskVDIBNTtek0
	Xuy7ar9e47SEHh0Edpyi4oRZ+rwPSz5N78xTAHXA6LnfljVbiqYoejGyq0lm5eWG43gB2ggCB717L
	PqraDxp7xK/2SA+a8XpAUUSeRlGK7n0diNioeH4+lcRf56Ghmi/5XWtXp91A82MHs4bqhbTtxVDKG
	bHVa5sK8UhhehCJEqVQIzqQoEKhIwaue5ISyrZZ7GksyM9CAaqHubAlfiK7Fk5HQKkyZwOoovijlE
	oUnBOomeRav1ZHLP1MM6jtQ65vfrwBmA3kXepJe+UbK2+kgxFKuaiT6SUgRHjKJfhfeQAS8T8p49N
	jYwo4LmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXZT-00000003G8G-2vKJ;
	Fri, 17 Apr 2026 01:00:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXZR-00000003G7v-1t6E
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:00:34 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260417010026epoutp01f2173ac0591b58ba554ff0a0632969be~m-yKH0Hvc1281912819epoutp01R
	for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 01:00:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260417010026epoutp01f2173ac0591b58ba554ff0a0632969be~m-yKH0Hvc1281912819epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776387626;
	bh=CtuyOWdi+GVtXcfnLKR1XvMiPQQSqD8kyp7YKeiT74o=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=njl0tb9b+O+6SWpZN20PgJqhjEPsPNGJC6HP4j6qmyXMzuxIGx1amz9eRhLGA5nok
	 yXU5jc4XzUGPkp5A/HGz9LK1z5xqFGql52+QXeY5g2kPZ1TlcEk+u772l5tIh3KEUc
	 r8jJJL/wWGZrAQOaw3tM3X/5ncbHIZquGu1ijSgs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20260417010026epcas2p33c4c17c544435ad5bf436098830958fa~m-yJuyR9D1697316973epcas2p3w;
	Fri, 17 Apr 2026 01:00:26 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.202]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fxc4V1KwMz6B9m5; Fri, 17 Apr
	2026 01:00:26 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7J207J2A7IiY?=
	<euns212.lee@samsung.com>, =?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <aeFb8Ao83MTy9jUq@kbusch-mbp>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260417010025epcms2p146eb7ded92868c1598a4582f50a5ce9a@epcms2p1>
Date: Fri, 17 Apr 2026 10:00:25 +0900
X-CMS-MailID: 20260417010025epcms2p146eb7ded92868c1598a4582f50a5ce9a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930
References: <aeFb8Ao83MTy9jUq@kbusch-mbp>
	<20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
	<CGME20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_180033_675626_00BA97BF 
X-CRM114-Status: GOOD (  15.59  )
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
Reply-To: hmi.jeon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 16, 2026 at 22:00 UTC, Keith Busch wrote:
> You're missing the "static" declaration, which was present in the
> original suggestion:
>
> https://lore.kernel.org/linux-nvme/acVCnozG1WKPkq1L@kbusch-mbp/
>
> Should I just apply my local copy? I think it's an original patch from
> me at this point.

Please go ahead and apply your local copy.
I appreciate your help in finalizing the patch.

Thanks,
Minsik Jeon

