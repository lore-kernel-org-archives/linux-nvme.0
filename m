Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D158C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPQZ4r6Auboj66ItUyWSqZRKn9DWlJkEV8HrVB1ZO10=; b=c+HHYxq1a2/ZCNV5rIdzCIh6IH
	KgAkHrk52Ijv6siFsNP+yuNCDJgG610Hn6xugR0juA549xv8AP95s2G4b8wpJx51otT+Ghj74u9xI
	J3qNK1JB27h//79mTcO5Sl3x5bn3Ls9j0kUTk6RmnwFkcozDFw6A/10wozPgziUhiPs7MaWcgEnjQ
	oSglgWmX3TgWRX5+D5zW64RLlx5WRJOpLEigR1eNQ5eG1UelpEzEYdEkBsRuuo3ag7yGIbu15mjLu
	f3HkPHR1jr+Shf/XIixIeS81Mp8+zWMYTmHhgL8m5CzOvGzopChw60i7q7HNOAsw8bS92PjMQ0ial
	CsXS0yWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmy1D-00000000LrE-3uIm;
	Tue, 25 Feb 2025 16:42:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmwXO-000000001Th-2W6R
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 15:07:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5899C68D05; Tue, 25 Feb 2025 16:07:54 +0100 (CET)
Date: Tue, 25 Feb 2025 16:07:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, anuj1072538@gmail.com,
	nikh1092@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCH v1 2/3] nvme: Fix incorrect block integrity sysfs
 values for non-PI namespaces
Message-ID: <20250225150753.GB6099@lst.de>
References: <20250225044653.6867-1-anuj20.g@samsung.com> <CGME20250225045516epcas5p3fa5712152300bf976d1bc0ab26211633@epcas5p3.samsung.com> <20250225044653.6867-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225044653.6867-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_070758_779556_66C70197 
X-CRM114-Status: GOOD (  14.29  )
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

On Tue, Feb 25, 2025 at 10:16:52AM +0530, Anuj Gupta wrote:
>  	memset(bi, 0, sizeof(*bi));
>  
> +	bi->flags = BLK_INTEGRITY_NOGENERATE | BLK_INTEGRITY_NOVERIFY;
>  	if (!head->ms)
>  		return true;
>  
> @@ -1850,6 +1851,9 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
>  		break;
>  	}
>  
> +	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
> +		bi->flags &= ~(BLK_INTEGRITY_NOGENERATE |
> +			       BLK_INTEGRITY_NOVERIFY);

I don't think the driver is the proper place to do this, this should
be done in blk_validate_integrity_limits.  That should also take care
or the stacked devices and remove the need for the last hunk in the
previous patch.


