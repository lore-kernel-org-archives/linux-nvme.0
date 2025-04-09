Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD214C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04OZfSsIL92ZDZPq+HlsneOzS9zU15qOIS0WRLklQPY=; b=w1Vhka1DxK+lNoResShuIenpt0
	2bXBzLlz3VfkXBRlEqrAsE3L9aF4GrcE+04/FMAivFUQocFoN7JgGJ007rywiAYuI/KCou9wbreEB
	AWLozqEN9G9vEiLmWg3OtwEUT9/LnLFlgReuvTJT9umBFCNtZvlNreD/CtmUh/NOO0ymOvTg2TioZ
	rONGAbpQJOCnNb9qs/iOxe87KSGU1GzWV+1mUb2FJ3uW+8mVYA9yrYnPllGscj9XVPjxV5JQXz97k
	MqeeDfn0QmhkIH591WSuBVCEXgv6gNcoMpZBry+RWlrU+aBGmyyP1EBa5nWXMP1SQ8eFyUHBj/F42
	0ae1lYHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Slq-00000006qoh-1Knf;
	Wed, 09 Apr 2025 10:35:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Skz-00000006qdB-2NOV
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:34:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42E1368AA6; Wed,  9 Apr 2025 12:34:05 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:34:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 04/10] nvmet: set WZDS and DRB if device
 supports BLK_FEAT_WRITE_ZEROES_UNMAP
Message-ID: <20250409103405.GB4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-5-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-5-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_033409_745935_D084BBD1 
X-CRM114-Status: GOOD (  13.68  )
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

On Tue, Mar 18, 2025 at 03:35:39PM +0800, Zhang Yi wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5d280c7fba65..836738ab1fa6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1344,6 +1344,11 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>  	return bdev_limits(bdev)->max_write_zeroes_sectors;
>  }
>  
> +static inline bool bdev_unmap_write_zeroes(struct block_device *bdev)
> +{
> +	return bdev_limits(bdev)->features & BLK_FEAT_WRITE_ZEROES_UNMAP;

This helper has an odd name. In doubt stick to the name of the flag
instead of reordering the words.

Also no core block code should be added in an nvmet patch, this needs
to go into the first patch.

