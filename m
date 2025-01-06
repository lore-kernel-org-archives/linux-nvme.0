Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BED3E77197
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 03:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP7jolLUYxTGQVKFJKvtxIhzzFzEDzKghI1l/9u+ocU=; b=lhjc0RryqqRw94xxDWH5kMwVGe
	2g/3nz+Y5p+ZnhUMiLE0e77kqZauNyONGSbackWBJNTlOPZcq/8s6UgFZhEm2IfFQBy8TdEfusIvd
	3FEGDM5jRx+WMgaGs3InB1GsrQOBx/O232yb/Jd+FAXDKbKsbB46dx+xNtatsQ55juVITwmUQZl2J
	ighusD+D4NwqrOv/pYLS+y0dBmUyogird8onlGOaMP3CotonDums/mxZFT6VvY8V+XZ1OueE16x4V
	zZroVr4QHvWeqOu06yyvs4iiTKotc33I6fO7mbp5noZsr2yJKX4IwCedMXL9pDBtmAaQPO0A7Qct6
	aXN15Cpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUdrB-000000008dM-3x9f;
	Mon, 06 Jan 2025 03:32:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUdqV-000000008Wy-33Px
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 03:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736134321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wP7jolLUYxTGQVKFJKvtxIhzzFzEDzKghI1l/9u+ocU=;
	b=Yny2wJA0kjCcRzTkshGKBUMO88+7z541wTSmbEqCOrquFsCPo/1h6lgrj1o+KPb6OY4Q6y
	BL7d37I5rm2DbR9U9Uo22eHmA79A5WwReuhfrNPShr1YN/RzeIjcMFRzVOg6iL7rqfmrBl
	EfpOnBhknHta2zJUa081Pz4DponIw18=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-KcX282JuPk29GhOFRtX-TA-1; Sun,
 05 Jan 2025 22:31:57 -0500
X-MC-Unique: KcX282JuPk29GhOFRtX-TA-1
X-Mimecast-MFC-AGG-ID: KcX282JuPk29GhOFRtX-TA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 002351956053;
	Mon,  6 Jan 2025 03:31:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 630951956056;
	Mon,  6 Jan 2025 03:31:48 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:31:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3tOn4C5i096owJc@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-2-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_193203_841281_A5B17277 
X-CRM114-Status: GOOD (  23.95  )
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

On Sat, Jan 04, 2025 at 10:25:20PM +0900, Damien Le Moal wrote:
> queue_attr_store() always freezes a device queue before calling the
> attribute store operation. For attributes that control queue limits, the
> store operation will also lock the queue limits with a call to
> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> need to issue commands to a device to obtain limit values from the
> hardware with the queue limits locked. This creates a potential ABBA
> deadlock situation if a user attempts to modify a limit (thus freezing
> the device queue) while the device driver starts a revalidation of the
> device queue limits.
> 
> Avoid such deadlock by introducing the ->store_limit() operation in
> struct queue_sysfs_entry and use this operation for all attributes that
> modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
> definition. queue_attr_store() is modified to call the ->store_limit()
> operation (if it is defined) without the device queue frozen. The device
> queue freeze for attributes defining the ->stor_limit() operation is
> moved to after the operation completes and is done only around the call
> to queue_limits_commit_update().
> 
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 59 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 767598e719ab..4fc0020c73a5 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -24,6 +24,8 @@ struct queue_sysfs_entry {
>  	struct attribute attr;
>  	ssize_t (*show)(struct gendisk *disk, char *page);
>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
> +	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
> +			       const char *page, size_t count);

As I mentioned in another thread, freezing queue may not be needed in
->store(), so let's discuss and confirm if it is needed here first.

https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/

Also even though freeze is needed, I'd suggest to move freeze in each
.store() callback for simplifying & avoiding regression.


Thanks,
Ming


