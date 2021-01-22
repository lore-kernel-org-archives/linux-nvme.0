Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B918CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:42:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05017235F9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05017235F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DxTLLlYKQ9IwVQpazshuD9QTLdEHbZFiHTLEtzVLrpo=; b=i95BnJ9froafdR8dlVWbT9MZy
	sAA5Y5ZdV7LME6l3W1HqVobrIUcXQK3Z5ME/UBurFNRqLC+c4EJ/s3pVp+hkeaSb/bpY4svsOgPK2
	MEuBtUsvfQd5anbb6+XdW5d5CKN6M/5dPycbPxfdMvRI/AlvB39yFsVKL4vq0ZNf++DT1+qoV3WZl
	TCjQBNatE+eQmHhw1qOkzHlhQ+k4k3w28JHXsuSugoZuZ4UjE8O+aYPdC5+OmBMDcegQGqnR6e1mw
	kurbyhzO54bXbOPGvNjd6511RbwYP4E1vhdZy69zQtz1VQcivA+EUzeHAgTu1Pn/M/GwX9mRnxHGQ
	P9+3V0iDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2s1K-00083F-9p; Fri, 22 Jan 2021 08:42:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2s1H-00081t-Bf
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:42:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 882E068AFE; Fri, 22 Jan 2021 09:42:09 +0100 (CET)
Date: Fri, 22 Jan 2021 09:42:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Message-ID: <20210122084209.GA15710@lst.de>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
 <20210122080014.174391-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210122080014.174391-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_034215_503921_C68B8B03 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> @@ -864,18 +891,20 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		 * partitions and zoned block device support is enabled, else
>  		 * we do nothing special as far as the block layer is concerned.
>  		 */
> -		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
> -		    disk_has_partitions(disk))
> -			model = BLK_ZONED_NONE;
> -		break;
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +		    !disk_has_partitions(disk))
> +			break;
> +		model = BLK_ZONED_NONE;
> +		fallthrough;
>  	case BLK_ZONED_NONE:
>  	default:
>  		if (WARN_ON_ONCE(model != BLK_ZONED_NONE))
>  			model = BLK_ZONED_NONE;
> +		q->limits.zone_write_granularity = 0;
>  		break;
>  	}
>  
> -	disk->queue->limits.zoned = model;
> +	q->limits.zoned = model;
>  }

This looks a little strange.  If we special case zoned vs not zoned
here anyway, why not set the zone_write_granularity to the logical
block size here by default.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
