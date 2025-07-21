Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E1C87FC8
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQFPEu7QL/hRM4qWDX1pD1Iyv7LTQExRbjdgFg3u6j4=; b=IGEjDdM+V53imtFQyXOpLNCtSY
	sA8i+/3DBOiZzlWZdk6iwGJZKIHYnA+UKOsTzuq/6E0NOujgW+MhoVzt5XXFasGLrGleqlss1psIH
	I7IGIJ9zt1L2eVH7VMeyDGRRIZ7QnISZB+Iww//Rl4w/MB7zYml8BZ+V6E/rytGxV+elJJ8ml9mrs
	nv57bDckjk1FmncAtHKuzyvPbBXZlOb7ffcPBZEo/OpbRU4vwXUG2Ff2N/6ca8EwiYSGoiB+Ug7Hn
	jz3h7pWto5NrjuxtKHaF8Ok2RpK6Av02lr7miThzSxz09TfHa759QaXucuXp/IQSkHj3/VtO5DrO3
	iXhOYl3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl9V-0000000GWGQ-0i1T;
	Mon, 21 Jul 2025 07:41:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl7T-0000000GW0G-2oZp
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:39:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 594E568BFE; Mon, 21 Jul 2025 09:39:28 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:39:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/7] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250721073927.GC32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_003931_854051_0B17ACE3 
X-CRM114-Status: UNSURE (   9.56  )
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

On Sun, Jul 20, 2025 at 11:40:36AM -0700, Keith Busch wrote:
>  static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> -		struct dma_iova_state *state, size_t mapped_len)
> +		struct dma_iova_state *state, size_t mapped_len, bool p2p)

Nit: can we names this is_p2p as that makes reading these boolean flags
a bit easier?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


