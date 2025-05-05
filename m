Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F87C3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MO4B+wq+xSOY4yem/oA79I7d4hMtg0+mUo8Vu+BLMKg=; b=J78GCUQyzaevtJ9Zqn9ofWYfyz
	PEUH8Dex81dyWuhyYTUnMwjV37fdXbBmw+U5LTG+pSh6ME4a8bF2zEycl0AnNFhWrh/H+tC8bkA/Z
	S7d8owcu9Rf/zxi6G9kbT/x934tjUpo7vI8xAzo4eZA7zSYiqSP3pJSHXu3DLRArwDtVS+tyy77V6
	Uk+K+/HRInOJ26z13yPrHB8L3meRuZ7jZdybEnCAdBTMAscQVyXHE+mxEd12vDCbcRdzQzbhGioe1
	Pc1g0SjIde+BszO9Ae+QQhsUvA9ivr9ct3BoIPqK6SsTls9F/ujbudOYkISV4FSE2NPKF4IbLtrcO
	gWHhEq3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvm0-00000007TPa-0DcD;
	Mon, 05 May 2025 13:22:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvlx-00000007TNR-03sw
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 13:22:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7E7D68BFE; Mon,  5 May 2025 15:22:08 +0200 (CEST)
Date: Mon, 5 May 2025 15:22:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250505132208.GA22182@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_062217_194276_CF6215C7 
X-CRM114-Status: GOOD (  20.32  )
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

On Mon, Apr 21, 2025 at 10:15:05AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new attribute flag to statx to determine whether a bdev or a file
> supports the unmap write zeroes command.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  block/bdev.c              | 4 ++++
>  fs/ext4/inode.c           | 9 ++++++---
>  include/uapi/linux/stat.h | 1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4844d1e27b6f..29b0e5feb138 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
>  			queue_atomic_write_unit_max_bytes(bd_queue));
>  	}
>  
> +	if (bdev_write_zeroes_unmap(bdev))
> +		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;

Hmm, shouldn't this always be set by stat?  But I might just be
really confused what attributes_mask is, and might in fact have
misapplied it in past patches of my own..

Also shouldn't the patches to report the flag go into the bdev/ext4
patches that actually implement the feature for the respective files
to keep bisectability?


