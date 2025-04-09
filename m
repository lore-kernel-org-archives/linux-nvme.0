Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7BFC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bENfYcXcHcBvLCHB48nJBQSTU0nEW7ET7VMwx1tZqJY=; b=HT9oOAGh1BbKOkrYovw2jZIVSs
	UJlhDYyJNn4l7QndIefbkF5f98y9OhUOnKi7Q/h2o2z0IFU3ALa2GV+ZocW4StF+dhPrOB10GTwmn
	HWd6UANrJDo+qKng180QJ311+gqwS6eutrv4vQ/JG6pUMsmWFqqSlBPU8a+RkZ3pldsRY2Vr0ngRb
	zQgphq8hu51pZ3oOU4YY9ZuvY06W6ilbRFb7pkw8S6T4m9Tn3yMz7FTd+uJKUIDAuNCZz/imFdZHY
	YhZmmhd7/Yuvaaym1s53xTCCdw0gfHL0K/qtE0U5ivVH1h2gLa20UOjQSPOyeFu1gxI+zdp8Ottsf
	8Xm5B6LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Smg-00000006r2J-3PJE;
	Wed, 09 Apr 2025 10:35:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Smd-00000006r0v-48dq
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:35:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D9EE68AA6; Wed,  9 Apr 2025 12:35:48 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:35:48 +0200
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
Subject: Re: [RFC PATCH -next v3 07/10] fs: introduce
 FALLOC_FL_WRITE_ZEROES to fallocate
Message-ID: <20250409103548.GC4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_033552_163909_89F7BEFE 
X-CRM114-Status: GOOD (  13.69  )
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

On Tue, Mar 18, 2025 at 03:35:42PM +0800, Zhang Yi wrote:
> Users can check the disk support of unmap write zeroes command by
> querying:
> 
>     /sys/block/<disk>/queue/write_zeroes_unmap

No, that is not in any way a good user interface.  Users need to be
able to query this on a per-file basis.

> Finally, this flag should not be specified in conjunction with the
> FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
> not permitted, and filesystems that always require out-of-place writes
> should not support this flag since they still need to allocated new
> blocks during subsequent overwrites.

Should not or can't?  You're returning an error if this happens, so it
doesn't look like should is the right word here.


