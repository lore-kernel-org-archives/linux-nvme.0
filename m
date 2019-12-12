Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06AAC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C742F214AF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfzCrsuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C742F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8tsuJjFmjoa6hEsW2Psg05biEi0vHQpl00OzOvEy8h4=; b=cfzCrsuqI5xfwS
	3H/NUGTGQ4aMXXJfZcEVq/8ilOkybVJzI2ExF5cxCdjWr+8Eq/sglQIIwWQ3Xf/GRZI+tmUW8j/MI
	8AiWYDJUnTKxjE+CjXenE8BM2PpayUDN2WucA34sLdUTyV2ZG4FYsFEr64BbvrNLup4eXbBRf6Nuj
	fsUo7DoH56oyYhb6uo/nHHaknf9W7E0uK0yV6VZmzJLfaZD5JxR/2bWttylh4/cD0jVprDbQf/+8N
	LuwMKS7LhUc6icikFK7Qd7cEFWzGYugC1Y2yPF95NNLMMu36MLjvl9dQcZoudd0tfeCOjEInTGsq8
	Bkcy5EHY8XjgqwGtuvhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifLB7-0006TP-ND; Thu, 12 Dec 2019 09:54:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifLB4-0006SX-W7
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:54:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 59FF468B05; Thu, 12 Dec 2019 10:54:31 +0100 (CET)
Date: Thu, 12 Dec 2019 10:54:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Balbir Singh <sblbir@amazon.com>
Subject: Re: [RFC PATCH] block/genhd: Notify udev about capacity change
Message-ID: <20191212095431.GA3720@lst.de>
References: <20191210030131.4198-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210030131.4198-1-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_015435_182568_BE352943 
X-CRM114-Status: GOOD (  18.56  )
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
Cc: axboe@kernel.dk, mst@redhat.com, jejb@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Someswarudu Sangaraju <ssomesh@amazon.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 10, 2019 at 03:01:31AM +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify via udev if
> the current capacity or the target capacity is not zero.
> 
> disk_set_capacity() is not enabled for all devices, just virtio block,
> xen-blockfront, nvme and sd. Owners of other block disk devices can
> easily move over by changing set_capacity() to disk_set_capacity()
> 
> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> Testing:
> 1. I did some basic testing with an NVME device, by resizing it in
> the backend and ensured that udevd received the event.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
> ---
>  block/genhd.c                | 19 +++++++++++++++++++
>  drivers/block/virtio_blk.c   |  4 +---
>  drivers/block/xen-blkfront.c |  5 +----
>  drivers/nvme/host/core.c     |  2 +-
>  drivers/scsi/sd.c            |  2 +-
>  include/linux/genhd.h        |  1 +
>  6 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..94faec98607b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
>  
> +/*
> + * Set disk capacity and notify if the size is not currently
> + * zero and will not be set to zero

Nit: Use up all the 80 chars per line.  Also maybe turn this into a
kerneldoc comment.  I think you also want to mention the notification
as well.

> +EXPORT_SYMBOL_GPL(disk_set_capacity);
> +
> +
>  void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)

No need for the double empty line.

>  {
>  	if (queue_is_mq(q))
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7ffd719d89de..869cd3c31529 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c

And you probably want to turn this into a series with patch 1 adding
the infrastructure, and then one patch per driver switched over.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
