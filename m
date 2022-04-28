Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA8BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eUzrHAktaPV2vPiCroaieaJhKRqBxokvqSNbQGHpag=; b=w3ckwfPOyXjJFj8fPQ35Y1bBNJ
	GS+s4jerm5q7hKuK8o9GCiaHzOIttwecTL5QDHFqVWtaZbcJMx/ve0ZlxvHnZxJTTTUGhixbnBCVG
	bZ/JEZvftby2eo/Qf6w2hzx/KbMWGVIKF1010CL9ySjjQHCR6aHKWbX//5dmN5tPvg+sXLoG+RDo6
	+6ARQ1UOmW5ToxXATPJzjqRuIwEC4SUm8vV71mBr7yYWfnYj/iF1Yg9wdxzKuG9vshSXxQFJqjPjF
	576EqgzIFNxAiV+YpXfADhgsfLGeE1WQnGwEuE1pHkQpEfTHVVe7YCLRv451rJChkCS/n4PxPZD4U
	yJkGZpOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5Fd-007VnJ-Qu; Thu, 28 Apr 2022 14:36:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk5Fa-007Vln-Nq
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 14:36:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E289B68AFE; Thu, 28 Apr 2022 16:36:03 +0200 (CEST)
Date: Thu, 28 Apr 2022 16:36:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220428143603.GA20460@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428101922.14216-1-linux@weissschuh.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_073610_962983_1210E70F 
X-CRM114-Status: GOOD (  20.52  )
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

On Thu, Apr 28, 2022 at 12:19:22PM +0200, Thomas Weiﬂschuh wrote:
> We want to allocate the smallest possible amount of buffers with the
> largest possible size (1 buffer of size "hmpre").
> 
> Previously we were allocating as many buffers as possible of the smallest
> possible size.
> This also lead to "hmpre" to not be satisifed as not enough buffer slots
> where available.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> 
> Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/
> 
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aacf1c0d5a5..0546523cc20b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
>  
>  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>  {
> -	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> +	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);

preferred is based on the HMPRE field in the spec, which documents the
preffered size.  So the max here would not make ny sense at all.


