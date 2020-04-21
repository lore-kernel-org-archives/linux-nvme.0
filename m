Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D94BC54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:37:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC0A206F4
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3kFyo5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC0A206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OWf2QqaVxRlY8H6TQ+wHmHJCrTqr8i8j27mLt4hzxKE=; b=u3kFyo5xLOLYQ3
	/AXNnr9QnWd1mTTGgDdFVXz+M5OhtT3G9/nVbVv64f1O39KuMdvoo70LeMNfUkNyAGolv3voePUAR
	mGYuyG6flzSjckVwMA9qDkgEG00cWYj9u+cMXYauetG3lqFPdzf8w3Ewsd1eaAA5BgoiYkmfRvDea
	h8RpMtPDs/iFrsifJMQfKkj9cN8tjWoeObD1mZG8+4DRWMOngQepnuQxPwpX/Ysfm+SsQvh2aBzbb
	Uisa05BOcGd7ZrKvTza6lERpHorIkwawqTev64ZHA9G5hOVaPqldYywu30uNvn+ASJ8keSXlWa+hi
	ZoHskjKxZw321BT4m8ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQuy7-0003tL-Ta; Tue, 21 Apr 2020 15:37:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQuy3-0003m8-Dn
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 15:37:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7AF7968C4E; Tue, 21 Apr 2020 17:37:44 +0200 (CEST)
Date: Tue, 21 Apr 2020 17:37:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 17/17] nvmet-rdma: Add metadata/T10-PI support
Message-ID: <20200421153744.GG10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-19-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-19-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_083747_630119_8E854E98 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  /* Assume mpsmin == device_page_size == 4KB */
>  #define NVMET_RDMA_MAX_MDTS			8
> +#define NVMET_RDMA_MAX_MD_MDTS			5

Can you spell out METADATA everywhere?

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	/* Data Out / RDMA WRITE */
> +	r->write_cqe.done = nvmet_rdma_write_data_done;
> +#endif
>  	return 0;
>  
>  out_free_rsp:
> @@ -498,6 +507,138 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
>  	spin_unlock(&queue->rsp_wr_wait_lock);
>  }
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY

Any chance we could use IS_ENABLED() instead of all these ifdefs?

> +	/*
> +	 * At the moment we hard code those, but in the future
> +	 * we will take them from cmd.
> +	 */

Same weird comment as on the host side.

> +	struct nvme_command *cmd = req->cmd;
> +	struct blk_integrity *bi = bdev_get_integrity(req->ns->bdev);
> +	u16 control = le16_to_cpu(cmd->rw.control);
> +
> +	WARN_ON(bi == NULL);

No need for this WARN_ON either I think.

> +	port->pi_capable = ndev->device->attrs.device_cap_flags &
> +			IB_DEVICE_INTEGRITY_HANDOVER ? true : false;

No need for the ? :, but then again personally I'd prefer a good old:

	if (ndev->device->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER)
		port->pi_capable = true;

anyway.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
