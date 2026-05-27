Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEDBCD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l59s0fNAl4RuOQhAf+XFh+T2wNDwWFyo+YhMvt+Ib+s=; b=gtg9/+p4o0CZTF0LcYqt5tflVv
	HxrH1HQVhpLrAe0LbtjCKSfbuD+9f+O1/tDb+pgCHDs1t/bAuoa3JQ7c6jCQhJwLesoT9xfhoJ1TG
	7m5phflqurkqztW7ecEJHPX/BdRa3wZfsAfSe4XMUvKN+M7YcbUZNa2LHVYMVSK+MHJVXiXFqpIFh
	350pVF3wMdLn7M/UqT6gRUOcqsvt9hBgNK69sl+Kzc5sUDJc49tRpI1QMVo621tR92hqleTWCkBIK
	8m+OONeV/vwCIPac+HiTGZIbdgedtn3b703nkdkJDk1fsJrhmwhqzNxJhZ52byNseeIeYFAanY9W+
	Afy+R6cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS89B-00000003QWu-0J0w;
	Wed, 27 May 2026 06:53:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS897-00000003QVD-427k
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:53:43 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260527065331epoutp02aac87b0fbecd6c17f06e600800665829~zWZ2avYHz1635516355epoutp02j
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 06:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260527065331epoutp02aac87b0fbecd6c17f06e600800665829~zWZ2avYHz1635516355epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779864811;
	bh=l59s0fNAl4RuOQhAf+XFh+T2wNDwWFyo+YhMvt+Ib+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpHalGQv+/gAmHfsXMblGC13fBalRHgwci/qMIdZAB/cTHwgrs6nDxqomSeYYc1cv
	 k0g5MntVKoL6aeNFIvlGOq03HrzLfXr1JE7rdz+YBuQWPkZT+Ss8s2YyTyd729v134
	 40fRHtPN0kck6o21YITyf5ki10gXERc65JH39jEE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260527065330epcas5p114007b29d70e82c524822093cc216ad3~zWZ2Fjrcs1217812178epcas5p10;
	Wed, 27 May 2026 06:53:30 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4gQL1P5ZDZz3hhTL; Wed, 27 May
	2026 06:53:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806~zWZ0seu6N0256402564epcas5p3B;
	Wed, 27 May 2026 06:53:29 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260527065328epsmtip242fea4b9fbe9b6fc797f313783452c60~zWZzmL39C0795807958epsmtip2k;
	Wed, 27 May 2026 06:53:27 +0000 (GMT)
Date: Wed, 27 May 2026 12:16:59 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527064659.ulxmr4sq3bqkjv2h@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
X-CMS-MailID: 20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806
References: <20260526153921.2402015-1-kbusch@meta.com>
	<20260526153921.2402015-2-kbusch@meta.com>
	<CGME20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_235342_162943_A389E904 
X-CRM114-Status: UNSURE (   6.89  )
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

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/26 08:39AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>A user can enable io accounting for passthrough requests, so export the
>helper that checks if the request should be tracked. This will enable
>stacking drivers to to report iostats for passthrough workloads.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_
Content-Type: text/plain; charset="utf-8"


------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_--

