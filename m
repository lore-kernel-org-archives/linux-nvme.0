Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD26EED601
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLhbreW2WGeudkXguScvE3xnYb4beGW6XuUKwwu2mCU=; b=gfyyt59SwegeAal/lbMSH3tDhe
	3httbAHB9e/nniYlNpQwfe4fjs2MllbKxZHAf0FhstXl9h9FCVjjys7hQtR/rmNydwEF/Itljeq1g
	plbe/54Se2DYcKUbHcUIvZf0LwgLSeuNLjBPV3+2xy5VzLyF9ocB61XSIE8Hw+SIUoEIqL8mSjfA+
	iwU6JaQgPe0Fpz6VJB4RXQkd1MNtt1fwgr42teI9S/RRQM1vNUv+Z14NVsoHjk2MoSAt+vtroD1+A
	J3Y8yGqW70jGYdNehMnY9cH/qoidaK1fWhNVTpIDKdGbiyDKGUSMME3ceKXevu7zZPs+ZEBiAHaaJ
	S32+/SiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojgG-0000000DAPW-2ajx;
	Thu, 12 Sep 2024 13:16:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojgD-0000000DAOS-0fHa
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:16:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A264D227AAF; Thu, 12 Sep 2024 15:16:10 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:16:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] block: Add BLK_FEAT_ATOMIC_WRITES flag
Message-ID: <20240912131610.GB29641@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903150748.2179966-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_061613_357742_8607A81C 
X-CRM114-Status: GOOD (  10.64  )
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

> @@ -176,7 +176,7 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
>  {
>  	unsigned int boundary_sectors;
>  
> -	if (!lim->atomic_write_hw_max)
> +	if (!(lim->features & BLK_FEAT_ATOMIC_WRITES) || !lim->atomic_write_hw_max)

Overly long line here.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

