Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1DFC61CE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 06:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIq+U2Tg76ugsBw34RLHMhF/KnxSc9+llrlmyNpysik=; b=nBJDlJLH+4D/MngvYylQ+wshMs
	n64d6cGu0tSnDUrEsl27j7D3NlFGrfStz2M67Gpmc3Re1/vd+IxAkYtgGpW7O+KepYcn3kJNFIvdE
	21ZP/vUQwDSBVGRmmezIfOngEJcJQZsS9in5RMgnbY3RczIoD226CW6KOApZDGFziMMPSIyYoTZrW
	7lZmldHRFbPiKZCSRFttEMA7zFHiDRenKWCQEf02auq5fO67vZ3IsBSycHzkNWxSl6aZGGSkw55gL
	0bMr+7AzhgUbjbXGaYq53kJ7h91ZSVu5hRpZFJVj2m0KRTKMyil6vZTH2Uo0/ce3hYxkO0lVwdMDW
	6r8vLnYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEf2-00000008vZk-0xBM;
	Wed, 11 Jun 2025 06:10:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEe3-00000008vQO-3Hp2
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 06:09:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CE2368AA6; Wed, 11 Jun 2025 08:09:00 +0200 (CEST)
Date: Wed, 11 Jun 2025 08:09:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250611060900.GA4613@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_230907_963478_4DBFECC0 
X-CRM114-Status: GOOD (  10.15  )
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

On Wed, Jun 04, 2025 at 10:08:41AM +0800, Zhang Yi wrote:
> +static ssize_t queue_write_zeroes_unmap_show(struct gendisk *disk, char *page)

..

> +static int queue_write_zeroes_unmap_store(struct gendisk *disk,
> +		const char *page, size_t count, struct queue_limits *lim)

We're probably getting close to wanting macros for the sysfs
flags, similar to the one for the features (QUEUE_SYSFS_FEATURE).

No need to do this now, just thinking along.

> +/* supports unmap write zeroes command */
> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))


Should this be exposed through sysfs as a read-only value?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

