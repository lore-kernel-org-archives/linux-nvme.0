Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3115C2BA18
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 08:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B82206C3
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 08:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNJkuiJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B82206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IPGyYPZM2V3oFU1nDT/Poyv6QgvKRpEQpEZHJOetWiM=; b=BNJkuiJyEuKdos
	7wi4dH526tUXT3h6YB5z8nCAwBt9v7yUPl9btAz11QB7IueDfcFGVI8ZOQe+hZzJGaaD6mFFu6bSa
	Z8Jg39+9/jDJMOYXcY00PjzH4gzHuPsMFh3qGLw+nKI/NeL+fGMGkEEeO2sM8ZFBWMaIZqmG/dJ0w
	Wtyes4zKgB4AuFcyQBUDfFdD9tEoBL1GypPULNpb6/a/b7kt0EMzaeLzzspW7NNjFdnxM4ate0yMf
	Q+mq6aTdrSvlTwhcH16MG2HAZVDp3LdpWW+BRq03XxFFyDZUpQB/f516WR/zRSlXOaOWEt6kJz6yw
	cGVeB8Du8sqBVkrVfSXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLMj0-00047h-Fm; Mon, 06 Apr 2020 08:03:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLMix-000478-77
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 08:03:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 67FFCAE0A;
 Mon,  6 Apr 2020 08:03:10 +0000 (UTC)
Date: Mon, 6 Apr 2020 10:03:05 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Message-ID: <20200406080305.GA1329@technoir>
References: <20200402193052.19935-1-ailiop@suse.com>
 <20200403064331.GA23270@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403064331.GA23270@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_010315_401106_B10A9823 
X-CRM114-Status: GOOD (  18.77  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 03, 2020 at 08:43:31AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 02, 2020 at 09:30:52PM +0200, Anthony Iliopoulos wrote:
> > Add support for detecting capacity changes on nvmet blockdev and file
> > backed namespaces. This allows for emulating and testing online resizing
> > of nvme devices and filesystems on top.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> 
> I vaguely remember seeing a very similar patch before, is this a repost?

Not a repost, but you're right, apparently there was a similar patch
posted before: 20191008122904.20438-1-m.malygin@yadro.com, which instead
triggers revalidation via configfs.

> > +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> > +{
> > +	loff_t size;
> > +
> > +	size = i_size_read(ns->bdev->bd_inode);
> > +
> > +	if (ns->size != size)
> > +		ns->size = size;
> 
> This can be:
> 
> 	ns->size = i_size_read(ns->bdev->bd_inode);

Fixed.

> > +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> > +{
> > +	struct kstat stat;
> > +
> > +	if (!ns->file)
> > +		return;
> 
> Shouldn't this always be non-NULL?

Right, this would be unset only during nvmet_ns_disable, and by that
time the ns is off the list, so identify should never see this being
non-NULL. Removed.

> > +
> > +	if (vfs_getattr(&ns->file->f_path,
> > +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
> > +		return;
> 
> Use up the full line:
> 
> 	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
> 			AT_STATX_FORCE_SYNC))

Fixed.

> Also shouldn't there be error handling?  If we can't stat the file
> the namespace is toast.

Indeed, I think it makes sense to fail identify at that point with
NVME_SC_INVALID_NS.

If you'd rather go with this patch instead of the configfs approach,
I'll post a v2 with the fixes, and some associated blktests that
Chaitanya requested.

Thank you all for the reviews!

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
