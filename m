Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD73CDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 04:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LiVMn0onhVEW2Wd+6arQUDT6btwfH8L2GxpyX+PPJ8=; b=wi/CUBAUFpVooT5/YXuZrVYFw5
	q8O8jkuYXFk3HQs75kAKDfLA6UlDtiCi8ub8PD6oqw3ItmGt9FkNy5en+yu5xGihubhoI6Yrm5XLZ
	+UiB7X+urrTaRpAf29V5rF1kKYTfoaOrIVrCvtPNzEYSMKK5sDabVsEPD3oEgIau3pm+3rk0nRRat
	WHBugjFVfDTOYpi2TjkYWqlLEZxcHAz0Sv8UVFl08DnXLo/b4kvL6IAAsaBdxaAwVkYdaWD84rN4G
	Mpse0EY6qdP6847kl2h5lMK/EfWBXWQD5Z8xMLO6c1PXR6C84OI/XoMc0s2mp5s3AfsG6GeZHiv0/
	dgMocMLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qthJJ-001Cid-2p;
	Fri, 20 Oct 2023 04:40:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qthJG-001Ci1-2P
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 04:40:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E29767373; Fri, 20 Oct 2023 06:40:19 +0200 (CEST)
Date: Fri, 20 Oct 2023 06:40:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH 1/2] nvme-pci: meta-transfer via sgl
Message-ID: <20231020044019.GA11984@lst.de>
References: <20231018183003.41174-1-joshi.k@samsung.com> <CGME20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9@epcas5p4.samsung.com> <20231018183003.41174-2-joshi.k@samsung.com> <20231019054846.GG14346@lst.de> <69b600aa-4669-0afb-467f-996ef30a358f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b600aa-4669-0afb-467f-996ef30a358f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_214030_931857_0EE9DD69 
X-CRM114-Status: GOOD (  11.39  )
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

On Thu, Oct 19, 2023 at 03:24:12PM +0530, Kanchan Joshi wrote:
> Do you mean a separate patch with just this flag?

Most importantly split out the metadata SGL support in it's own patch
as it is a feature on it's own.  After that a flag just for the flag
is indeed a bit silly, so maybe merged into the next one.

