Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6253EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ihke58UT1+BMZYp40n1xuCpAdhvlNF8D0FiHwCIyMl4=; b=xFLD3Q4dYJR8hyYuBHWeaVb3N/
	1NQyK2IcdPAlstM2BdsAjGOFWvdrI1TvT2/xuqA/V6bibXgVjl/KNAFq7dJXk1Qw+WlhwVX2wFFA3
	ttSeBOGbwfniFB/dlKMxAI9EDPt9VL5WrW61doIHr7fz9ntuARYrS3Q7xQgOYFReg5RYTHm2TlsnO
	TA93xO2sD++RMvS346IufbsZNFT8doEf+7wHU2gu2oTiCb8vT9RL9QLG2gk9nIjlfekidKFi9av0P
	NN8etc6PBh1fYzVZ/Kh/J72yj7BMOiXFt/q1k3BbTtRYj3ufEFMG+sR4e/YF7dcM4CCnP2hPdmeOr
	KxOBWZ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZ5f-00FGiz-6C; Fri, 11 Mar 2022 06:49:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZ5c-00FGiJ-Hr
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:49:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CF83168AFE; Fri, 11 Mar 2022 07:49:25 +0100 (CET)
Date: Fri, 11 Mar 2022 07:49:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 13/17] nvme: allow user passthrough commands to poll
Message-ID: <20220311064925.GB17728@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152720epcas5p19653942458e160714444942ddb8b8579@epcas5p1.samsung.com>
 <20220308152105.309618-14-joshi.k@samsung.com>
 <20220308170857.GA3501708@dhcp-10-100-145-180.wdc.com>
 <CA+1E3rLEJ49jp678Us1C3ux2iu4KWT9FF+iMjY5_Ug2MAU1q7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLEJ49jp678Us1C3ux2iu4KWT9FF+iMjY5_Ug2MAU1q7w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_224928_766028_C1810E7A 
X-CRM114-Status: GOOD (  14.36  )
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

On Wed, Mar 09, 2022 at 12:33:33PM +0530, Kanchan Joshi wrote:
> Would it be better if we don't try to pass NVME_HIPRI by any means
> (flags or rsvd1/rsvd2), and that means not enabling sync-polling and
> killing this patch.
> We have another flag "IO_URING_F_UCMD_POLLED" in ioucmd->flags, and we
> can use that instead to enable only the async polling. What do you
> think?

Yes, polling should be a io_uring level feature.

