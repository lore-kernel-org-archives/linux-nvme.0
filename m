Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E1CC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zD1HJD0JoGWbyosZQIr35m65Kn8/D/PlKTdwb+SHqU=; b=a6duipm75Pmyw1QB4Nw7P08k3z
	j6fUikdQmRVjyc47EwNdJXSQvHDI2iJerVu+VCxeiba2sac8kBVmbu1PJvff89mHsIBziESQ2vbIo
	8feS16Lu4tGjsrpyhtTVTLkPXFgDph6NylRW1YA2sSiD5ve02ZdzleoW8/rNUSHuLhA8NOuskMudj
	74TSj2Q+A4nQWEqi3w1/TFzs8+xQY8HC9LpwiXqfLUFH34b5A5lY7fSISELNUVyBnVjSUjr7rqM8j
	KLulT+0FQUZNJpyRqVjpDG5yvOP7Nz9toh9t/orOAvHr7h5/mNV9XoHQL2DzYvUJVjIWZNlX9WD2K
	/By+uQKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppWIS-008Q1z-36;
	Thu, 20 Apr 2023 15:34:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppWIQ-008Q1M-2l
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 15:34:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 38D8961241;
	Thu, 20 Apr 2023 15:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B1C433EF;
	Thu, 20 Apr 2023 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682004845;
	bh=0y0Ubgtd9eSBFBi02w7YnupFRElY3P46GHl24SGnCSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HORgfkbdYTrc35iWTzz7bH0VNyce/zGNZFbZu0SMqL/wgPhM2UgZ+/CHJOtjFHkwf
	 9pMPViUiR3i1UDEi7qiYFDMTErPvPjtbcc8bERptlRslOmhA3n1yMeTk8u5SBPHQyd
	 93SXTqCC/WTwkO5IR2n9Yt7UuPr8eODvHB9CGL6BZ4FymZhZt0HuDFaAMzn2wfALEY
	 vXs8F39gNfTHnI5ZWodfD056DFuxeECB0XB7KoAE1CKtnJ1Hx7b9i+0M9GS+oCWksj
	 wLO4kq6XL618O192Zt/kI0/54sA7RhCWiAsYhKjCDw5LkvlSxGR4sTSvB2YQOE4d5G
	 TTP7IYvYx4CUA==
Date: Thu, 20 Apr 2023 09:34:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH] nvme: clamp max_hw_sectors based on DMA optimized
 limitation
Message-ID: <ZEFba1hoBM5U+VU3@kbusch-mbp.dhcp.thefacebook.com>
References: <20230420130155.19281-1-adrianhuang0701@gmail.com>
 <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_083406_932531_B670158E 
X-CRM114-Status: GOOD (  10.76  )
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

On Thu, Apr 20, 2023 at 09:29:30AM -0600, Keith Busch wrote:
>  	struct nvme_dev *dev;
>  	int ret = -ENOMEM;
>  
> +	/*
> +	 * Limit the max command size to prevent iod->sg allocations going
> +	 * over a single page.
> +	 */
> +	size_t max_bytes = NVME_MAX_KB_SZ;

Oops, the above should say 'NVME_MAX_KB_SZ * 1024;'.

