Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23274C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/agtONhmqc1At4bwNflWxm4htUu7DGBt+OsIUXXa7EQ=; b=MxpWSu55N2eSKIcGC5kd3cjeeI
	8IXjoxyvKF+nL6envvcqkL0F2hHimv/0T1bukQVyLsgjxAiKt5CtuUKPjdvWkuoXLUtGUYl02crIN
	gapKJbum8HrkHUhKiCFO2r8jL+6hAEnTnF1Ahn7HhmCNJpceE3ISJW8o9frKTyRtsOwCzc7hZGH5e
	aDns7m9E+SHGNTQVrGl1MStLsWUgpLONDiUp5mugvVigedjLTk8s8oTjEFKi3RwhUkTDmgiUMH9W6
	V0R3SQ5Y3j4YrVrmlK2A87Dg8g3EuAyaJfFCRhA16P7z2Qtnb5jGW+tb2kLRV4zn/5lTxSlj/ZII4
	ClUR5AVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnpP-003jeY-PA; Tue, 01 Nov 2022 09:45:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnpN-003jZo-8g
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 09:45:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7E7B68AA6; Tue,  1 Nov 2022 10:44:54 +0100 (CET)
Date: Tue, 1 Nov 2022 10:44:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 0/2] Granular CAP_SYS_ADMIN
Message-ID: <20221101094454.GA12839@lst.de>
References: <CGME20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce@epcas5p3.samsung.com> <20221031162351.31856-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031162351.31856-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_024501_483175_E5DBF39B 
X-CRM114-Status: UNSURE (   8.81  )
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

Thanks,

I've applied this to nvme-6.2, and I've also extended the comments
explaining the checks in nvme_cmd_allowed a bit.

