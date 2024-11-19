Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89929D4922B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nL007/IQ+rtxs9E8Z9tnfGY1ws3tqUP4fRBU1pge834=; b=PHzUxS1z9IzaT0aF0u/72u8inu
	lNoCNK8PKRZzEVNGLJAgK8o6RWQ/4YK5r1LROppCT2vP3sryTqawfau/lEdD5CjF3ONGOq8BTnjUp
	YR0pHa6Aa+Fh6LfWlSJwynv8WK4ItxNEEJQZZ/ozsCzVZeCiGhj15MqFSUgVLvP6CZZnafajQpDVx
	qfpNdNc0Rt0OGAtdbWqQ24SUuy00cKXNMv7tJd8+PYcUSYLpEJgataqyo3RPqc8ByWmLOSPsQ3gA4
	sJ8ls03NzyWybxEZjWYkFp8MbUfDMc8jxMm7M6VRQT4yU8wNcoPj7gkfYq+8u5C251dsJ2GC9wBQy
	YDPIwFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQyg-0000000D08W-2ClI;
	Tue, 19 Nov 2024 16:21:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQyd-0000000D07A-32pO
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 16:21:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 871D568D93; Tue, 19 Nov 2024 17:21:13 +0100 (CET)
Date: Tue, 19 Nov 2024 17:21:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: tuning pr code by using defined structs and
 macros
Message-ID: <20241119162112.GB14774@lst.de>
References: <20241119102925.128435-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119102925.128435-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_082119_904574_646EFC76 
X-CRM114-Status: GOOD (  18.52  )
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

On Tue, Nov 19, 2024 at 06:29:25PM +0800, Guixin Liu wrote:
> All the modifications are simply to make the code more readable,
> and this patch does not include any functional changes.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/host/pr.c | 125 +++++++++++++++++++++++++----------------
>  1 file changed, 78 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index dc7922f22600..3fd292badd42 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -9,6 +9,9 @@
>  
>  #include "nvme.h"
>  
> +#define NVME_PR_SET_PTPL_TO_PERSIST ((1 << 30) | (1 << 31))
> +#define NVME_PR_IGNORE_KEY (1 << 3)

Normally definitions should go into linux/nvme.h.  I'd also
normally expect the different CPTPL bits to be defined separately.


