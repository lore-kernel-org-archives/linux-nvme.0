Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48E4CCFA00
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rMKoWPuuruae8Y7iMPJ0sqOjzs+j59KwxZ8w/XLydo=; b=mP049XMSuEb9p6VHgYmSjUrdns
	fSGpAQYVtIAWxL34GQ6dYudbT/lp945dzsUKpYefAHJMyaVvyH9hY3RA0DrXJsP72Of44v+FLmKYS
	6SFj++DNOOjCbSvNlIrTNAjUlS8LUKntJxUZZPXqn1zcHOBkcWzl2tYNpjbtlxcUqGaXJ3pYY7pvd
	gJ5WNkqFvlpHspNpF06aYaJlejEgvngGOtUwtdfIKo/GJtAwy675Kgwa2wZuRLODFCV5T75+CdN1y
	NoyRB72ewFCXEvwhzUrJKMgORDzdM1Z+17dzlYgFrconrE9W47SoO624U5ocAOcH1lRubDWDrOoz2
	wFz0z5ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkrR-00000005hMk-2yxe;
	Fri, 31 Oct 2025 08:51:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkrH-00000005hLm-3k8o
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 08:51:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F502227A88; Fri, 31 Oct 2025 09:51:39 +0100 (CET)
Date: Fri, 31 Oct 2025 09:51:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 07/13] block: track zone conditions
Message-ID: <20251031085139.GG8798@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-8-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-8-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_015144_157318_D3D782D8 
X-CRM114-Status: GOOD (  16.03  )
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

On Fri, Oct 31, 2025 at 03:13:01PM +0900, Damien Le Moal wrote:
> The function blk_revalidate_zone_cond() already cache the condition of

s/cache/caches/ ?


> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index f85743ef6e7d..dab5d9700898 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -61,6 +61,10 @@ enum blk_zone_type {
>   *
>   * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
>   * be considered invalid.
> + *
> + * The condition BLK_ZONE_COND_ACTIVE is used to represent any of the
> + * BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN and BLK_ZONE_COND_CLOSED
> + * conditions.

Maybe explain a bit more that this is only seen for cached reports, and
in that case the two open states and closed won't ever be seen, i.e.
that they are mutually exclusive?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

