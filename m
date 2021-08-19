Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE83C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0659361151
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0659361151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JVyyl6D0nWB7WpTyHiXJxxC2AG6CssoFcI8vShYOMOo=; b=HcBTsY4D7NA1eR
	799VCGzfUc+tRERx1t6cRKEk4Id1w9d2j4k+GPWjEvmMKuoev4LtjludNuJ+MJWblh88M5SRszCGF
	I1nEhR+LTMLE6YIspCevHrkMLdkgWNWgCoiLamYWmzCkXJLBIOCVboHftLwQyn3rCSjucdCnTZ/Nt
	p69lyOyfdEHbl4NnyeQfdPCEGM8ipJcXC83wydjqVx1w1HAvmx7uJtWF/YSNqRSLxX8dyPEWjyz5I
	rFeTyBDufuIjrT4diQIHqaODuJIM7WTqHO02vFrvrO501TBIXWYOManHQQJTwwdozk+JrDnuG/LI6
	R9pBRxtrdrXoolR5npQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGjRe-008hbR-8o; Thu, 19 Aug 2021 14:55:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGjRa-008haa-V4
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 14:55:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1009F6112E;
 Thu, 19 Aug 2021 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629384898;
 bh=1GYSxsQwSLlOvZD3wKyxcMmszzR7by5Sj5P50HztzH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qH7lHR50s32yoxMZ6w0j+uMXw9GZwZNFq1ZJT4zHBewxJypXtEJ5xZugLSx1RlzKo
 Au548UQIhqL7LNh5IT1K9dJutJEclA5QVK8Vr2cLCdl+AEm7D4c+eG6YltEA0vqlwq
 m4mabSNei0tu5EF/HI55hSCqeeP/HiTykEAk0d2imkt5C6aNQvPT64IPD2n0ZpsiAi
 XmMz+tYrgpqTIYehK7uRimEsUre62BABIfhwcy1YjGZdtudzZdSItBVd8okusu7Lx7
 bKbnj7Q8jVa5fYxawJyKdBljxec/CQkGNUZC81QynypXbc9M/lg1+/AQIiZk2Khp0D
 ygaC1FTEOqeOg==
Date: Thu, 19 Aug 2021 07:54:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
Message-ID: <20210819145455.GA227568@dhcp-10-100-145-180.wdc.com>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816131910.615153-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_075459_059110_97C17C68 
X-CRM114-Status: GOOD (  12.84  )
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

On Mon, Aug 16, 2021 at 03:19:02PM +0200, Christoph Hellwig wrote:
> @@ -3729,9 +3729,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (!ns)
>  		goto out_free_id;
>  
> -	ns->queue = blk_mq_init_queue(ctrl->tagset);
> -	if (IS_ERR(ns->queue))
> +	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
> +	if (IS_ERR(disk))
>  		goto out_free_ns;
> +	disk->fops = &nvme_bdev_ops;
> +	disk->private_data = ns;
> +
> +	ns->disk = disk;
> +	ns->queue = disk->queue;
>  
>  	if (ctrl->opts && ctrl->opts->data_digest)
>  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
> @@ -3740,20 +3745,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>  		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
>  
> -	ns->queue->queuedata = ns;
>  	ns->ctrl = ctrl;
>  	kref_init(&ns->kref);

With this removal, I don't find queuedata being set anywhere, but
the driver still uses it in various places expecting 'ns'. Am I missing
something? Should all nvme's queuedata references be changed to
q->disk->private_data?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
