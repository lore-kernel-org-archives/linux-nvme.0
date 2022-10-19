Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C054C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnNacsVxf3YZ/yiRosb8lJ/iQsw+P4AWbKc0V3i3E7k=; b=oXVomJ78yQsO9PNAii5yASOWVr
	+pe0Q8VpTFcXSlnMQdRUDvYpPttxMtcNBJ5x5QMbPK6pTFzrCsdkhhsZPgXqHfTytcENfZZ8FlsiL
	1lZ3HAFo+Q0m+kNv84uwOVRik9YWxqvnglw+EM2wpD+E+3f0lLO4qBtcvt5C7FY4WmoaEwVCjsCV1
	osMfB908LHJf5aDz1Aid2qyeS4Eopl6qfqjib3rrYIIbf/FXN0nL7ny/tE8qBRvewm+HWWe9rhLzL
	P0SePsOK6OL5fBD9IGD0/7214CWIsnCmGTtQxJ2wkKxqq1BM/B67BKgDCNJgYWBskMn9XdbTfufYm
	t5lVRZUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okxi0-00DGPJ-8k; Wed, 19 Oct 2022 01:17:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okxhx-00DGOc-Pr
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 01:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666142240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnNacsVxf3YZ/yiRosb8lJ/iQsw+P4AWbKc0V3i3E7k=;
	b=gLx/t3jxDbav/+w41Tu/D/cL/jtbuGOT7krrFVY/luP7lvsaxNCwmQyuFdb4QrlDHuISl5
	ealokmkUu9XpAVaNAA8Yu0vGVsC2X7M/m//kG5nWOwFcZzXwuuwynBhYjAR54TQTdFWS9a
	dVp8nIvYET8bG/aFXXzfmkdDXbDXpZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-2wkAFIfOP82X2ckKDvfswQ-1; Tue, 18 Oct 2022 21:17:17 -0400
X-MC-Unique: 2wkAFIfOP82X2ckKDvfswQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05BF38060A0;
	Wed, 19 Oct 2022 01:17:15 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 97A922166B41;
	Wed, 19 Oct 2022 01:17:01 +0000 (UTC)
Date: Wed, 19 Oct 2022 09:16:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/4] scsi: remove an extra queue reference
Message-ID: <Y09QCb5A+iL/Igoj@T590>
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018135720.670094-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_181722_079497_A8A39634 
X-CRM114-Status: GOOD (  21.07  )
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

On Tue, Oct 18, 2022 at 03:57:18PM +0200, Christoph Hellwig wrote:
> Now that blk_mq_destroy_queue does not release the queue reference, there
> is no need for a second queue reference to be held by the scsi_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/scsi_scan.c  | 1 -
>  drivers/scsi/scsi_sysfs.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 5d27f5196de6f..0a95fa787fdf4 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -344,7 +344,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
>  	sdev->request_queue = q;
>  	q->queuedata = sdev;
>  	__scsi_init_queue(sdev->host, q);
> -	WARN_ON_ONCE(!blk_get_queue(q));
>  
>  	depth = sdev->host->cmd_per_lun ?: 1;
>  
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 1214c6f07bc64..c95177ca6ed26 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1478,7 +1478,6 @@ void __scsi_remove_device(struct scsi_device *sdev)
>  	mutex_unlock(&sdev->state_mutex);
>  
>  	blk_mq_destroy_queue(sdev->request_queue);
> -	blk_put_queue(sdev->request_queue);

The above put is counter-pair of blk_get_queue() in scsi_alloc_sdev, and
the original blk_put_queue() in blk_mq_destroy_queue() is counter-pair of
the initial get in blk_alloc_queue().

Now blk_put_queue() is moved out of blk_mq_destroy_queue(), I am wondering
how the scsi queue lifetime can work correctly with this patch? Or is there
bug in current scsi code?


Thanks,
Ming


