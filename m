Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1BC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 05:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58D4610D2
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 05:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58D4610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OTcQ3szO7559pCcBfzB0fYSRNiBK+wka1SCfSPP08mY=; b=KOpwp/mwk+cDpb
	JkzmtyWLrqaPJ92bn+PV0p1zzrBQKol1rxfLsMITdYAQDtBq/gFzxqeU1pu9qHTtN8GDSBPMTs8QQ
	uQvcHq52ulqk1MBJbq/DJNBW1StyD+9k03u+AfYRgDoHxE/njRk/HknjlEhkGNY16NtddxiYfscuM
	IX1WqpiJKDi7xFOeEZipSF4hMZY6FyNCWu9hzTnfA9kJu1nJHwEWIkfI5Ae0/g71yjt1A8tzzbt1/
	pNE3nMuigIvclwjbN2n4bTJ6889JTIf/csjbv+nSJTG4I5ZPDn4ghh+0sME6r32vBMr1aChLlGlOq
	WwJjnbjES14RR08nPXXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m64pr-00ETk0-C0; Wed, 21 Jul 2021 05:31:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m64pq-00ETjs-Ea
 for linux-nvme@bombadil.infradead.org; Wed, 21 Jul 2021 05:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UIe3t7U9ttMqTuOm5HTkTK76a1TyJwwc0+hE6h3VkC4=; b=awd14+cLFPTgHWZF5axFBezG9F
 +D5ie/GWOlOI0peJ8ORqGb/YcqfuXmD6lHdkS1yIFubBw+Xs4PgUqAQnb4CW6qBqvWe0NcC3zQRTR
 Ruh6mTXE/7reHGLTMhoVERl6SBk8R1bo5nAATE8wMb8nkEh5kmTZ1KgGkqZU7UHfJIJSKhAkCCdih
 xy6NDh9Gs2K9aiE8lqnOU7cxXdGOUnqtycxm+yyZiXjlcmJqJ1C+b//G8Y3BToU8XZ7LI7hmi6izK
 DJq+i5c7KvCb7xzN0mIHIT70bINQw/5sAEX196faFlLokH/sCfLzNWdx9nonM0SiH5aTGGu4veuWi
 WqRSe+Sw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m64pe-008pi3-Bh; Wed, 21 Jul 2021 05:31:49 +0000
Date: Wed, 21 Jul 2021 06:31:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 hch@infradead.org, jack@suse.cz, osandov@fb.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH 4/5] nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Message-ID: <YPexQv88hGXxBoLE@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <20210720182048.1906526-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720182048.1906526-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 20, 2021 at 11:20:47AM -0700, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/nvme/host/core.c      | 4 ++--
>  drivers/nvme/host/multipath.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be42186..7be78491c838 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1819,7 +1819,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  static inline bool nvme_first_scan(struct gendisk *disk)
>  {
>  	/* nvme_alloc_ns() scans the disk prior to adding it */
> -	return !(disk->flags & GENHD_FL_UP);
> +	return !(blk_disk_added(disk));
>  }

So this on is obviously right as it wants to check for the probe
time scan.  Although we don't need the braces.

>
>  
>  static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
> @@ -3823,7 +3823,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	nvme_mpath_clear_current_path(ns);
>  	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>  
> -	if (ns->disk->flags & GENHD_FL_UP) {
> +	if (blk_disk_added(ns->disk)) {

This is something that goes back to before the damn of time, but I do
not think we actually need it.  All the errors paths before alloc_disk
and add_disk just directly free the ns and never end up here.

>  		if (!nvme_ns_head_multipath(ns->head))
>  			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>  		del_gendisk(ns->disk);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0ea5298469c3..f77bd2d5c1a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -764,7 +764,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>  {
>  	if (!head->disk)
>  		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> +	if (blk_disk_added(head->disk)) {
>  		nvme_cdev_del(&head->cdev, &head->cdev_device);
>  		del_gendisk(head->disk);
>  	}

This one is sort of correct due to the lazy disk addition.  But we
could and probably should check for NVME_NSHEAD_DISK_LIVE instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
