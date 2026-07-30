Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C35C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L4EDY/jtfMF8o5EnYm+BV4FTE+4q24E5jSx72xCBHTg=; b=1HQV0LhtPZMqxym48S7rF3hpwV
	cwoR7Q0zew8fw0u8J/hfJh2R7kjBfSYGUHvdNvHczddWhAkVJ8Xz87DnOlON8Wd0O9lPIj/6Z5vdU
	qUwWCGJu6kY8Y9ZhOh3dRtqrSAiASG3zoaRgK+fkG747yY3rqJ3pxGdIgLd+j7GlDW+ludtzeILOP
	T9L2fGdpmay8RP3vTIFFBCzRmdNymxtdvVhsEMGceUBKi1Hu2p1UomX9uJ4cf4ATYV462uDkApfxE
	6gP4ZTzUAcSOb7K/OX/9zBCv4lzS+kkf7zQAtatbhxFY+NhEUmPfkM2txDpOhCBvf6z+Um5zZVyW6
	Y1dmmWhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ4P-0000000AUYu-1DHR;
	Thu, 30 Jul 2026 12:41:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ4N-0000000AUYm-30xe
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:41:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 77B7041563;
	Thu, 30 Jul 2026 12:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B931F000E9;
	Thu, 30 Jul 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415263;
	bh=L4EDY/jtfMF8o5EnYm+BV4FTE+4q24E5jSx72xCBHTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SrmRK3ODWJVPdJ30iK6cJuoctIW29qNZbx8w80+o6oEVt/1CyWrWUh0GyJpHVsVi9
	 5KQTem+mGG1XT9RrLyEk7teMIFwy53mtM1p1wC2wJ0GX4gjyLuvsSvimA3Z0ZPNoEf
	 qXRZ1ZB3utiXQy9AiDwX3cSNKuwzCDV1YuKvSPkhq/HLbiAgKFbUAVEcoaBtm/0p95
	 iwN93icpgxXRjhymibUFWVFiWdzAG7XP09TBLdn9qO6WzdFbTMGZmjSYyfYZCwCpVl
	 EibhftPVHJ0wty7clUJD8mn3UL9+kaWIDBDachns0fjCS5M++aH7JOorJSdkl/QPb7
	 2ppQRWFiczP5g==
Date: Thu, 30 Jul 2026 06:41:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the buffer
 size
Message-ID: <amtGXbjK7Vticrnq@kbusch-mbp>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <CGME20260730051151epcas5p1c47d82291b2bd4437fcf14e7816c4c8e@epcas5p1.samsung.com>
 <20260730043105.3071328-5-kanie@linux.alibaba.com>
 <749b4476-6d8c-4573-b51b-662b0ff57db3@samsung.com>
 <20260730113722.GD25454@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730113722.GD25454@lst.de>
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

On Thu, Jul 30, 2026 at 01:37:22PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 30, 2026 at 03:10:59PM +0530, Kanchan Joshi wrote:
> > But I feel the need to improve (what we have) with a follow-up patch:
> > 1. Revise the cap, from S8_MAX - 1 to U8_MAX; since bio->bi_write_hint 
> > is u8.
> 
> Signed 8-bit -1 is indeed a really odd value, and from looking at the
> original commit I'm not really sure how we arrived there.

"S8_MAX - 1" is a weird way to represent it, but the reason that value
was used (and it's admittedly not a good reason) was that the result
fits in a page. Not that there's any restriction on admin commands using
PRP lists; it's just a coincidental limit for all the driver initiated
admin commands.

