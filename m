Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E499CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPq01JLA6dLoXnFchjjFxJhIcKHBhEdkrZLnR4TbLUY=; b=lsjoeGfuW8XFYcnhT4BUm4Anjt
	D6hswWOGqHt7WSt9Hf+7Ms2Y7mWWtMn3xVhtDKMqUMV3az0/Ep4ca5qlknnY4WepWACarevdC5XdG
	gF4TRpSIrrj0Zvfa0PjUyK57U+YjEnVBkPzC9ymbHaXrffyzFrrjrNoadT8B2f98gnrPfH5l1+1q7
	pso/DTAGF28i2AMi0arUwb3YFNt/3+VjTBnHVKuSURVIL3wDXwKteCJMn7oBGuEnyTX5qtjH4ApwR
	W2h7di00ZardYJ/4ASLNsHFKjARN17sW3B+MVvBjODXzxTtjqq8KRCD5J1PnrvjlAqeQV+YhJuDfL
	CUmZt9qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUZJ-00Cu3L-SL; Thu, 07 Apr 2022 16:01:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncU5m-00ChxK-AT; Thu, 07 Apr 2022 15:30:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E56341F85A;
 Thu,  7 Apr 2022 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649345436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPq01JLA6dLoXnFchjjFxJhIcKHBhEdkrZLnR4TbLUY=;
 b=arXCGHubFNDMJivA50IVAh5E18SENgaJ+8psB29O+dYSp9GznJDHN9eBNpNqVEEypC+xPt
 YsOhdRjVTg1mFsMpWqZ4oNaVAGZnjLyClojrRdjsUuitokjLJy7oqe8RxGnlNpP0HUVyi6
 8uSBZYdSoqUowgEJK8P6YGm7aUVWSbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649345436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPq01JLA6dLoXnFchjjFxJhIcKHBhEdkrZLnR4TbLUY=;
 b=+RoHDuxhi8eXdx1m79jW3LC9fhbmevwd72sFBk44Osas+gmEsPN5qSbgbwIpqCBgrNluyA
 EXeawVVGeX85rgBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id AE7A3A3B94;
 Thu,  7 Apr 2022 15:30:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 5C928DA80E; Thu,  7 Apr 2022 17:26:34 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:26:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH 24/27] block: add a bdev_discard_granularity helper
Message-ID: <20220407152634.GL15609@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406060516.409838-25-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_083038_598990_6DF9A4D5 
X-CRM114-Status: UNSURE (   9.50  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 06, 2022 at 08:05:13AM +0200, Christoph Hellwig wrote:
> Abstract away implementation details from file systems by providing a
> block_device based helper to retreive the discard granularity.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-lib.c                     |  5 ++---
>  drivers/block/drbd/drbd_nl.c        |  9 +++++----
>  drivers/block/drbd/drbd_receiver.c  |  3 +--
>  drivers/block/loop.c                |  2 +-
>  drivers/target/target_core_device.c |  3 +--

For

>  fs/btrfs/ioctl.c                    | 12 ++++--------

Acked-by: David Sterba <dsterba@suse.com>

