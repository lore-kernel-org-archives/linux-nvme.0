Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B3C6FA83
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sifwQyqnhpHngKxzCHkDyc0Tyn50ZsV3oCXOspJ4q8=; b=FFDAW1+qI14qssjVR4wRlvQr8i
	rK8bl5yLmA1hS6sdigwtiTUKGH+0bRDFmD8qsCqLxE/I5hBhVCn9wVGAiIsdpqImZZzfeZYSlzAXU
	M7MwtDLRHa2U1vzB6CAaOh8outYHjbfl323CcF8MJm9Sh/bk3RaagC+4HG6BAQevhRszPUsD8MZM3
	iUm9EwzKcQ6RS3bbyWMTqPaLcyXkDB0gDexDGgVxJt/eyDyb2rL9PaQn8UOQUBtLAoL7UWf4l2frw
	aOy0yS9TsGeFcYJLuUfzdH+nMSifAHGIlecGqU0ymrinRH0zmlCgxOW67/77rVhSI9t5CHd0cYROe
	AybYLdoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5MF-008sTy-FU; Tue, 27 Sep 2022 07:50:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5ME-008sTT-6b; Tue, 27 Sep 2022 07:50:22 +0000
Date: Tue, 27 Sep 2022 00:50:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <YzKrPrUvr3wJWCCd@infradead.org>
References: <20220927014420.71141-1-axboe@kernel.dk>
 <20220927014420.71141-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927014420.71141-5-axboe@kernel.dk>
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

On Mon, Sep 26, 2022 at 07:44:19PM -0600, Jens Axboe wrote:
> By splitting up the metadata and non-metadata end_io handling, we can
> remove any request dependencies on the normal non-metadata IO path. This
> is in preparation for enabling the normal IO passthrough path to pass
> the ownership of the request back to the block layer.
> 
> Co-developed-by: Stefan Roesch <shr@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

