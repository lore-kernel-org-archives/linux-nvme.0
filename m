Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF273C61CE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 06:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=988lvgIINIpiffqIeswJR4F3bfHJ8gH2wvbFoj3PcYs=; b=HiJt/fXEXSbL2JtXd91ykOK9rU
	R6x59rnAlhYiLY/sztyKSudSgG4ClsLRYyHdM2t6R8YIdYjgBXkMLNCpKH8zmPvMrkx2mih5UNMpI
	iR72hcLLb/FbqV+/JEoK8b1Q20G6ufocKaJZDwDigxOKmx9SU3SklGVdzrA8UN4lbE0o/2AcdltXs
	KWrhCAHfmiZ1jKz+kIMagMmDXKQLKuugP/F+XwyqYEl/4HK5xJJ6WK/pCj9YjKwRBJKS1F6tWIKbm
	5a+Y1sIf4S0K+X2pCI9qjzxgGek9mYhnQWEFjLbVzRptDpaDzPUQCa9VNeYCUes4EZ/DL2JUy56yl
	AsiZpYLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEhJ-00000008w56-1m7j;
	Wed, 11 Jun 2025 06:12:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEfz-00000008vns-1YGs
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 06:11:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3722468AA6; Wed, 11 Jun 2025 08:10:59 +0200 (CEST)
Date: Wed, 11 Jun 2025 08:10:58 +0200
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
Subject: Re: [PATCH 09/10] block: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <20250611061058.GB4613@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-10-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-10-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_231107_553311_31043BD7 
X-CRM114-Status: GOOD (  14.16  )
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

On Wed, Jun 04, 2025 at 10:08:49AM +0800, Zhang Yi wrote:
> @@ -856,6 +856,13 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	/* Fail if we don't recognize the flags. */
>  	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
>  		return -EOPNOTSUPP;
> +	/*
> +	 * Don't allow writing zeroes if the device does not enable the
> +	 * unmap write zeroes operation.
> +	 */
> +	if (!bdev_write_zeroes_unmap(bdev) &&
> +	    (mode & FALLOC_FL_WRITE_ZEROES))

Cosmetic nitpick, but I'd turn the check around to check the mode first
as that's easier to read.  The whole check also fits onto a single line:

	if ((mode & FALLOC_FL_WRITE_ZEROES) && !bdev_write_zeroes_unmap(bdev))

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

