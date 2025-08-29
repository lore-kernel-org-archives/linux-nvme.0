Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDB2CA0FF0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suWPHsegb+3DCCjwBeB90rE8W/c9g9CvvRbBvEvyKrI=; b=Ic8y2sD/XI5co7O9BX5rL73FGy
	0JNQ+wPJ3GpZ9TQqni/kX3+kcuqJJoeuo0t4EN3Se4wJGz9jhmkPVk7vAf7/K0QEYet8zTSQomOeI
	xIhHgIzemPVZab8LcJx7PPde4A9si0OVAo4vO2DFuKEhuMkw4H2BLq+XqEBJBgFERU4qhqHNSGzsj
	qFwRAVGE2uDpdSiJCuQldU8Fn5e54V5qpZRb3mfBW2RWpC11HsMOfU7JTYb7w/Ez3QzHO8rBFGvqb
	3BM2wkAiRRBVEhAWYUUYJHQjHFW1ygMNvVxCi9/kZLDeeBxCyzzGHomqifCzO6+vytN3pQHTUgwC1
	qYUQXTaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4BI-00000006gZ8-06Md;
	Fri, 29 Aug 2025 18:50:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us0pV-00000006ALA-0Nnt
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:15:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C66644025F;
	Fri, 29 Aug 2025 15:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A87DC4CEF5;
	Fri, 29 Aug 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480552;
	bh=FiZTvYPqfy/ZXNRGXoa0o6dikFbQzgwUvUBZHilwNMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md9cTswiy6PRypiND6T0l12sixzuUzFi0BG18QCP9JWx2nNv1ocjVcmh7rbMtrP2P
	 topm6lqplZxnY8HpwIJkyMTBsMuFD6vZQKNElXGsBUBR4Lybb6nHZ/Li4IWUDh+nLy
	 7pZ64X0kHpxU1CNTONkV1xVZB0FDaXV+3FTGOQVHgj8nV5wQAYxbdKfe1mDHm2/3uH
	 JDfo2p4d3yC0GLl9wjMEuJ6FLoXbAPZkwcgaWQkucHvSlEMbHsca318pyiDtkte0yL
	 1yQmgTXhjHx8kYzZdVK53BR8Xve1ApdBuDwbV9vehC0iCGS0GrhotXBN6So73ok54b
	 JyXlY7pSMm0eg==
Date: Fri, 29 Aug 2025 09:15:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <aLHEJnKgVGYdnb08@kbusch-mbp>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_081553_150270_521260D3 
X-CRM114-Status: UNSURE (   8.50  )
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

On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> @@ -252,7 +252,7 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
>  			bytes -= next;
>  		}
>  
> -		if (is_pci_p2pdma_page(page))
> +		if (is_pci_p2pdma_page(pages[i]))
>  			*is_p2p = true;

Oh no... >_<

This part should have been folded into patch 1.

