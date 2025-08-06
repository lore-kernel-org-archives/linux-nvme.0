Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34393C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8IDmn9L4r/RApRqjux5LG8hlxWPWv0Skdsch+ZPRKI=; b=k3TkjTivFhE6Ya+eXoh+KsIKUm
	KA50yYbPeHakJR893jWsj4nWhxSi+3lF2dz6se8yaaoI9FkfBzR83onBh7nYRlp4HLsnfeCs4EpDa
	ugSMI8P+V84JAliP7PDWTYFvA9mcFXd76DheqyQZrX0km80efHJv52kqySrBxQjeGKzV5ds6LFjow
	Y9erq3LrdjglNYwa1+U6Kv70Bt2EuDyVSpw8qUjJo4U9OVoNlql0EwAPuVyLbxHef2Zj2GbLBiGCY
	JWTcbebyHjmmi7eWVhxS3b1VcpDv3zptU/JnBTjjZE6dd4LILo066bY5CrCfta8wgbiKZgEr/j3mE
	C4KI3/oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfZ5-0000000FVJf-2aFI;
	Wed, 06 Aug 2025 14:56:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfZ3-0000000FVIX-1g0g
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 14:56:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F14C8227A8E; Wed,  6 Aug 2025 16:56:21 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:56:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250806145621.GC20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_075625_577155_AD0A9BC4 
X-CRM114-Status: GOOD (  12.10  )
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

> index 0a29b20939d17..d0ed28d40fe02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -264,6 +264,8 @@ struct bio {
>  
>  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
>  
> +	unsigned int		page_gaps;	/* a mask of all the vector gaps */

Bloating the bio for the gaps, especially as the bio is otherwise not
built to hardware limits at all seems like an odd tradeoff.


