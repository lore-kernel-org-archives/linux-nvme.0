Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E83C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AJPYev9AsKY4X5Q3U2Yk4ItrSiHsK/f+QWOu8v9Ghw=; b=1u3cOvS7BMg6stjYsQ5NqV/o5M
	dM+qWIDEKc7a4zHfkTGwfP0rue+0/gPX1L9j1FVnSY+bSLATYyzBkCKBU1K41ZckxDOs9dJYrylM/
	EJs40GqC0CFACdkUhrS+R58yqAZ/bWpsh3TUdc/B/mkau6TKcL1Zk7A2AGpt2PbC72sOO38mIINKb
	ANDY0K7i93rzXkVzupxp1EBAroAh/qX1Ns+wpBdZk8TrslD92tCMnaDjqNuNrQ91BZwgpQDasogiV
	BPk5vZR+gOXLvkIphTc8kKAjiz8YQnxU8kFN7SpcIQVhVCLlu0lmLTMiwHdBU1Z3OTyEs7I5WKN3M
	wW/NpQnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDR9i-00000004OA7-3dbT;
	Fri, 09 May 2025 17:05:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDOme-00000003xLk-17HU
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 14:33:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F004F5C6C5B;
	Fri,  9 May 2025 14:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E6DC4CEE4;
	Fri,  9 May 2025 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746801183;
	bh=tuvdgIcQewKEDTQoLF8MaVq24PYwXl4eqbqK8W084lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Emf1Ho2WRcu63KGXGN2dhX0LV/ugRrkUCjQuvG7lNqC/BwH8YW5d22HRS/XvTPHgF
	 WN4yb/dQBmnZjvQ+RpkTFN6pColU15lukV+0fYz/pRTCa+NNP518eA0p7U/VqntTLz
	 x3xkMRqNEGLhWvvl9gJPJ3iXT7NuiYXFYMnboBtwfE5UPfypTN0iUvwhnV0raMsDaI
	 KQLO058LQ/MZyv7kbXWTZH9WcbZpcjLx6Zqum9jWt7JMTSKFtYuEw8ynwZAZYXiFh0
	 KBtFbN4mGJXZfgeBz7aTLOpZ9nGR3fklVLQwS0WMekqGi2DW3aEU0fwyDHv2jjF/jW
	 BqQpvsoIIsrwQ==
Date: Fri, 9 May 2025 08:33:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <aB4SHKuSiuewRltB@kbusch-mbp>
References: <20250508175814.1176459-1-kbusch@meta.com>
 <20250509041949.GA28563@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509041949.GA28563@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_073304_342928_1DF09659 
X-CRM114-Status: GOOD (  17.64  )
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

On Fri, May 09, 2025 at 06:19:49AM +0200, Christoph Hellwig wrote:
> On Thu, May 08, 2025 at 10:58:14AM -0700, Keith Busch wrote:
> > Add a new blk_integrity flag to indicate if the disk format requires an
> > integrity buffer. When this flag is set, provide an unchecked buffer if
> > the sysfs attributes disabled verify or generation. This fixes the
> > following nvme warning:
> 
> Do we even need the flag?  I think we could just deduce it from
> tag_size < tuple_size, which feels more robust.

It looks like tag_size just refers to the space for the "application
tag", which can vary depending on if ref_tag is used or not. But it's
always going to be smaller than the tuple size.

I think you mean 'if tuple_size == sizeof(struct {t10|crc64}_pi_tuple)',
depending on which csum type is used. I introduced a new flag because I
thought that gen/strip property was just an arbitrary decision that NVMe
made for PRACT, but if it's a universal thing, then we can totally use
that. 

