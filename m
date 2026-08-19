Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36760C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kcYjm6eQgZTedz1uRmT75+ISEDWUVM7JZxXjIb9VF0=; b=zhFrgddhA9FLJo9m4jVE45CYJE
	NowSfBy7o9OI8b55PmoCPlPlPanooJGVTOAZbOdg5ui/OzWkjc9wVmmtAAe2Rbo2GneJbPIILnyza
	c3N02WuyTFyphHmdk9afn+5dYEEYgaZX08uRbvxVlPC4MlL8yGRa0eXc8hQw28MllUpDg/h9pdWGK
	V5gqD6YAil+Mcb/88TC47HoRnJVnDboPz/1Czxk53xHpBiKAONy49LAVKnLuGyyfhWFHNdgA1oxmf
	W3GcdmqHY6NjVgmzEtg1/r+yPPIkGUuMtznhBQ8TREU6MB/cb9B2LMiJDQmR2sIB4wnY8uYZYgDF1
	Rc+BVhuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYyc-0000000923N-1cZO;
	Wed, 19 Aug 2026 05:36:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYyZ-0000000922l-46Kk
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:36:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD3E968C7B; Wed, 19 Aug 2026 07:36:32 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:36:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v2 1/2] nvme: set ns->head in nvme_alloc_ns_head
Message-ID: <20260819053632.GA32567@lst.de>
References: <20260818060253.4104-1-joshi.k@samsung.com> <CGME20260818060331epcas5p4bc873288ed9b92b5e2c4546e5ceaa053@epcas5p4.samsung.com> <20260818060253.4104-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818060253.4104-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_223636_166640_5F4F0BCA 
X-CRM114-Status: GOOD (  11.60  )
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

On Tue, Aug 18, 2026 at 11:32:52AM +0530, Kanchan Joshi wrote:
> so that it becomes possible to submit non-admin commands.
> This is a prep patch with no functional changes.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


