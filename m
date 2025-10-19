Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FDECCD184
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Oct 2025 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLrwQxT3I5HtFScbgNVtxFBjDR1cXw2gB+AAsL3xcKI=; b=pDEmJaSDbtgCfUHl3n7p0qIpVp
	WPdfugmo3joVwDl9/JLI9cEjG/Ml5QuwGztobUmgM+rLpeik539RupqJYUOUbFdT7BF79f4UXHn2l
	g7jxFrBVaTJpWk7a+N4I0v9CvJZ99p7UKKtslGOJ0zd4QlKT7meve7RmOUeF9BzggJN4tUBCGNEsM
	jteKsDKvt4Bq2O0Wamh5Oh6ryxfzkYMozmUCOvAGVAkyTrcGTe737GaYBkNRgVk8BZld/+fy4uEeC
	oa9n0wJPw5AMm+QtWeHKm0STVoNH9e68VhSHX9CkrJH/LLvSaMnrgGTaLA15o4Kc9TebEGeWgG7T+
	Zpo0detg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAUad-0000000B6FX-2kog;
	Sun, 19 Oct 2025 14:40:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAUaY-0000000B6E6-0lON
	for linux-nvme@lists.infradead.org;
	Sun, 19 Oct 2025 14:40:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EDBF44A63;
	Sun, 19 Oct 2025 14:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE6C4CEE7;
	Sun, 19 Oct 2025 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760884837;
	bh=OToiYPWcf9HfMtkOEssugJbZhagD9pCuP/win/Rr5Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3q9VIdgXIXmsW1jqkUgZJGBaD2eCGSMV5zSXpMzk1830RVIvkHj16oYU3jUI4pkP
	 O+0GmVrAxb6HjjZDbP8hIGx36Lpxrw+jLFT2StHxyhqCwIEJz+FaHiHmmO7nJPbxv6
	 EQ0qYPwoFOvm9pYgConDUrkycf0oEHWpFaC0eFtNT/Eruh8na4Bn53kChCDrw+LQZg
	 9XW7bMejJfI/q4HtN+m4GshwVlix3GmzQ6OTOdf7K5iOPpWXuwfmbsI8o5kP3LXfQi
	 vdOePQNfA8xbCKhaJT1btsY2P69RbQ2xYxLHphB+KS211UEpx2Lf+0m7YsiHBH4VKf
	 hgvGXJnHRj5/g==
Date: Sun, 19 Oct 2025 17:40:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251019144031.GK6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
 <20251017061848.GA402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017061848.GA402@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251019_074050_236121_577776DE 
X-CRM114-Status: GOOD (  12.99  )
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

On Fri, Oct 17, 2025 at 08:18:48AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:31:58AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > After introduction of dma_map_phys(), there is no need to convert
> > from physical address to struct page in order to map page. So let's
> > use it directly.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> You forgot to pick up my review from last round.

I'm sorry that I missed your Reviewed-by tag.

Thanks

